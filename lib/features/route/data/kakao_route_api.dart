// [route/data] 카카오 길찾기 REST API 정의(Retrofit): 자동차(카카오모빌리티), 도보, 대중교통.
// 호출하는 곳: route_repository_impl.dart

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:simple_tracking/features/route/data/dto/directions_dto.dart';
import 'package:simple_tracking/features/route/data/dto/routing_dto.dart';

part 'kakao_route_api.g.dart';

@lazySingleton
@RestApi(baseUrl: 'https://dapi.kakao.com')
abstract class KakaoRouteApi {
  @factoryMethod
  factory KakaoRouteApi(Dio dio) = _KakaoRouteApi;

  /// 카카오모빌리티는 호스트가 달라 절대 URL을 쓴다.
  /// [origin]·[destination]은 "경도,위도" 순서.
  /// priority는 최단 거리(DISTANCE)가 막히는 길로 돌아 더 오래 걸릴 수 있어
  /// 카카오 기본값인 추천 경로(RECOMMEND)를 쓴다.
  @GET('https://apis-navi.kakaomobility.com/v1/directions')
  Future<DirectionsResponseDto> directions(
    @Query('origin') String origin,
    @Query('destination') String destination, {
    @Query('priority') String priority = 'RECOMMEND',
  });

  /// 카카오맵 경로 API는 좌표를 x(경도)·y(위도) 파라미터로 따로 받는다.
  @GET('/v2/routing/walk')
  Future<WalkResponseDto> walk({
    @Query('start_x') required double startX,
    @Query('start_y') required double startY,
    @Query('end_x') required double endX,
    @Query('end_y') required double endY,
  });

  @GET('/v2/routing/publictraffic')
  Future<TransitResponseDto> transit({
    @Query('start_x') required double startX,
    @Query('start_y') required double startY,
    @Query('end_x') required double endX,
    @Query('end_y') required double endY,
  });
}
