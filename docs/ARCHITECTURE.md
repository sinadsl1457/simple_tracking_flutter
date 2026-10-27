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
│  ├ config/   app_config       --dart-define 값(카카오 키, 고정 위치, 푸시 켜기)
│  ├ di/       injection        get_it + injectable 설정 (Dio, SharedPreferences 등록)
│  ├ error/    failure, result  모든 실패 종류(sealed)와 Ok/Err 결과 타입
│  ├ geo/      geo_point, math  좌표와 거리 계산
│  ├ network/  safe_api_call    HTTP 오류 → Failure 변환, 카카오 인증 헤더
│  └ presentation/              EffectEmitter(일회성 이벤트), 하단 시트, 토스트, 포맷터
└ features/                     기능별. 각 기능 안에 domain / data / presentation
   ├ location/   내 위치 (GPS: geolocator / FIXED_LOCATION이 있으면 고정 좌표)
   ├ place/      장소 검색, 최근 검색어, 최근 장소
   ├ route/      길찾기 (자동차·도보·대중교통), 길찾기 준비 화면, 출발지·도착지 선택
   ├ push/       푸시 알림(FCM). 앱 전체에 하나뿐인 PushCubit — 화면 없이 app.dart에 붙는다
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

### 4-4. 푸시 알림 (features/push)

화면 하나에 속하지 않는 **앱 전체 기능**을 이 구조에 넣는 예. 레이어마다 하는 일이 정확히 한 가지다.

| 파일 | 레이어 | 하는 일 | 모르는 것 |
|---|---|---|---|
| `domain/push_message.dart` | domain | 앱이 이해하는 메시지와 "갈 곳"(sealed `PushDestination`) | Firebase, 화면 경로 |
| `domain/push_repository.dart` | domain | 바깥(FCM)의 입구 계약: 권한, 토큰, 수신 스트림 3개 | 탭하면 어디로 갈지 |
| `data/push_message_mapper.dart` | data | 서버 페이로드 `{"type","query"}` → `PushDestination`. **페이로드 형식을 아는 유일한 곳** | |
| `data/fcm_push_repository.dart` | data | firebase_messaging을 감싸고 도메인 모델로 바꿔 내보냄 | 화면, Cubit |
| `data/disabled_push_repository.dart` | data | Firebase 설정 전에 쓰는 빈 구현 | |
| `data/push_module.dart` | data | `PUSH_ENABLED`로 둘 중 하나를 싱글턴 등록 (`location_module.dart`와 같은 모양) | |
| `data/fcm_setup.dart` | data | DI 전에 `Firebase.initializeApp()` + 백그라운드 핸들러 | |
| `presentation/cubit/push_cubit.dart` | presentation | 수신 경로 3가지를 effect 2개(`open`, `showInApp`)로 모음 | BuildContext, router |
| `presentation/push_effect_listener.dart` | presentation | effect → 스낵바 / `onOpen` 호출 | 어느 경로로 갈지 |
| `app.dart` `_openPushDestination` | 앱 셸 | `PushDestination` → URL(`/?q=카페`) → `router.go` | |

```
FCM ─→ FcmPushRepository ─(PushMessage)─→ PushCubit ─(PushEffect)─→ PushEffectListener
        RemoteMessage를                     어떤 일인지 고름            ├ showInApp → 스낵바("보기" → cubit.openInApp)
        도메인으로 바꿈                                                 └ open → app.dart가 경로로 바꿔 router.go
                                                                           → MapScreen(searchQuery) → 검색
```

**수신 경로 3가지** — 이게 푸시 코드가 복잡해지는 원인이라 Cubit 한 곳에서 모은다.

| 앱 상태 | 알림을 누가 띄우나 | 들어오는 곳 | Cubit이 내는 effect |
|---|---|---|---|
| 앞에 떠 있음 | 아무도 (OS가 안 띄움) | `foregroundMessages()` | `showInApp` |
| 백그라운드 → 탭 | OS | `openedMessages()` | `open` |
| 꺼져 있음 → 탭해서 실행 | OS | `initialMessage()` (스트림이 아니라 한 번 꺼냄) | `open` |

