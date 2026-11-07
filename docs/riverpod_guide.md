# Cubit → Riverpod 전환 가이드 (simple_tracking 실전 정리)

> 이 레포의 `riverpod` 브랜치에서 실제로 옮긴 코드를 예로 든다. `main` 브랜치가 옮기기 전(Cubit) 버전이라
> 같은 파일을 두 브랜치에서 비교해 보면 그대로 공부가 된다.
> 버전: flutter_riverpod 3.4 · riverpod_annotation 4.0 · riverpod_generator 4.0 (코드 생성 방식)

---

## 0. 한 줄 요약

| | Cubit (flutter_bloc + get_it) | Riverpod |
|---|---|---|
| 상태 객체를 누가 만드나 | 라우트에서 `BlocProvider(create: (_) => getIt<XCubit>())` | **처음 읽히는 순간 Riverpod이 만든다** |
| 언제 사라지나 | `BlocProvider`가 위젯 트리에서 빠질 때 `close()` | **아무도 안 보면 자동 정리**(autoDispose, 기본값) |
| 의존성(UseCase, 저장소) | 생성자 인자 → get_it이 채움 | `build()`에서 `ref.watch(xxxProvider)` |
| 테스트에서 가짜 넣기 | 생성자에 가짜를 직접 넣음 | `ProviderContainer.test(overrides: [...])` |

핵심 차이: **"누가, 언제 만들고 없애는가"를 내가 라우트에 적는 대신 Riverpod이 "누가 보고 있나"로 알아서 한다.**

---

## 1. 옮긴 범위 (2026-11-07, 전부 옮김)

| 기능 | 전 (main) | 후 (riverpod) | 커밋 |
|---|---|---|---|
| 위치 저장소·UseCase | get_it 모듈 | `location_providers.dart` (provider 함수) | d7c0eff |
| 지도(내 위치·권한·따라가기) | `MapCubit` | `MapNotifier` | d7c0eff |
| 장소 검색 | `PlaceSearchCubit` | `PlaceSearchNotifier` | f8b32fe |
| 길찾기 결과 | `RouteCubit` | `RouteNotifier` | 7300d0b |
| 길찾기 준비 | `RoutePlannerCubit` | `RoutePlannerNotifier` (family) | 7300d0b, 3ca0002 |
| 출발지·도착지 검색 | `EndpointSearchCubit` | `EndpointSearchNotifier` | 7300d0b |
| Dio·SharedPreferences | get_it `@module` (`@lazySingleton`, `@preResolve`) | `dioProvider`(keepAlive), `sharedPreferencesProvider`(main에서 override) | 3d5269b |
| 장소 API·저장소·UseCase | get_it + injectable (잠깐 `getIt()` 다리) | `place_providers.dart` 사슬 | b6b48ea |
| 길찾기 API·저장소·UseCase | get_it + injectable (잠깐 `getIt()` 다리) | `route_providers.dart` 사슬 | c5968a6 |
| 푸시 | `PushCubit` + `PushModule` | `PushNotifier`(keepAlive) + `pushRepositoryProvider` | 54e4e3b |
| 패키지 | get_it, injectable, flutter_bloc, bloc_test | **제거** | 9e13bbb |

이제 앱에 get_it·Cubit이 없다. 전부 provider다.

---

## 2. 용어를 "무슨 일이 일어나는지"로

| 용어 | 실제로 일어나는 일 |
|---|---|
| **provider** | "이 값은 이렇게 만든다"는 레시피. 값 자체가 아니다. 처음 누가 읽을 때 만들어지고 저장된다 |
| **ProviderScope** | 만들어진 값들이 저장되는 창고. `main.dart`에서 앱 전체를 한 번 감싼다 |
| **ref** | 창고에 접근하는 손. 위젯은 `WidgetRef`, Notifier/provider 안에서는 `Ref` |
| **Notifier** | Cubit 자리. `state`를 들고 있고 메서드로 바꾼다. `emit(x)` 대신 `state = x` |
| **autoDispose** (기본값) | 아무도 안 보면 그 프레임 끝에 정리하고 `ref.onDispose`를 부른다. 다음에 읽으면 새로 만든다 |
| **keepAlive** | 아무도 안 봐도 앱이 끝날 때까지 남긴다. 저장소처럼 앱 수명 객체에 쓴다 |
| **family** | 인자를 받는 provider. 인자마다 따로 만들어진다 (`routePlannerProvider(TravelMode.car)`) |
| **override** | 테스트에서 "이 provider는 이 값으로 대신해"라고 바꿔 끼우기 |

