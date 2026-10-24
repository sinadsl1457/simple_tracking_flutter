// [place/domain] 최근 장소 저장소 인터페이스. 구현: data/shared_prefs_recent_place_repository.dart

import 'package:simple_tracking/features/place/domain/recent_place.dart';

/// 최근 장소 저장소. 순서·개수 규칙은 `RecentPlacesUseCase`가 정한다.
abstract interface class RecentPlaceRepository {
  Future<List<RecentPlace>> load();
  Future<void> save(List<RecentPlace> places);
}
