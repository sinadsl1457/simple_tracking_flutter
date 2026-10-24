// [place/domain] 장소 검색 저장소 인터페이스. 구현: data/place_repository_impl.dart

import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';

abstract interface class PlaceRepository {
  /// [center]는 거리 계산 기준 좌표. null이면 결과의 `distanceMeters`도 null이다.
  Future<Result<List<Place>>> searchByKeyword(String query, {GeoPoint? center});

  /// [center] 반경 [radiusMeters] 안의 장소를 가까운 순으로 찾는다.
  Future<Result<List<Place>>> searchByCategory(
    PlaceCategory category, {
    required GeoPoint center,
    required int radiusMeters,
  });
}