---

## 3. 코드 생성 규칙 (riverpod_generator)

```dart
part 'route_notifier.g.dart';

@riverpod                       // autoDispose (기본)
class RouteNotifier extends _$RouteNotifier { ... }
```

- 클래스 이름이 `XxxNotifier`면 provider 이름은 **`xxxProvider`** (Notifier가 빠진다).
  `RouteNotifier` → `routeProvider`, `PlaceSearchNotifier` → `placeSearchProvider`.
- 함수형 provider는 함수 이름 + Provider: `findCarRouteUseCase(Ref ref)` → `findCarRouteUseCaseProvider`.
- 앱 수명이면 `@Riverpod(keepAlive: true)`.
- 고치고 나면 `dart run build_runner build --delete-conflicting-outputs`. 생성 파일(`.g.dart`)도 커밋한다.

---

## 4. 전·후 비교: 길찾기 준비 화면

### 4-1. Cubit (main)

```dart
@injectable
class RoutePlannerCubit extends Cubit<RoutePlannerState>
    with EffectEmitter<RoutePlannerState, RoutePlannerEffect> {
  RoutePlannerCubit(this._recentPlaces) : super(const RoutePlannerState());
  final RecentPlacesUseCase _recentPlaces;          // ← get_it이 생성자로 넣어 줌

  Future<void> onAppear({required TravelMode mode}) async {
    emit(state.copyWith(mode: mode));               // ← initState에서 불러도 OK였다
    emit(state.copyWith(recentPlaces: await _recentPlaces.list()));
  }
}

// app_router.dart
GoRoute(
  path: RoutePlannerPage.path,
  builder: (context, state) => BlocProvider(
    create: (_) => getIt<RoutePlannerCubit>(),      // ← 라우트가 만들고 없앤다
    child: RoutePlannerPage(args: state.extra! as RoutePlannerArgs),
  ),
),
```

### 4-2. Riverpod (riverpod)

```dart
@riverpod
class RoutePlannerNotifier extends _$RoutePlannerNotifier {
  late RecentPlacesUseCase _recentPlaces;
  late EffectChannel<RoutePlannerEffect> _effects;
  Stream<RoutePlannerEffect> get effects => _effects.stream;

  @override
  RoutePlannerState build(TravelMode initialMode) {  // ← family: 처음 값을 인자로 받는다
    _recentPlaces = ref.watch(recentPlacesUseCaseProvider);  // ← 의존성은 provider에서
    _effects = EffectChannel();
    ref.onDispose(_effects.close);                   // ← Cubit.close() 자리
    unawaited(_loadRecents());                       // ← 비동기 로드는 build에서 시작
    return RoutePlannerState(mode: initialMode);
  }

  Future<void> _loadRecents() async {
    final recents = await _recentPlaces.list();
    if (ref.mounted) state = state.copyWith(recentPlaces: recents);  // ← await 뒤엔 mounted 확인
  }
}

// app_router.dart — 라우트는 화면만 선언한다
GoRoute(
  path: RoutePlannerPage.path,
  builder: (context, state) =>
      RoutePlannerPage(args: state.extra! as RoutePlannerArgs),
),
```

### 4-3. 화면

