// [place/domain] 최근 장소 규칙(최신순, 같은 장소 1번, 20개).
// 기록하는 곳: PlaceSearchCubit.select, EndpointSearchCubit.remember,
//             RoutePlannerCubit.chooseRecent

import 'package:injectable/injectable.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';
import 'package:simple_tracking/features/place/domain/recent_place_repository.dart';

/// 최근에 고른 장소. 가장 최근 것이 앞에 오고, 같은 장소(id)는 한 번만,
/// 최대 [maxCount]개까지 둔다.
@injectable
class RecentPlacesUseCase {
  const RecentPlacesUseCase(this._repository);

  static const maxCount = 20;

  final RecentPlaceRepository _repository;

  Future<List<RecentPlace>> list() => _repository.load();

  Future<List<RecentPlace>> add(Place place, {DateTime? now}) async {
    final places = [
      RecentPlace(place: place, usedAt: now ?? DateTime.now()),
      ...(await _repository.load()).where((r) => r.place.id != place.id),
    ].take(maxCount).toList();
    await _repository.save(places);
    return places;
  }

  Future<List<RecentPlace>> remove(String placeId) async {
    final places = (await _repository.load())
        .where((r) => r.place.id != placeId)
        .toList();
    await _repository.save(places);
    return places;
  }
}
