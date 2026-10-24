// [place/domain] 카테고리 검색: 중심에서 반경 1km. 사용처: PlaceSearchCubit

import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';
import 'package:simple_tracking/features/place/domain/place_repository.dart';

@injectable
class SearchPlacesByCategoryUseCase {
  const SearchPlacesByCategoryUseCase(this._repository);

  static const radiusMeters = 1000;

  final PlaceRepository _repository;

  Future<Result<List<Place>>> call(
    PlaceCategory category, {
    required GeoPoint around,
  }) => _repository.searchByCategory(
    category,
    center: around,
    radiusMeters: radiusMeters,
  );
}
