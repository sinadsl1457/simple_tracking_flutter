// [place/data] 장소 기능의 조립: API → 저장소 → UseCase를 레시피 사슬로 잇는다(Riverpod 판 DI).
// 쓰는 곳: place_search_notifier.dart,
// 길찾기(EndpointSearchNotifier·RoutePlannerNotifier).
// 테스트는 저장소나 UseCase provider를 가짜로 덮어쓴다.

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_tracking/core/network/dio_provider.dart';
import 'package:simple_tracking/core/storage/shared_preferences_provider.dart';
import 'package:simple_tracking/features/place/data/kakao_place_api.dart';
import 'package:simple_tracking/features/place/data/place_repository_impl.dart';
import 'package:simple_tracking/features/place/data/shared_prefs_recent_place_repository.dart';
import 'package:simple_tracking/features/place/data/shared_prefs_recent_search_repository.dart';
import 'package:simple_tracking/features/place/domain/place_repository.dart';
import 'package:simple_tracking/features/place/domain/recent_place_repository.dart';
import 'package:simple_tracking/features/place/domain/recent_places_use_case.dart';
import 'package:simple_tracking/features/place/domain/recent_search_repository.dart';
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_by_category_use_case.dart';
import 'package:simple_tracking/features/place/domain/search_places_use_case.dart';

part 'place_providers.g.dart';

// ── API·저장소: 앱에 하나(keepAlive). 반환 타입은 domain의 인터페이스 → 테스트에서 가짜로 바꿔 끼운다.

@Riverpod(keepAlive: true)
KakaoPlaceApi kakaoPlaceApi(Ref ref) => KakaoPlaceApi(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
PlaceRepository placeRepository(Ref ref) =>
    PlaceRepositoryImpl(ref.watch(kakaoPlaceApiProvider));

@Riverpod(keepAlive: true)
RecentSearchRepository recentSearchRepository(Ref ref) =>
    SharedPrefsRecentSearchRepository(ref.watch(sharedPreferencesProvider));

@Riverpod(keepAlive: true)
RecentPlaceRepository recentPlaceRepository(Ref ref) =>
    SharedPrefsRecentPlaceRepository(ref.watch(sharedPreferencesProvider));

// ── UseCase: 보는 화면(Notifier)이 있는 동안만(autoDispose).

@riverpod
SearchPlacesUseCase searchPlacesUseCase(Ref ref) =>
    SearchPlacesUseCase(ref.watch(placeRepositoryProvider));

@riverpod
SearchPlacesByCategoryUseCase searchPlacesByCategoryUseCase(Ref ref) =>
    SearchPlacesByCategoryUseCase(ref.watch(placeRepositoryProvider));

@riverpod
RecentSearchesUseCase recentSearchesUseCase(Ref ref) =>
    RecentSearchesUseCase(ref.watch(recentSearchRepositoryProvider));

@riverpod
RecentPlacesUseCase recentPlacesUseCase(Ref ref) =>
    RecentPlacesUseCase(ref.watch(recentPlaceRepositoryProvider));
