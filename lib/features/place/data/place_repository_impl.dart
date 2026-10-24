// [place/data] PlaceRepository 구현: API 호출 → DTO → Place. 실패 처리는 safeApiCall.

import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/core/network/safe_api_call.dart';
import 'package:simple_tracking/features/place/data/dto/place_dto.dart';
import 'package:simple_tracking/features/place/data/kakao_place_api.dart';
import 'package:simple_tracking/features/place/data/place_mapper.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';
import 'package:simple_tracking/features/place/domain/place_repository.dart';

@LazySingleton(as: PlaceRepository)
class PlaceRepositoryImpl implements PlaceRepository {
  const PlaceRepositoryImpl(this._api);

  final KakaoPlaceApi _api;

  @override
  Future<Result<List<Place>>> searchByKeyword(
    String query, {
    GeoPoint? center,
  }) => safeApiCall(() async {
    final response = await _api.searchKeyword(
      query,
      x: center?.longitude,
      y: center?.latitude,
    );
    return _places(response);
  });

  @override
  Future<Result<List<Place>>> searchByCategory(
    PlaceCategory category, {
    required GeoPoint center,
    required int radiusMeters,
  }) => safeApiCall(() async {
    final response = await _api.searchCategory(
      category.kakaoCode,
      x: center.longitude,
      y: center.latitude,
      radius: radiusMeters,
    );
    return _places(response);
  });

  /// 좌표가 깨진 장소는 건너뛴다.
  static List<Place> _places(PlaceSearchResponseDto response) =>
      response.documents.map((d) => d.toDomain()).nonNulls.toList();
}
