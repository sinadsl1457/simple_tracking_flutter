// [place/data] 카카오 로컬 검색 REST API 정의(Retrofit). 구현 코드는 생성 파일 kakao_place_api.g.dart.
// 인증 헤더는 Dio 인터셉터가 붙인다. 호출하는 곳: place_repository_impl.dart

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:simple_tracking/features/place/data/dto/place_dto.dart';

part 'kakao_place_api.g.dart';

@lazySingleton
@RestApi(baseUrl: 'https://dapi.kakao.com')
abstract class KakaoPlaceApi {
  @factoryMethod
  factory KakaoPlaceApi(Dio dio) = _KakaoPlaceApi;

  static const pageSize = 15;

  /// [x]·[y]가 null이면 쿼리에서 빠진다.
  @GET('/v2/local/search/keyword.json')
  Future<PlaceSearchResponseDto> searchKeyword(
    @Query('query') String query, {
    @Query('x') double? x,
    @Query('y') double? y,
    @Query('size') int size = KakaoPlaceApi.pageSize,
  });

  /// 응답 형식은 키워드 검색과 같다.
  @GET('/v2/local/search/category.json')
  Future<PlaceSearchResponseDto> searchCategory(
    @Query('category_group_code') String code, {
    @Query('x') required double x,
    @Query('y') required double y,
    @Query('radius') required int radius,
    @Query('sort') String sort = 'distance',
    @Query('size') int size = KakaoPlaceApi.pageSize,
  });
}
