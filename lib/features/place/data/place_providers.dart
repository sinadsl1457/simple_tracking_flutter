// [place/data] 장소 기능의 UseCase를 provider로 내놓는다(Riverpod 판 DI). 쓰는 곳: place_search_notifier.dart.
// 옮기는 중: 길찾기(EndpointSearchCubit, get_it)도 같은 UseCase를 써서 지금은 get_it에서 꺼내 온다.
// 길찾기까지 옮기면 저장소·API를 여기서 직접 만들고 get_it을 뺀다. 테스트는 이 provider들을 가짜로 덮어쓴다.

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
