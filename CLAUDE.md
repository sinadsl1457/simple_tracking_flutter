# Flutter 앱 아키텍처 규칙

> fence(울타리) 프로젝트 회고를 바탕으로 정리한 규칙. 새 프로젝트 루트에 `CLAUDE.md`로 두고 사용.

## 스택
- 상태관리 + DI: **Riverpod(`riverpod` 브랜치, 전부 옮김).** `@riverpod` Notifier, riverpod_generator.
  get_it·injectable·flutter_bloc은 없다(`main` 브랜치가 옮기기 전 Cubit 버전). 전환 기록: `docs/riverpod_guide.md`.
  - Notifier: 지도(MapNotifier), 장소 검색(PlaceSearchNotifier), 길찾기(RouteNotifier·RoutePlannerNotifier·
    EndpointSearchNotifier), 푸시(PushNotifier, keepAlive — MaterialApp 위 PushEffectListener가 watch해 앱 시작과 함께 깨운다).
  - 조립: 기능마다 `data/xxx_providers.dart`에 API → 저장소 → UseCase 사슬. 공통 Dio는 `core/network/dio_provider.dart`,
    SharedPreferences는 `core/storage/shared_preferences_provider.dart`(빈 자리, main이 await 후 override로 채움).
  - 길찾기 Notifier 셋은 화면마다 따로 산다(autoDispose): 결과=지도 화면, 준비=준비 화면, 검색=선택 페이지.
    경로 목록 페이지(RouteListPage)는 따로 Notifier를 두지 않고 RouteNotifier를 같이 본다
    (목록 ↔ 지도를 오가는 한 흐름이고, 지도 화면이 아래에 살아 있어 상태가 유지된다).
- Riverpod 규칙: 상태 클래스는 `XxxNotifier`(파일 `xxx_notifier.dart`) + `xxx_state.dart`(freezed).
  의존성은 provider로 주입(`ref.watch(xxxProvider)`), 테스트는 `ProviderContainer.test(overrides: ...)`.
  화면에 붙은 상태는 autoDispose(기본값), 앱 수명 객체(저장소)는 `@Riverpod(keepAlive: true)`.
  await 뒤에 state를 바꾸기 전 `ref.mounted`를 확인한다. 일회성 이벤트는 `EffectChannel`(core/presentation).
- DI: provider. API·저장소·Dio는 `@Riverpod(keepAlive: true)`, UseCase는 `@riverpod`.
  저장소 provider의 반환 타입은 domain 인터페이스. 클래스에는 DI 어노테이션을 붙이지 않는다(domain은 순수 Dart).
- 네트워크: dio + retrofit. http 패키지 사용 금지.
- 모델: freezed + json_serializable.
- 라우팅: go_router (Navigator 직접 호출 금지, 라우트는 한 파일에서 선언).
- 로깅: logger 패키지 래퍼만 사용. `print()` 금지 (lint로 강제: `avoid_print`).

## 레이어와 의존 방향 (반드시 지킬 것)
`presentation → domain ← data`
- domain: 순수 Dart. Flutter/dio/json 패키지 import 금지.
  Entity, Repository 인터페이스(abstract), (필요할 때만) UseCase.
- data: DTO, Retrofit Service, Repository 구현체. DTO → Entity 변환(mapper)은 data에서.
- presentation: Page/Widget + Notifier. Entity만 사용, DTO import 금지.
- data/domain은 presentation을 절대 import하지 않는다.
  인증 만료 같은 이벤트는 `AuthSessionStream` 등 domain 쪽 스트림으로 알리고 UI가 구독.

## 폴더 구조 (feature-first)
```
lib/
  core/        (network, error, storage, logger, di, router, theme)
  features/<feature>/{data,domain,presentation}/
  shared/      (공용 위젯, extension)
```

## 에러 처리
- Result 타입: `sealed class Failure { Network, Unauthorized, Server(code, msg), Parse, Unknown }`.
  `Either<String, T>` 금지.