```dart
class RoutePlannerPage extends ConsumerStatefulWidget { ... }   // StatefulWidget → Consumer 버전

class _RoutePlannerPageState extends ConsumerState<RoutePlannerPage> {
  RoutePlannerNotifierProvider get _provider => routePlannerProvider(widget.args.mode);
  RoutePlannerNotifier get _planner => ref.read(_provider.notifier);   // 메서드 부를 때

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_provider);                                // 그릴 때
    return EffectListener<RoutePlannerEffect>(
      effects: _planner.effects,
      onEffect: (context, effect) => switch (effect) {
        RoutePlanCompletedEffect(:final plan) => context.pop(plan),
      },
      child: ...,
    );
  }
}
```

---

## 5. 위젯 쪽 대응표

| flutter_bloc | Riverpod | 언제 |
|---|---|---|
| `BlocProvider(create: ...)` | (없음) 처음 `ref.watch/read`할 때 생김 | — |
| `context.read<XCubit>()` | `ref.read(xProvider.notifier)` | 버튼 등에서 메서드 부를 때 |
| `context.watch<XCubit>().state` / `BlocBuilder` | `ref.watch(xProvider)` | build에서 그릴 때 |
| `BlocSelector` | `ref.watch(xProvider.select((s) => s.field))` | 일부 필드만 바뀔 때 다시 그리기 |
| `BlocListener(listenWhen: (a, b) => a.f != b.f)` | `ref.listen(xProvider.select((s) => s.f), (prev, next) {...})` | 상태 변화에 **반응**(지도 명령, 이동) |
| `StatelessWidget` / `StatefulWidget` | `ConsumerWidget` / `ConsumerStatefulWidget` | ref가 필요하면 |

`ref.listen`은 **build 안에서** 부른다. Riverpod이 한 번만 등록한다(매 build마다 쌓이지 않는다).

```dart
// map_screen.dart — BlocListener 2개가 이렇게 바뀌었다
ref
  ..listen(routeProvider.select((s) => s.isActive), (_, isActive) {
    if (isActive) { _cameraBeforeRoute = _cameraPosition; } else { _restoreCameraAfterRoute(); }
    _syncPlaceMarkers();
  })
  ..listen(routeProvider.select((s) => s.overlay),
      (_, overlay) => unawaited(_map?.showRoute(overlay)));
```

---

## 6. Notifier 안쪽 대응표

| Cubit | Notifier |
|---|---|
| 생성자 + `super(initialState)` | `build()`가 처음 상태를 **return** |
| 생성자 인자(get_it 주입) | `build()`에서 `ref.watch(xxxProvider)` |
| `emit(newState)` | `state = newState` |
| `isClosed` | `!ref.mounted` |
| `close()` override | `ref.onDispose(() { ... })` |
| `EffectEmitter` mixin (`effect_cubit.dart`) | `EffectChannel` 필드 (`effect_channel.dart`) |

### 일회성 이벤트(effect)

상태는 "계속 보이는 값", effect는 "한 번 하고 끝나는 일"(카메라 이동, 토스트, 페이지 닫기).
Riverpod에는 Cubit의 `EffectEmitter` mixin을 붙일 곳이 없어서 `EffectChannel`(StreamController 감싼 것)을 필드로 둔다.

```dart
late EffectChannel<RouteEffect> _effects;
Stream<RouteEffect> get effects => _effects.stream;

@override
RouteState build() {
  _effects = EffectChannel();
  ref.onDispose(_effects.close);   // 닫힌 뒤 emit은 무시된다
  ...
}
```

---

## 7. 수명 결정: autoDispose vs keepAlive vs "같이 쓰기"

