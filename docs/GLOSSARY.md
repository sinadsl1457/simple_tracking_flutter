# 용어·문법 사전

이 프로젝트에서 쓴 것 중 평소 Flutter 코드에서 자주 보지 않는 것들. "어디서 쓰나"는 대표 위치 하나.

---

## 1. DI (get_it + injectable)

| 키워드 | 뜻 | 어디서 쓰나 |
|---|---|---|
| `@InjectableInit()` | 이 함수에 대한 등록 코드(`injection.config.dart`)를 생성하라는 표시 | `core/di/injection.dart` |
| `@injectable` | 요청할 때마다 **새로 만드는** 등록(factory). Cubit, UseCase | `route_cubit.dart` |
| `@lazySingleton` | **처음 요청할 때 한 번** 만들고 계속 재사용 | `kakao_place_api.dart` |
| `@LazySingleton(as: X)` | 이 구현 클래스를 **인터페이스 X 자리에** 등록. 다른 곳은 X만 알면 된다 | `place_repository_impl.dart` (`as: PlaceRepository`) |
| `@module` | "이 타입을 어떻게 만들지" 생성 로직을 직접 쓰는 곳. ① 남의 클래스라 어노테이션을 못 붙일 때(Dio, SharedPreferences) ② 생성자 인자가 설정·계산값일 때 ③ 조건에 따라 구현을 골라야 할 때 | `register_module.dart`(①), `location_module.dart`(②③) |
| `@preResolve` | 등록할 값이 Future일 때 **DI 초기화 중에 미리 await**해 완성된 객체를 등록. 그래서 `configureDependencies()`가 Future이고 main에서 await한다. (fence `AppStorage`의 늦은 초기화 race를 구조적으로 막는다) | `register_module.dart` `prefs()` |
| `@factoryMethod` | 클래스에 생성자가 여러 개일 때 DI가 쓸 것을 지정. Retrofit의 `factory X(Dio) = _X;`에 붙인다 | `kakao_place_api.dart` |

## 2. 코드 생성 (freezed / json_serializable / retrofit)

| 키워드 | 뜻 | 어디서 쓰나 |
|---|---|---|
| `part 'x.freezed.dart';` | 생성 파일을 이 파일의 일부로 붙인다. 생성 파일은 직접 고치지 않는다 | 거의 모든 모델 |
| `@freezed` + `const factory X(...) = _X;` | `==`, `hashCode`, `copyWith`, `toString` 자동 생성 | `place.dart` |
| `@freezed sealed class` + 여러 `const factory` | **합 타입(union)**: "A 또는 B 또는 C". switch에서 빠진 경우가 있으면 컴파일 에러 | `failure.dart`, `MapEffect` |
| `@Default(값)` | freezed 필드 기본값 | `RouteState.selectedMode` |
| `const X._();` | freezed 클래스에 **직접 getter/메서드를 추가**하려면 필요한 private 생성자 | `PlaceSearchState.places` |
| `@JsonSerializable(fieldRename: FieldRename.snake)` | JSON 키 `place_name` ↔ 필드 `placeName` 자동 변환 | `place_dto.dart` |
| `build.yaml`의 `checked: true` | JSON 모양이 다르면 `TypeError` 대신 `CheckedFromJsonException`(어느 클래스, 어느 키) | `build.yaml` |
| `@RestApi(baseUrl:)`, `@GET`, `@Query` | Retrofit: 추상 메서드 선언만으로 dio 호출 코드 생성 | `kakao_route_api.dart` |

## 3. Dart 3 문법

| 문법 | 뜻 | 예 |
|---|---|---|
| `sealed class` | 같은 파일 안에서만 상속 가능 → 하위 타입 목록이 닫혀 있어 **switch가 모든 경우를 다뤘는지 컴파일러가 검사** | `Failure`, `Result` |
| `abstract interface class` | "구현만 하라(implements), 상속하지 마라" — 순수 인터페이스 | `PlaceRepository` |
| `abstract final class` | 인스턴스를 못 만들고 상속도 못 함 → **static 상수·함수 묶음** 용도 | `AppConfig`, `GeoMath` |
| switch 식 `=> switch (x) { A() => …, B() => … }` | 값을 돌려주는 switch. `case`·`break` 없음 | `FailureMessage.userMessage` |
| 패턴 `case Ok(:final value)` | 타입 검사 + 필드 꺼내기를 한 번에. `:final value`는 `value: final value`의 줄임 | Cubit의 결과 처리 |
| `if (x case final y?)` | x가 null이 아니면 y로 받아서 실행 (if-let) | `map_screen.dart` `_pendingCamera` |
| `when` 가드 | 패턴에 조건 추가: `Ok(value: []) =>`, `ModeTransit(:final routes) when i < routes.length` | `find_route_use_cases.dart` |
| 레코드 `(origin: a, destination: b)` | 이름 붙은 필드의 가벼운 튜플. 클래스 안 만들고 값 묶기 | 테스트 fake의 `lastCarRequest` |
| `for (final (i, x) in list.indexed)` | 인덱스와 값을 같이 순회 (구조 분해) | `placeMarkers()` |
| null-aware 요소 `[?a, b]` | a가 null이면 리스트에서 빼기 (Dart 3.8) | `place_results_sheet.dart` |
| `.nonNulls`, `.firstOrNull` | null 걸러내기, 비었으면 null | `place_repository_impl.dart` |
| `mixin X on Cubit<S>` | Cubit에만 붙일 수 있는 기능 묶음. `with`로 붙인다 | `EffectEmitter` |
| `Result<Never>` | "값은 절대 없음" 타입. 실패만 담을 때 어떤 `Result<T>`에도 대입 가능 | 테스트 |