**왜 이렇게 나눴나**
- **싱글턴은 repository, Cubit은 하나만 만듦**: `PushRepository`는 `@lazySingleton`. `PushCubit`은 `@injectable`(팩토리)이지만
  `app.dart`의 `MaterialApp` 위에서 한 번만 만들어서 앱 수명 동안 하나다. 아무 데서나 `getIt<...>()`로 꺼내지 않는다.
- **인터페이스가 실제로 일하는 곳**: 구현이 둘(`Fcm`/`Disabled`)이라 Cubit·app.dart에 `if (pushEnabled)`가 없다.
  테스트는 `FakePushRepository`로 Firebase 없이 돈다.
- **경로는 app.dart만 안다**: domain은 "검색하러 가라"까지만 말한다. 라우트 구조가 바뀌어도 domain·data·Cubit은 그대로.
  나중에 딥링크(웹 링크로 앱 열기)도 같은 `/?q=` 경로로 들어오게 할 수 있다.
- **백그라운드 핸들러는 DI 밖**: 별도 isolate라 get_it·Cubit이 비어 있다. `fcm_setup.dart`의 top-level 함수가 최소한만 한다.
- **토큰 → 서버**: 지금은 서버가 없어서 `PushState.token`에만 둔다. 서버가 생기면
  `DeviceApi`(Retrofit) + `DeviceRepository`를 만들고, `PushCubit._onToken`에서 "토큰 등록" UseCase(두 repo 조합)를 부른다.
- **FCM 17 토큰 API**: `getToken()`이 deprecated, `register()` → `onRegistered`로 바뀌었다. 이 두 단계를 `tokens()` 스트림 하나로 감췄다.

## 5. 지도 플러그인 (packages/kakao_map_view)

```
Dart  KakaoMapView 위젯 ── iOS: UiKitView / Android: PlatformViewLink (viewType, creationParams{appKey, channelId})
                                 │ Flutter 엔진이 viewType으로 팩토리를 찾음
Native KakaoMapViewPlugin (등록) → KakaoMapViewFactory.create
        → KakaoMapPlatformView (지도 뷰 1개 = 이 객체 1개)
            ├ KakaoMapController : 카카오 SDK 조작 (네이티브 앱 코드 이식)
            └ Pigeon 채널 (이름 뒤에 channelId)
                ├ HostApi    Dart → Native : moveCamera, fitCamera, showPlaceMarkers, showRoute, updateMyLocation, setFollowMode
                └ FlutterApi Native → Dart : onMapReady, onMapError, onCameraIdle, onMarkerTapped, onUserGesture
```

| | iOS (Swift) | Android (Kotlin) |
|---|---|---|
| Dart 위젯 | `UiKitView` | `PlatformViewLink` + `initExpensiveAndroidView` (Hybrid Composition. 지도가 SurfaceView라서) |
| 앱 백그라운드 | 지도가 NotificationCenter(앱 상태)를 직접 구독 | 플러그인이 `ActivityAware`로 Activity 생명주기를 받아 `MapView.resume/pause` |
| 정리 | `deinit` (PlatformView에 dispose 없음) | `PlatformView.dispose()` |
| SDK 저장소 | SPM `KakaoMapsSDK-SPM` | 카카오 maven 저장소. **앱의 `android/build.gradle.kts`에도 추가해야 한다** |
| FlutterApi 호출 | `Task { try? await … }` | Pigeon Kotlin이 `suspend` → 코루틴(`Dispatchers.Main`) |
| fitCamera 계산 | 비율로 영역 확장 | 네이티브 Android 앱의 `CameraFit.kt` (보이는 띠 기준) |
| 내 위치 마커 이동 | `Poi.moveAt` / `rotateAt` (duration ms) | `Label.moveTo` / `rotateTo` (duration ms) |

