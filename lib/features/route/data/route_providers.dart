// [route/data] 길찾기 UseCase를 provider로 내놓는다(Riverpod 판 DI).
// 쓰는 곳: route_notifier.dart. 테스트는 이 provider들을 가짜로 덮어쓴다.
// 옮기는 중: 저장소·API·Dio가 아직 get_it에 있어 UseCase를 get_it에서 꺼내 온다
// (place_providers와 같은 방식). get_it을 뺄 때 저장소·API를 여기서 직접 만든다.

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/di/injection.dart';
import 'package:simple_tracking/features/route/domain/find_route_use_cases.dart';

part 'route_providers.g.dart';

@riverpod
FindCarRouteUseCase findCarRouteUseCase(Ref ref) => getIt();

@riverpod
FindWalkingRouteUseCase findWalkingRouteUseCase(Ref ref) => getIt();

@riverpod
FindTransitRoutesUseCase findTransitRoutesUseCase(Ref ref) => getIt();