| 이 레포의 선택 | 이유 |
|---|---|
| `locationRepositoryProvider` = **keepAlive** | GPS 저장소는 앱 수명 동안 하나 |
| 화면 Notifier들 = **autoDispose** | 화면을 떠나면 GPS 구독·진행 중 요청을 정리해야 한다 |
| `RouteListPage`는 **자기 Notifier 없음**, `routeProvider`를 같이 봄 | 목록 ↔ 지도를 오가는 한 흐름. 지도 화면이 아래 깔려 계속 보고 있어서 상태가 유지된다 |
| `routePlannerProvider`는 **family**(`TravelMode`) | 처음 값을 build에서 정해야 해서(아래 8-1) |
| Dio·API·저장소 = **keepAlive** | 앱에 하나면 된다(get_it `@lazySingleton` 자리) |
| UseCase = **autoDispose** | 보는 Notifier가 있는 동안만. 상태가 없어 다시 만들어도 싸다 |
| `PushNotifier` = **keepAlive** + 앱 맨 위에서 watch | 화면과 상관없이 앱 내내 수신. 앱 시작과 함께 만들어야 해서(아래 13) |

**판단 기준**: "이 상태는 누가 보는 동안 살아 있어야 하나?" → 그 화면이 `ref.watch`하면 autoDispose로 충분하다.

---

## 8. 실제로 밟은 함정 (중요)

### 8-1. initState에서 상태를 바꾸면 오류 — `Tried to modify a provider while the widget tree was building`

- **Cubit**은 `initState`에서 `cubit.onAppear()` → 바로 `emit` 해도 됐다.
- **Riverpod**은 위젯을 그리는 중(build·initState·didUpdateWidget·dispose)에 provider를 바꾸면 막는다.
  두 위젯이 같은 provider를 보다가 서로 다른 값을 볼 수 있기 때문.
- 화면은 멀쩡해 보여서 눈으로는 안 잡힌다. 아이폰 로그에서 사용자가 발견했다(3ca0002).

해결 두 가지:
```dart
// ① 처음 값은 provider 인자(family)로 넘겨 build에서 정한다  ← 권장
routePlannerProvider(widget.args.mode)

// ② 꼭 생명주기에서 불러야 하면 이번 프레임을 다 그린 뒤로 미룬다
WidgetsBinding.instance.addPostFrameCallback((_) {
  if (!mounted) return;
  unawaited(_search.searchFor(query));
});
```
(await가 먼저 오는 `onAppear()`는 괜찮다. 상태를 바꾸는 시점이 이미 build 밖이다.)

### 8-2. 정리된 뒤 state를 건드리면 예외 — `Cannot use the Ref ... after it has been disposed`

- 경로 조회 중 화면이 닫히면, 늦게 온 응답이 정리된 Notifier의 `state`를 바꾸려다 예외.
- 해결: **세대 번호(`_generation`)**를 `ref.onDispose`에서 올려 늦은 응답을 버리고, await 뒤에는 `ref.mounted` 확인.

```dart
ref.onDispose(() { _generation++; _effects.close(); });
...
final generation = ++_generation;
final result = await _findCar(from, to);
if (generation != _generation) return;   // 다시 찾았거나 화면이 닫혔으면 버림
```

### 8-3. 테스트에서 autoDispose가 바로 사라짐

- `container.read(xProvider)`만 하면 아무도 안 보는 상태라 프레임 끝에 정리된다.
- 테스트는 **`container.listen(xProvider, (_, _) {})`로 붙잡아 둔다**(화면이 보는 것처럼).

### 8-4. 위젯 테스트가 없으면 8-1을 못 잡는다

- Notifier 단위 테스트는 위젯 생명주기를 안 지나서 8-1을 통과해 버린다.
- 화면을 실제로 띄우는 테스트 하나씩(`tester.takeException()`이 null인지) 두면 잡힌다.

---

## 9. 테스트 패턴

### Notifier 단위 테스트

```dart
late ProviderContainer container;

RouteNotifier makeNotifier(FakeRouteRepository repository) {
  container = ProviderContainer.test(              // 테스트 끝나면 자동 dispose
    overrides: [
      findCarRouteUseCaseProvider.overrideWithValue(FindCarRouteUseCase(repository)),
      ...
    ],
  )..listen(routeProvider, (_, _) {});             // 8-3: 붙잡아 두기
  final notifier = container.read(routeProvider.notifier);
  effects = [];
  notifier.effects.listen(effects.add);
  return notifier;
}

RouteState state() => container.read(routeProvider);
```