**내 위치 마커 애니메이션** — Dart는 `updateMyLocation(MyLocation)`만 보내고, 부드럽게 잇는 건 네이티브가 한다.
- 이동·회전 모두 1초(GPS 갱신 간격)에 걸쳐 이전 값에서 새 값으로. 짧으면 매초 멈칫하고, 길면 다음 갱신이 중간에 끊는다.
- 회전은 직전 각도에서 가까운 쪽으로 이어 붙인다(`continuousRoll` / `continuousRotation`). 359° → 1°는 +2°만 돈다.
- 100m 넘게 뛰면(GPS 재수신, 가상 위치 변경) 애니메이션 없이 바로 옮긴다. 처음 그릴 때도 바로.

**나침반 표시** — 정지 중(bearing 없음)에 폰이 향한 방향을 보여 준다. 움직이는 중엔 진행 방향 화살표만.

| 상태 | 내 위치 마커 | 방향 콘(부채꼴) |
|---|---|---|
| 따라가기 꺼짐 + 정지 | 점 + 작은 화살촉(나침반 방향으로 회전) | 없음 |
| 따라가기·지도 회전 + 정지 | 점 | 점 아래에 표시 |
| 이동 중(모든 모드) | 진행 방향 화살표 | 없음 |

- 정지 중엔 모드와 상관없이 점 라벨을 나침반 방향으로 돌린다. 꺼짐 모드에선 화살촉이 그 방향을 가리키고, 회전 모드에선 트래킹이 그 회전을 따라 지도를 돌린다.
- iOS 시뮬레이터에는 나침반이 없어서 시뮬레이터 빌드(`#if targetEnvironment(simulator)`)에서만 12초에 한 바퀴 도는 가짜 방향을 보낸다.
- 나침반 값은 초당 여러 번 바뀌어서 Dart로 보내지 않는다. 플러그인 안의 `CompassHeading`이 읽어 바로 콘을 돌린다. Dart·Pigeon 변경 없음.
- 센서는 내 위치 마커가 있고 앱이 화면에 있을 때만 켠다(iOS `setActive`, Android Activity resume/pause).

| | iOS (`CompassHeading.swift`) | Android (`CompassHeading.kt`) |
|---|---|---|
| 센서 | `CLLocationManager` heading (`headingFilter` 1°) | 회전 벡터 센서 `TYPE_ROTATION_VECTOR` |
| 진북 | OS가 `trueHeading`으로 줌 | 자북 + `GeomagneticField` 편각(서울 약 -9°) |
| 떨림 | OS가 보정 | sin·cos 저역 통과 필터 + 1° 미만 변화 무시 |
| 가로 화면 | `headingOrientation`을 기기 방향에 맞춤 | `remapCoordinateSystem` |
| 시뮬레이터 | 나침반 없음 → 가짜 방향(천천히 회전)으로 화면만 확인 | 에뮬레이터 가상 센서로 확인 가능: `adb emu sensor set magnetic-field x:y:z` |

**따라가기 모드** — 내 위치 버튼을 누를 때마다 `none → follow → followWithHeading → none`.
- 상태(`FollowMode`)는 `MapCubit`이 갖고, `MapScreen`이 `setFollowMode`로 지도에 알린다. 카메라 추적은 카카오 SDK의
  **TrackingManager**(iOS `getTrackingManager().startTrackingPoi`, Android `trackingManager.startTracking`)가 한다.
  트래킹은 마커의 이동 애니메이션을 매 프레임 따라가서, Dart에서 카메라를 따로 옮기는 것보다 마커와 어긋나지 않는다.
- `followWithHeading`은 트래킹의 회전 추적(`isTrackingRoll` / `setTrackingRotation`)을 켠다. 지도가 내 위치 마커의 회전을
  따라 돈다. 이동 중엔 화살표가 진행 방향으로 돌고, 정지 중엔 **점 마커를 나침반 방향으로 돌려**(동그라미라 티가 안 남)
  폰이 향한 방향이 위가 되게 한다. 이 모드를 끄면 지도를 북쪽이 위로 되돌린다.
