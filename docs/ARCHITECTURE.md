# simple_tracking 구조 안내서

네이티브 심플맵(SimpleTrackingiOS / simpleTracking Android)을 Flutter로 옮긴 앱.
규칙은 루트의 `CLAUDE.md`를 따른다. 이 문서는 **코드를 어디서부터, 어떤 순서로 읽으면 되는지** 안내한다.
처음 보는 어노테이션·문법은 `docs/GLOSSARY.md`.

---

## 1. 한눈에 보기

```
lib/
├ main.dart / app.dart          시작점, 라우트(go_router), Cubit 생성(BlocProvider)
├ core/                         기능과 무관한 공통 코드
│  ├ config/   app_config       --dart-define 값(카카오 키, 고정 위치)
│  ├ di/       injection        get_it + injectable 설정 (Dio, SharedPreferences 등록)
│  ├ error/    failure, result  모든 실패 종류(sealed)와 Ok/Err 결과 타입
│  ├ geo/      geo_point, math  좌표와 거리 계산
│  ├ network/  safe_api_call    HTTP 오류 → Failure 변환, 카카오 인증 헤더
│  └ presentation/              EffectEmitter(일회성 이벤트), 하단 시트, 토스트, 포맷터
└ features/                     기능별. 각 기능 안에 domain / data / presentation
   ├ location/   내 위치 (지금은 고정 위치. 7단계에서 GPS)
   ├ place/      장소 검색, 최근 검색어, 최근 장소
   ├ route/      길찾기 (자동차·도보·대중교통), 길찾기 준비 화면, 출발지·도착지 선택
   └ map/        지도 화면(MapScreen) — 위 세 기능을 조립하는 곳

packages/kakao_map_view/        카카오맵 SDK를 Flutter 위젯으로 쓰게 하는 로컬 플러그인
├ pigeons/messages.dart         Dart↔Native 인터페이스 설계도 (여기서 코드 생성)
├ lib/                          KakaoMapView 위젯, KakaoMapController
├ ios/kakao_map_view/Sources/   Swift 구현
└ android/src/main/kotlin/      Kotlin 구현 (파일 이름·역할이 Swift와 1:1)
```

## 2. 레이어와 의존 방향

```
presentation ──→ domain ←── data
 (Cubit, 위젯)    (모델, 규칙,      (카카오 API, DTO,
                  저장소 인터페이스)   저장소 구현)
```
- **domain**은 아무것도 모른다. Flutter·dio·JSON import 없음. 여기만 읽어도 앱이 무엇을 하는지 알 수 있다.
- **data**는 domain의 `XxxRepository` 인터페이스를 구현한다. DTO → 도메인 변환(mapper)도 여기.
- **presentation**은 domain 모델만 쓴다. DTO를 모른다.
- 연결은 `injectable`이 한다: `@LazySingleton(as: PlaceRepository)`가 붙은 구현체가 인터페이스 자리에 들어간다
  (`core/di/injection.config.dart`는 생성 파일).

## 3. 리뷰 추천 순서

| 순서 | 읽을 곳 | 이유 |
|---|---|---|
| 1 | `core/error/failure.dart`, `result.dart` | 모든 계층이 결과를 이 타입으로 주고받는다 |
| 2 | `features/*/domain/` | 모델과 규칙(UseCase). 짧고 순수 Dart. 테스트가 사양서 역할 |
| 3 | `core/network/safe_api_call.dart` → `features/place/data/` | 네트워크 한 바퀴: Retrofit API → DTO → mapper → Repository |
| 4 | `core/presentation/effect_cubit.dart`, `widgets/effect_listener.dart` | Cubit이 "상태"와 "일회성 이벤트"를 나누는 방식 |
| 5 | `features/*/presentation/cubit/` | 화면 로직. 테스트(`test/features/...`)를 같이 보면 동작이 보인다 |
| 6 | `features/map/presentation/map_screen.dart` | 모든 것을 조립하는 화면. 가장 길다 |
| 7 | `packages/kakao_map_view/` | 네이티브 연결. 아래 5절 참고 |

테스트 파일 이름은 대상 파일과 같다(`route_cubit.dart` ↔ `route_cubit_test.dart`).
테스트 이름이 한국어 문장이라 **테스트 목록이 곧 기능 명세**다.

## 4. 주요 흐름

### 4-1. 카테고리 검색 (카페 칩)
```
CategoryChips 탭
→ PlaceSearchCubit.toggleCategory(cafe, around: 지도 중심)
→ SearchPlacesByCategoryUseCase → PlaceRepository(Impl) → KakaoPlaceApi(GET category.json)
→ state.phase = loaded(places)            → MapScreen이 하단 시트·지도 핀을 그림
→ effect fitCamera(points)               → MapScreen이 지도 카메라를 맞춤
```

### 4-2. 길찾기 (검색창 옆 파란 버튼)
```
_DirectionsButton → RoutePlannerPage(push)
  출발지 기본 = 내 위치, 최근 장소 탭 = 도착지
  두 지점이 정해지면 RoutePlannerCubit이 effect completed(RoutePlan) → 페이지가 pop(plan)
→ MapScreen이 받은 plan으로 RouteCubit.plan(...)
→ 세 이동 수단을 동시에 조회(Future.wait), 도착하는 대로 state.results에 반영
→ state.overlay(지도에 그릴 선) 변경 → MapScreen의 BlocListener가 지도에 showRoute
```