Cubit 테스트에서 `cubit.state` 쓰던 자리는 `state()`로 바뀐다. get_it 없이 돈다.

### 화면(위젯) 테스트

```dart
await tester.pumpWidget(
  ProviderScope(
    overrides: [recentPlacesUseCaseProvider.overrideWithValue(...)],
    child: MaterialApp(home: RoutePlannerPage(args: ...)),
  ),
);
await tester.pumpAndSettle();
expect(tester.takeException(), isNull);   // 8-1 같은 오류가 여기서 잡힌다
```

테스트가 container를 직접 들고 상태를 확인하려면 `UncontrolledProviderScope(container: container, child: ...)`.

### "고치기 전 코드에서 실패하는지" 확인한 것

| 테스트 | 고치기 전 실패 메시지 |
|---|---|
| `route_planner_page_test` | Tried to modify a provider while the widget tree was building |
| `map_screen_link_test` (2개) | 같음 (initState·didUpdateWidget 링크 검색) |
| `route_notifier_test` "조회 중에 지도 화면이 닫히면…" | Cannot use the Ref of routeProvider after it has been disposed |

---

## 10. 옮기는 순서 (이 레포에서 쓴 방법)

한 번에 다 바꾸지 않고, **기능 하나씩** 옮기며 매번 테스트·에뮬레이터 확인 후 커밋했다.

1. `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator` 추가 → `main.dart`를 `ProviderScope`로 감싼다.
2. 바닥(저장소)부터: get_it 모듈을 provider 함수로 (`location_providers.dart`).
3. 화면 하나씩: Cubit → Notifier, 위젯 → Consumer, 라우트의 `BlocProvider` 삭제, 테스트를 `ProviderContainer`로.
4. 아직 get_it에 있는 객체는 provider가 꺼내 오는 **임시 다리**로 잇는다(지금은 걷어 냄, 아래 13).
   ```dart
   @riverpod
   SearchPlacesUseCase searchPlacesUseCase(Ref ref) => getIt();   // get_it 뺄 때 여기서 직접 만든다
   ```
   한 기능 안에서 Cubit과 Notifier를 섞지 않는다. 다리는 "아래층" 객체에만 쓴다.
5. 다리 제거: 맨 아래(Dio·SharedPreferences)부터 provider로 → 장소 → 길찾기 → 푸시 → 패키지 제거. 아래 13.

---

## 11. 면접에서 나올 만한 질문과 짧은 답

**Q. Bloc/Cubit 대신 Riverpod을 쓰면 뭐가 좋나?**
상태 객체의 생성·정리를 "누가 보고 있나"로 자동 관리해서 라우트마다 `BlocProvider`를 쓰지 않아도 되고, DI까지 provider로 한 번에 된다. 테스트는 `overrides`로 가짜를 끼우면 끝이라 get_it 설정이 필요 없다. 대신 위젯 생명주기 중 상태 변경 금지 같은 규칙을 지켜야 한다.

**Q. `ref.watch`와 `ref.read`의 차이는?**
watch는 "보면서 바뀌면 다시 그려/다시 계산해", read는 "지금 값만 한 번". build에서는 watch, 버튼 콜백에서 메서드 부를 때는 `read(x.notifier)`.

**Q. `ref.listen`은 언제 쓰나?**
상태가 바뀔 때 그리기가 아니라 **행동**을 해야 할 때(지도에 선 그리기, 페이지 닫기). BlocListener 자리.

**Q. autoDispose를 왜 기본으로 두나? 언제 keepAlive?**
화면 상태는 화면을 떠나면 GPS 구독·요청을 정리해야 해서 autoDispose. 저장소처럼 앱 내내 하나여야 하는 건 keepAlive.

**Q. 비동기 작업 중 화면이 닫히면?**
`ref.onDispose`에서 세대 번호를 올려 늦은 응답을 버리고, await 뒤 `ref.mounted`를 확인한다. 안 하면 정리된 Notifier의 state를 바꾸다 예외가 난다(실제로 테스트로 재현).