- 해제: 사용자가 드래그하면 네이티브가 `onUserGesture(pan)`을 보내 `none`으로. 두 손가락 회전(`rotate`)은 회전 모드만
  풀고 따라가기는 유지. 줌 제스처는 보내지 않는다(따라가며 확대·축소 가능). 코드로 옮긴 카메라는 SDK가 "사용자 동작 아님"으로 알려 무시된다.
- 검색 결과·장소 선택·경로 맞추기·길찾기 닫기(카메라 복원)는 카메라를 옮기기 전에 `stopFollowing()`을 부른다.
  켜 두면 트래킹이 카메라를 곧바로 내 위치로 끌고 간다.
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
VS Code는 `.vscode/launch.json`(F5)에 위 옵션과 시뮬레이터가 들어 있다. 터미널은 `make run` / `make run-android`.

### 내 위치: 고정 좌표 vs 실제 GPS
`location_module.dart`가 고른다. `FIXED_LOCATION`("위도,경도")이 있으면 `FixedLocationRepository`, 없으면 `GpsLocationRepository`(geolocator).
- `make run-gps` / `make run-android-gps`: env 파일은 그대로 두고 `FIXED_LOCATION`만 비워 GPS로 실행한다.
- 가상 위치 넣기: iOS `xcrun simctl location <udid> set 위도,경도`, Android `adb emu geo fix 경도 위도`(순서 주의).
- 시뮬레이터·에뮬레이터는 **속도를 0으로 보내서** 이동 화살표가 안 나온다(0.5m/s 미만이면 방향을 버리는 규칙). 화살표는 실기기로 확인.

| geolocator 권한 | 뜻 | 도메인 `LocationPermission` |
|---|---|---|
| `denied` | 아직 물어볼 수 있음 (iOS 미결정, Android 한 번 거절) | `notDetermined` → 팝업 |
| `deniedForever` | 팝업이 더 안 뜸 | `denied` → 설정 앱 안내 |
| `whileInUse`, `always` | 허용 | `authorized` |

### 푸시 켜기 (Firebase 설정)
기본은 꺼져 있다(`DisabledPushRepository`). 켜려면:
1. Firebase 콘솔에서 프로젝트를 만들고 앱 두 개 등록: Android `com.sintaek.simple_tracking`, iOS `com.sintaek.simpleTracking`.
2. 설정 파일 넣기: `android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`(Xcode에서 Runner 타깃에 추가).
   Android는 `com.google.gms.google-services` gradle 플러그인도 적용한다.
3. iOS: Xcode → Signing & Capabilities에 **Push Notifications**, **Background Modes › Remote notifications** 추가.
   Firebase 콘솔에 APNs 인증 키(.p8) 업로드. 시뮬레이터는 APNs 토큰이 없어 토큰이 안 나온다 → 실기기로 확인.
4. `env/dev.json`에 `"PUSH_ENABLED": "true"`.
5. 테스트 발송: Firebase 콘솔 › Messaging, 또는 HTTP v1 API에 `data: {"type": "search", "query": "카페"}`.

## 7. 알아 두면 좋은 함정 (실제로 겪은 것)

| 증상 | 원인 | 위치 |
|---|---|---|
| 하단 시트가 안 끌림 | `DraggableScrollableSheet.snapSizes`를 빌드마다 새 리스트로 넘김 (객체 동일성 비교) | `map_bottom_sheet.dart` |
| 백그라운드 후 위치 구독 재시작 안 됨 | `async*` 안에서 끝나지 않는 await → `cancel()`이 끝나지 않음 | `fixed_location_repository.dart`, `map_cubit.dart` |
| Retrofit 생성 코드 컴파일 에러 | `@Query` 기본값 상수를 클래스명 없이 복사 → `KakaoPlaceApi.pageSize`로 써야 함 | `kakao_place_api.dart` |
| analyzer가 컴파일 에러를 못 잡음 | 생성 파일을 analyzer에서 exclude | `analysis_options.yaml` |
| 첫 `onMapReady`를 놓칠 수 있음 | Flutter viewId는 뷰 생성 후에야 알 수 있음 → Dart가 만든 channelId 사용 | `kakao_map_view.dart` |
