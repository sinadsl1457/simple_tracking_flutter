# Flutter 앱 아키텍처 규칙

> fence(울타리) 프로젝트 회고를 바탕으로 정리한 규칙. 새 프로젝트 루트에 `CLAUDE.md`로 두고 사용.

## 스택
- 상태관리: flutter_bloc (Cubit 우선). provider 등 다른 상태관리 혼용 금지.
- DI: get_it + injectable (자동 생성만 사용, 외부 객체(Dio 등)는 `@module`로만 등록).
- 네트워크: dio + retrofit. http 패키지 사용 금지.
- 모델: freezed + json_serializable.
- 라우팅: go_router (Navigator 직접 호출 금지, 라우트는 한 파일에서 선언).
- 로깅: logger 패키지 래퍼만 사용. `print()` 금지 (lint로 강제: `avoid_print`).

## 레이어와 의존 방향 (반드시 지킬 것)
`presentation → domain ← data`
- domain: 순수 Dart. Flutter/dio/json 패키지 import 금지.
  Entity, Repository 인터페이스(abstract), (필요할 때만) UseCase.
- data: DTO, Retrofit Service, Repository 구현체. DTO → Entity 변환(mapper)은 data에서.
- presentation: Page/Widget + Cubit. Entity만 사용, DTO import 금지.
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
- 로직 없는 pass-through UseCase는 만들지 않는다. Cubit → Repository 직접 호출 허용.
- 여러 repository 조합, 비즈니스 규칙이 있을 때만 UseCase 생성.

## 상태
- 전역 상태는 책임별로 분리: AuthCubit(세션/토큰), UserCubit(내 정보), AppConfigCubit 등.
  하나의 "Environment" 거대 Bloc 금지.
- Cubit/Bloc 안에서 BuildContext, Navigator, 위젯, 다이얼로그 import 금지.
  네비게이션/토스트는 state 또는 일회성 effect 스트림으로 내보내고 UI가 BlocListener로 처리.
- 다른 Cubit 상태를 `getIt<XCubit>().state`로 꺼내 읽지 말 것. 필요한 값은 파라미터로 받거나 스트림 구독.
- 위젯에서 getIt 직접 호출 금지. `BlocProvider(create: (_) => getIt<XCubit>())`는 라우트에서만.
- State·Effect 모델(freezed, sealed class)은 Cubit 파일에 두지 않고 `<name>_state.dart`로 분리한다.
  Cubit 파일에는 Cubit 클래스(로직)만 둔다. 예: `map_cubit.dart` + `map_state.dart`.

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
- 비동기 초기화(SharedPreferences 등)는 `@preResolve` 또는 main에서 await 후 DI 등록.
  생성자 안 `Future.delayed` 초기화 금지.

## 코드 품질
- 파일 300줄, 위젯 build 메서드 80줄 초과 시 분리.
- 네이밍 오타 금지: 폴더/클래스명은 영어 사전 철자 그대로 (presentation, schedule 등).
- flutter_lints + very_good_analysis 수준 lint 적용.
- 테스트: Repository(mock Service), Cubit(bloc_test) 단위 테스트를 기능마다 최소 1개.
- 주석/로그에 이모지 남발 금지, 의미 있는 로그 레벨 사용.
- 주석(리뷰용): 모든 파일 맨 위에 2~4줄 머리 주석 — 역할 / 누가 부르는지 / 함께 볼 파일.
  Cubit·Repository·플러그인 API의 public 메서드는 "언제 호출되고 무엇을 내보내는지"를 적는다.
  코드를 그대로 읽어 주는 주석은 쓰지 않는다. 구조는 docs/ARCHITECTURE.md(읽기 순서, 흐름)에 두고 갱신한다.

## iOS 최신 대응
- UIScene 라이프사이클(FlutterSceneDelegate + FlutterImplicitEngineDelegate) 기본 적용.
  AppDelegate에서 `window?.rootViewController` 직접 접근 금지.
- 기존 CocoaPods 프로젝트에서 SPM 마이그레이션이 실패하면 pubspec에
  `flutter: config: enable-swift-package-manager: false`.