**Q. 일회성 이벤트(토스트, 이동)는 어떻게 했나?**
state에 넣고 소비 처리하는 방식 대신 `EffectChannel`(스트림)로 따로 보냈다. 놓쳐도 다시 할 필요 없는 일(카메라, 토스트)이라서. 결제 완료처럼 절대 놓치면 안 되는 건 state에 넣는 게 안전하다.

**Q. 옮기면서 겪은 버그는?**
initState에서 상태를 바꾸던 Cubit 습관 그대로 옮겨서 Riverpod 오류가 났다. 처음 값을 family 인자로 넘기도록 바꾸고, 화면을 띄우는 위젯 테스트로 고정했다.

---

## 12. 파일 찾아보기

| 보고 싶은 것 | 파일 |
|---|---|
| 앱 수명 provider(keepAlive) | `lib/features/location/data/location_providers.dart` |
| API → 저장소 → UseCase 사슬 | `lib/features/place/data/place_providers.dart`, `lib/features/route/data/route_providers.dart` |
| await가 필요한 준비물(빈 자리 + main override) | `lib/core/storage/shared_preferences_provider.dart`, `lib/main.dart` |
| 앱 시작과 함께 만드는 Notifier | `lib/features/push/presentation/push_notifier.dart`, `push_effect_listener.dart` |
| Notifier 기본형 + 세대 번호 + 정리 | `lib/features/route/presentation/route_notifier.dart` |
| family Notifier | `lib/features/route/presentation/route_planner_notifier.dart` |
| 디바운스(실시간 검색) | `lib/features/place/presentation/place_search_notifier.dart`, `endpoint_search_notifier.dart` |
| effect 통로 | `lib/core/presentation/effect_channel.dart`, `widgets/effect_listener.dart` |
| ref.listen + select로 지도 반영 | `lib/features/map/presentation/map_screen.dart` (build 안) |
| 같은 Notifier를 두 화면이 보기 | `route_list_page.dart` ↔ `map_screen.dart` |
| 테스트 | `test/features/route/presentation/*_notifier_test.dart`·`route_list_page_test.dart`·`route_planner_page_test.dart`, `test/features/map/presentation/map_screen_link_test.dart` |
| 전환 전 코드 | `git switch main` 후 `lib/features/<기능>/presentation/cubit/*_cubit.dart` (예: `route/presentation/cubit/route_cubit.dart`) |

---

## 13. get_it 걷어 내기 (2026-11-07)

임시 다리는 이런 모양이었다.

```dart
@riverpod
SearchPlacesUseCase searchPlacesUseCase(Ref ref) => getIt();   // getIt<SearchPlacesUseCase>()의 줄임. 반환 타입으로 채워진다
```

창고(Riverpod)는 맨 위 UseCase 한 칸만 알고 그 아래(저장소·API·Dio)는 get_it 안에 있어 못 본다. 그래서
**저장소만 가짜로 바꿔 끼우는 게 안 됐다**(UseCase provider를 통째로 덮어써야 했다). 맨 아래부터 걷어 냈다.

### 13-1. 맨 아래: Dio와 SharedPreferences

```dart
// core/network/dio_provider.dart
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(...)..interceptors.add(KakaoAuthInterceptor(...));
  ref.onDispose(dio.close);
  return dio;
}

// core/storage/shared_preferences_provider.dart — 여는 데 await가 필요해서 빈 자리로 둔다
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) => throw UnimplementedError('main.dart에서 넣어야 한다');

// main.dart — get_it의 @preResolve 자리
final prefs = await SharedPreferences.getInstance();
runApp(ProviderScope(
  overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  child: const App(),
));
```

### 13-2. 기능마다: API → 저장소 → UseCase 사슬