## 4. 비동기

| 키워드 | 뜻 | 주의 |
|---|---|---|
| `async*` / `yield` / `yield*` | Stream을 함수처럼 작성. `yield*`는 다른 스트림을 이어 붙임 | **끝나지 않는 await를 넣으면 `cancel()`도 끝나지 않는다** → 열린 스트림은 `StreamController` (`fixed_location_repository.dart`) |
| `unawaited(f)` | "일부러 기다리지 않음"을 표시. lint(`discarded_futures`)가 실수로 안 기다린 것과 구분 | 위젯 콜백에서 Cubit 호출 |
| single-subscription `StreamController()` | 구독자 1명. **구독 전 이벤트를 버퍼에 보관** → Swift `AsyncStream`과 같은 성질 | `EffectEmitter` |
| `Future.wait([...])` + `.then` | 여러 요청을 동시에 보내고, 각각 도착하는 대로 처리 | `RouteCubit._search` |
| 세대 번호(`_generation`) | 늦게 도착한 **이전** 요청 결과를 버리는 방법 | `PlaceSearchCubit`, `RouteCubit` |

## 5. Flutter 위젯·API

| 이름 | 뜻 | 어디서 |
|---|---|---|
| `UiKitView` | iOS 네이티브 UIView를 Flutter 위젯 트리에 끼워 넣는 PlatformView. Android는 `AndroidView`/`PlatformViewLink` | `kakao_map_view.dart` |
| `EagerGestureRecognizer` | PlatformView가 터치를 **즉시** 가져가게 함 (지도 드래그·핀치) | 같은 파일 |
| `AppLifecycleListener` | 앱 포그라운드/백그라운드 콜백 (SwiftUI `scenePhase` 대응) | `map_screen.dart` |
| `DraggableScrollableSheet` | 끌어서 높이를 바꾸는 시트. `snapSizes`는 반드시 const (객체 동일성 비교) | `map_bottom_sheet.dart` |
| `CustomScrollView` + `SliverList` / `SliverToBoxAdapter` | 시트 안에 머리글+목록을 한 스크롤로 | 같은 파일 |
| `MultiBlocListener` + `listenWhen` | 상태의 **특정 필드가 바뀔 때만** 반응 | `map_screen.dart` |
| `context.push<T>()` / `context.pop(value)` | go_router: 화면을 띄우고 **결과 값을 돌려받기** | `RoutePlannerPage` → `RoutePlan` |
| `@visibleForTesting` | 테스트용으로만 공개한다는 표시 | `segmentWidths` |
| `tester.timedDrag` | 프레임 사이사이에 움직이는 드래그. `tester.drag`는 프레임 없이 한 번에 보내 실제와 다를 수 있다 | `map_bottom_sheet_test.dart` |

## 6. 빌드·설정

| 이름 | 뜻 |
|---|---|
| `String.fromEnvironment('KEY')` | **컴파일 시** 정해지는 상수. 값은 `--dart-define` 옵션으로만 들어온다 (없으면 빈 문자열) |
| `--dart-define-from-file=env/dev.json` | JSON 파일의 키들을 한꺼번에 `--dart-define`으로 넘김. Flutter가 자동으로 읽지 않는다 |
| `flutter: config: enable-swift-package-manager` | pubspec에서 iOS 플러그인 연결 방식을 SPM/CocoaPods 중 고름 (fence는 false로 끔) |

## 7. Pigeon / 플러그인

| 이름 | 뜻 |
|---|---|
| `@HostApi()` | Dart → Native 명령 인터페이스. Native가 구현 |
| `@FlutterApi()` | Native → Dart 이벤트 인터페이스. Dart가 구현 |
| `messageChannelSuffix` | 채널 이름 꼬리표. 지도 인스턴스마다 채널을 나눈다 (`channelId`) |
| `@ConfigurePigeon(PigeonOptions(...))` | 생성 파일을 어디에 쓸지 (Dart/Swift/Kotlin 경로) |
| `flutter: plugin: platforms: ios: pluginClass:` | "나는 플러그인" 선언 → `GeneratedPluginRegistrant`가 자동 등록 |

## 8. Swift (플러그인)

| 이름 | 뜻 |
|---|---|
| `@MainActor` | 메인 스레드에서만 실행되는 타입·함수 (UI, 카카오 SDK) |
| `@preconcurrency` (import / 프로토콜 채택) | 동시성 표시가 없는 옛 API(SDK, Pigeon 생성 프로토콜)를 Swift 동시성 검사와 함께 쓰기 위한 표시 |
| `MainActor.assumeIsolated { }` | "지금 메인 스레드인 게 확실하다"고 알리고 메인 전용 코드를 실행. Flutter가 메인 스레드에서 부르는 곳(팩토리, deinit)에 사용 |
| `Task { try? await … }` | 동기 함수에서 비동기 호출을 시작. Pigeon FlutterApi 호출이 `async`라서 사용 |
| `deinit` | 객체 해제 시점. FlutterPlatformView에는 dispose가 없어 여기서 정리 |