- Repository의 try/catch는 공통 함수 하나로: `Future<Result<T>> safeApiCall(() => ...)`.
  각 메서드마다 catch 블록 복붙 금지.
- `BaseResponse(success/message/data)` 언래핑도 `safeApiCall` 안에서 처리.

## UseCase
- 로직 없는 pass-through UseCase는 만들지 않는다. Notifier → Repository 직접 호출 허용.
- 여러 repository 조합, 비즈니스 규칙이 있을 때만 UseCase 생성.

## 상태
- 전역 상태는 책임별로 분리: AuthNotifier(세션/토큰), UserNotifier(내 정보), AppConfigNotifier 등.
  하나의 "Environment" 거대 Notifier 금지.
- Notifier 안에서 BuildContext, Navigator, 위젯, 다이얼로그 import 금지.
  네비게이션/토스트는 state 또는 일회성 effect(`EffectChannel`)로 내보내고 UI가 ref.listen/EffectListener로 처리.
- 다른 Notifier 상태가 필요하면 build에서 `ref.watch`, 메서드에서 `ref.read`. 위젯 initState에서 provider 상태를 바꾸지 않는다
  (처음 값은 family 인자로).
- State·Effect 모델(freezed, sealed class)은 Notifier 파일에 두지 않고 `<name>_state.dart`로 분리한다.
  Notifier 파일에는 로직만 둔다. 예: `map_notifier.dart` + `map_state.dart`.

## 인증/네트워크
- 토큰 주입은 Interceptor 한 곳에서만. `dio.options.headers` 직접 수정 금지.
- refresh는 401 응답(onError) 기준 + 동시 요청 단일화(Completer/Lock).
- 인증 제외 URL은 `RequestOptions.extra['skipAuth'] = true`로 표시 (문자열 contains 매칭 금지).

## 보안
- 시크릿 키(결제 REST secret, 서버 API secret 등)는 앱에 절대 포함하지 않는다.
  결제 검증/토큰 발급은 반드시 서버에서. 앱은 imp_uid 등 식별자만 서버로 전달.
- 환경 분리: `--dart-define-from-file=env/dev.json | prod.json`. isProd/isDebug 하드코딩 금지.
  `kReleaseMode`와 flavor로 결정.
- 토큰은 flutter_secure_storage, 일반 설정은 shared_preferences.

## 초기화
- 비동기 초기화(SharedPreferences 등)는 main에서 await 후 `ProviderScope(overrides:)`로 빈 자리 provider를 채운다.
  생성자 안 `Future.delayed` 초기화 금지.

## 코드 품질
- 파일 300줄, 위젯 build 메서드 80줄 초과 시 분리.
- 네이밍 오타 금지: 폴더/클래스명은 영어 사전 철자 그대로 (presentation, schedule 등).
- flutter_lints + very_good_analysis 수준 lint 적용.
- 테스트: Repository(mock Service), Notifier(`ProviderContainer.test(overrides:)`) 단위 테스트를 기능마다 최소 1개.
- 주석/로그에 이모지 남발 금지, 의미 있는 로그 레벨 사용.
- 주석(리뷰용): 모든 파일 맨 위에 2~4줄 머리 주석 — 역할 / 누가 부르는지 / 함께 볼 파일.
  Notifier·Repository·플러그인 API의 public 메서드는 "언제 호출되고 무엇을 내보내는지"를 적는다.
  코드를 그대로 읽어 주는 주석은 쓰지 않는다. 구조는 docs/ARCHITECTURE.md(읽기 순서, 흐름)에 두고 갱신한다.

## iOS 최신 대응
- UIScene 라이프사이클(FlutterSceneDelegate + FlutterImplicitEngineDelegate) 기본 적용.
  AppDelegate에서 `window?.rootViewController` 직접 접근 금지.
- 기존 CocoaPods 프로젝트에서 SPM 마이그레이션이 실패하면 pubspec에
  `flutter: config: enable-swift-package-manager: false`.