```dart
// features/place/data/place_providers.dart
@Riverpod(keepAlive: true)
KakaoPlaceApi kakaoPlaceApi(Ref ref) => KakaoPlaceApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
PlaceRepository placeRepository(Ref ref) =>                // 반환 타입 = domain 인터페이스
    PlaceRepositoryImpl(ref.watch(kakaoPlaceApiProvider));

@riverpod
SearchPlacesUseCase searchPlacesUseCase(Ref ref) =>
    SearchPlacesUseCase(ref.watch(placeRepositoryProvider));
```

- 클래스에서 `@injectable`·`@LazySingleton(as:)`·`@factoryMethod`를 지웠다. **domain이 다시 순수 Dart**가 됐다(injectable import가 없어짐).
- Notifier·화면 코드는 한 줄도 안 바뀌었다. 다리였을 때부터 `ref.watch(searchPlacesUseCaseProvider)`였으니까. **레시피 본문만** 바뀐다.
- 이제 저장소만 가짜로 바꿔도 UseCase가 따라온다: `test/features/place/data/place_providers_test.dart`.

### 13-3. 푸시: Cubit → Notifier, 앱 시작과 함께 만들기

Riverpod은 **처음 읽힐 때** 만든다. 푸시는 화면과 상관없이 앱이 뜨자마자 수신을 시작해야 한다(get_it `@singleton` 같은 것).

```dart
// push_notifier.dart
@Riverpod(keepAlive: true)
class PushNotifier extends _$PushNotifier {
  @override
  PushState build() {                       // Cubit 생성자 + start() 자리
    _push = ref.watch(pushRepositoryProvider);
    _subscriptions.addAll([...]);           // 구독을 먼저 (권한 팝업 동안 온 메시지도 받으려고)
    ref.onDispose(() { /* 구독 끊기, effect 닫기 */ });
    unawaited(_start());                    // 기다려야 하는 일(종료 후 탭한 메시지, 권한)
    return const PushState();
  }
}

// push_effect_listener.dart — MaterialApp 위
final notifier = ref.watch(pushProvider.notifier);   // 앱 맨 위가 계속 보고 있으니 앱 시작과 함께 만들어진다
```

- `.notifier`를 watch하면 Notifier 객체는 바뀌지 않으니 **상태가 바뀌어도 다시 그리지 않는다**. 깨우기만 한다.
- Cubit 시절 `app.dart`의 `BlocProvider(create: (_) => getIt<PushCubit>()..start())`가 통째로 없어졌다.
- 버튼에서 `start()`를 부르는 대신 build에서 시작하니, initState에서 provider를 건드리는 함정(8-1)도 생길 자리가 없다.

### 13-4. 하면서 확인한 것

- 단계마다 테스트 전부 통과 + 에뮬레이터(카페 검색 → 길찾기, 실제 카카오 API)로 확인 후 커밋.
- `PushNotifier`가 정리될 때 구독을 끊는 테스트를 추가하고, 해제 코드를 빼면 실패하는 것을 확인.
- 푸시는 `PUSH_ENABLED`가 꺼진 설정(비활성 저장소)으로만 실행 확인. 실제 FCM 수신은 실기기에서 따로 확인해야 한다.

### get_it → Riverpod 최종 대응

| get_it + injectable | 이 레포의 Riverpod |
|---|---|
| `@lazySingleton` | `@Riverpod(keepAlive: true)` |
| `@injectable` (UseCase) | `@riverpod` (autoDispose) |
| `@LazySingleton(as: Repo)` | 레시피 반환 타입을 `Repo`(인터페이스)로 |
| `@module` (남의 클래스: Dio) | 레시피 안에서 직접 만들기 |
| `@module` + `@preResolve` (SharedPreferences) | 빈 자리 레시피 + main에서 `overrideWithValue` |
| `@singleton` / 앱 시작 때 `..start()` | keepAlive + 앱 맨 위 위젯에서 watch, 시작은 `build()` |
| `await configureDependencies()` | 없음 (`ProviderScope`는 창고만 연다) |
| 테스트 `getIt.reset()` | 테스트마다 `ProviderContainer.test(overrides:)` |

