// [route/data] 길찾기 기능의 조립: API → 저장소 → UseCase를 레시피 사슬로 잇는다(Riverpod 판 DI).
// 쓰는 곳: route_notifier.dart. 테스트는 저장소나 UseCase provider를 가짜로 덮어쓴다.

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/network/dio_provider.dart';
import 'package:simple_tracking/features/route/data/kakao_route_api.dart';
import 'package:simple_tracking/features/route/data/route_repository_impl.dart';
import 'package:simple_tracking/features/route/domain/find_route_use_cases.dart';
import 'package:simple_tracking/features/route/domain/route_repository.dart';

part 'route_providers.g.dart';

// ── API·저장소: 앱에 하나(keepAlive). 반환 타입은 domain의 인터페이스.

@Riverpod(keepAlive: true)
KakaoRouteApi kakaoRouteApi(Ref ref) => KakaoRouteApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
RouteRepository routeRepository(Ref ref) =>
    RouteRepositoryImpl(ref.watch(kakaoRouteApiProvider));

// ── UseCase: 보는 화면(Notifier)이 있는 동안만(autoDispose).

@riverpod
FindCarRouteUseCase findCarRouteUseCase(Ref ref) =>
    FindCarRouteUseCase(ref.watch(routeRepositoryProvider));

@riverpod
FindWalkingRouteUseCase findWalkingRouteUseCase(Ref ref) =>
    FindWalkingRouteUseCase(ref.watch(routeRepositoryProvider));

@riverpod
FindTransitRoutesUseCase findTransitRoutesUseCase(Ref ref) =>
    FindTransitRoutesUseCase(ref.watch(routeRepositoryProvider));
