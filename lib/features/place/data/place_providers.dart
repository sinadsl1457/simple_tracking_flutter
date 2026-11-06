// [place/data] 장소 기능의 UseCase를 provider로 내놓는다(Riverpod 판 DI). 쓰는 곳: place_search_notifier.dart.
// 길찾기(EndpointSearchNotifier·RoutePlannerNotifier)도 같은 UseCase를 여기서 받는다.
// 옮기는 중: 저장소·API·Dio가 아직 get_it에 있어 get_it에서 꺼내 온다. get_it을 뺄 때 여기서 직접 만든다.
// 테스트는 이 provider들을 가짜로 덮어쓴다.

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/di/injection.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_by_category_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart';

part 'place_providers.g.dart';

@riverpod
SearchPlacesUseCase searchPlacesUseCase(Ref ref) => getIt();

@riverpod
SearchPlacesByCategoryUseCase searchPlacesByCategoryUseCase(Ref ref) => getIt();

@riverpod
RecentSearchesUseCase recentSearchesUseCase(Ref ref) => getIt();

@riverpod
RecentPlacesUseCase recentPlacesUseCase(Ref ref) => getIt();
