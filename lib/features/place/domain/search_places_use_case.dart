// [place/domain] 키워드 검색: 공백 정리 → 빈 검색어면 API를 부르지 않고 emptyQuery.
// 사용처: PlaceSearchCubit, EndpointSearchCubit

import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/error/failure.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/place_repository.dart';
import 'package:simple_tracking/features/place/domain/query_normalizer.dart';

@injectable
class SearchPlacesUseCase {
  const SearchPlacesUseCase(this._repository);

  final PlaceRepository _repository;

  Future<Result<List<Place>>> call(String query, {GeoPoint? center}) async {
    final normalized = normalizeQuery(query);
    if (normalized.isEmpty) return const Result.err(Failure.emptyQuery());
    return await _repository.searchByKeyword(normalized, center: center);
  }
}