### 4-3. Cubit → 지도 반영 (MapScreen)
Cubit은 지도를 모른다. MapScreen이 두 통로로 지도에 전달한다.
- **상태 변화** → `BlocListener` (예: `myLocation` 바뀜 → `updateMyLocation`)
- **일회성 이벤트** → `EffectListener` (예: `moveCamera`, 토스트)
- 지도가 준비되기 전 카메라 명령은 `_pendingCamera`에 보관했다가 `onMapCreated`에서 실행.

#### 왜 effect 스트림인가 (공식 가이드가 아님)
`EffectEmitter`/`EffectListener`는 직접 만든 작은 코드다. 출처: 네이티브 SimpleTrackingiOS의
`MapViewModel.effects`(AsyncStream) 구조, 같은 아이디어의 커뮤니티 패키지 `bloc_presentation`.
- bloc 공식 문서·Android 공식 가이드는 오히려 **state에 넣고 처리 후 consume**하는 쪽을 권장한다(fence 방식).
- 여기서 effect를 쓴 이유: 카메라 이동·토스트·권한 팝업처럼 **놓쳐도 다시 할 필요 없는 일**이라서.
- 결제 완료 이동처럼 **절대 놓치면 안 되는 이벤트**는 state + consume이 더 안전하다.
- 팀 표준으로 쓸 때는 `bloc_presentation` 패키지로 바꿔도 구조는 같다.

## 5. 지도 플러그인 (packages/kakao_map_view)

```
Dart  KakaoMapView 위젯 ── iOS: UiKitView / Android: PlatformViewLink (viewType, creationParams{appKey, channelId})
                                 │ Flutter 엔진이 viewType으로 팩토리를 찾음
Native KakaoMapViewPlugin (등록) → KakaoMapViewFactory.create
        → KakaoMapPlatformView (지도 뷰 1개 = 이 객체 1개)
            ├ KakaoMapController : 카카오 SDK 조작 (네이티브 앱 코드 이식)
            └ Pigeon 채널 (이름 뒤에 channelId)
                ├ HostApi    Dart → Native : moveCamera, fitCamera, showPlaceMarkers, showRoute, updateMyLocation
                └ FlutterApi Native → Dart : onMapReady, onMapError, onCameraIdle, onMarkerTapped
```

| | iOS (Swift) | Android (Kotlin) |
|---|---|---|
| Dart 위젯 | `UiKitView` | `PlatformViewLink` + `initExpensiveAndroidView` (Hybrid Composition. 지도가 SurfaceView라서) |
| 앱 백그라운드 | 지도가 NotificationCenter(앱 상태)를 직접 구독 | 플러그인이 `ActivityAware`로 Activity 생명주기를 받아 `MapView.resume/pause` |
| 정리 | `deinit` (PlatformView에 dispose 없음) | `PlatformView.dispose()` |
| SDK 저장소 | SPM `KakaoMapsSDK-SPM` | 카카오 maven 저장소. **앱의 `android/build.gradle.kts`에도 추가해야 한다** |
| FlutterApi 호출 | `Task { try? await … }` | Pigeon Kotlin이 `suspend` → 코루틴(`Dispatchers.Main`) |
| fitCamera 계산 | 비율로 영역 확장 | 네이티브 Android 앱의 `CameraFit.kt` (보이는 띠 기준) |
- **인터페이스를 바꿀 때**: `pigeons/messages.dart` 수정 → `dart run pigeon --input pigeons/messages.dart`
  → 컴파일 에러가 나는 Swift/Kotlin 구현을 채운다. `*.g.*` 파일은 직접 고치지 않는다.
- **Xcode에서 보기**: `ios/Runner.xcworkspace` → Package Dependencies → `kakao_map_view (local)`.
- **Android Studio에서 보기**: `android/` 폴더를 열면 `kakao_map_view` 모듈로 보인다.
- **카카오 콘솔**: Android는 패키지명(`com.sintaek.simple_tracking`)과 키 해시가 등록돼 있어야 지도가 뜬다.
- 플러그인은 앱 도메인을 모른다. 도메인 → 플러그인 타입 변환은 `features/map/presentation/map_overlay_mapper.dart`.

## 6. 실행

```bash
flutter run --dart-define-from-file=env/dev.json     # 키가 없으면 "API 키가 필요해요" 화면
dart run build_runner build -d                       # freezed / json / retrofit / injectable 생성
flutter test
```
VS Code는 `.vscode/launch.json`(F5)에 위 옵션과 시뮬레이터가 들어 있다.

## 7. 알아 두면 좋은 함정 (실제로 겪은 것)

| 증상 | 원인 | 위치 |
|---|---|---|
| 하단 시트가 안 끌림 | `DraggableScrollableSheet.snapSizes`를 빌드마다 새 리스트로 넘김 (객체 동일성 비교) | `map_bottom_sheet.dart` |
| 백그라운드 후 위치 구독 재시작 안 됨 | `async*` 안에서 끝나지 않는 await → `cancel()`이 끝나지 않음 | `fixed_location_repository.dart`, `map_cubit.dart` |
| Retrofit 생성 코드 컴파일 에러 | `@Query` 기본값 상수를 클래스명 없이 복사 → `KakaoPlaceApi.pageSize`로 써야 함 | `kakao_place_api.dart` |
| analyzer가 컴파일 에러를 못 잡음 | 생성 파일을 analyzer에서 exclude | `analysis_options.yaml` |
| 첫 `onMapReady`를 놓칠 수 있음 | Flutter viewId는 뷰 생성 후에야 알 수 있음 → Dart가 만든 channelId 사용 | `kakao_map_view.dart` |
