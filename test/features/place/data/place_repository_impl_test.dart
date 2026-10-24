import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/error/result.dart';
import 'package:simple_tracking/core/geo/geo_point.dart';
import 'package:simple_tracking/features/place/data/kakao_place_api.dart';
import 'package:simple_tracking/features/place/data/place_repository_impl.dart';
import 'package:simple_tracking/features/place/domain/place.dart';
import 'package:simple_tracking/features/place/domain/place_category.dart';

import '../../../fakes/fixtures.dart';
import '../../../fakes/stub_dio.dart';

const _emptyDocuments = '{"documents": []}';

void main() {
  test('키워드 검색은 인증 헤더와 쿼리를 보낸다', () async {
    final adapter = StubAdapter(json: _emptyDocuments);
    await PlaceRepositoryImpl(KakaoPlaceApi(stubDio(adapter, key: 'test-key')))
        .searchByKeyword('강남 카페', center: Fixtures.cityHall);

    final request = adapter.last!;
    expect(request.headers['Authorization'], 'KakaoAK test-key');
    expect(request.uri.host, 'dapi.kakao.com');
    expect(request.uri.path, '/v2/local/search/keyword.json');
    expect(request.query('query'), '강남 카페');
    expect(request.query('x'), '126.9784');
    expect(request.query('y'), '37.5666');
    expect(request.query('size'), '15');
  });

  test('중심 좌표가 없으면 x·y를 보내지 않는다', () async {
    final adapter = StubAdapter(json: _emptyDocuments);
    await PlaceRepositoryImpl(KakaoPlaceApi(stubDio(adapter)))
        .searchByKeyword('카페');

    expect(adapter.last!.query('x'), isNull);
    expect(adapter.last!.query('y'), isNull);
  });

  test('카테고리 검색은 코드·중심·반경을 보낸다', () async {
    final adapter = StubAdapter(json: _emptyDocuments);
    await PlaceRepositoryImpl(KakaoPlaceApi(stubDio(adapter))).searchByCategory(
      PlaceCategory.cafe,
      center: Fixtures.cityHall,
      radiusMeters: 1000,
    );

    final request = adapter.last!;
    expect(request.uri.path, '/v2/local/search/category.json');
    expect(request.query('category_group_code'), 'CE7');
    expect(request.query('x'), '126.9784');
    expect(request.query('y'), '37.5666');
    expect(request.query('radius'), '1000');
    expect(request.query('sort'), 'distance');
    expect(request.query('size'), '15');
  });

  test('응답을 변환하고 좌표가 깨진 장소는 건너뛴다', () async {
    const json = '''
    {
      "meta": {"total_count": 2},
      "documents": [
        {
          "id": "8", "place_name": "서울시청", "category_name": "공공,사회기관 > 행정기관 > 시청",
          "address_name": "서울 중구 태평로1가 31", "road_address_name": "서울 중구 세종대로 110",
          "phone": "02-120", "x": "126.9784", "y": "37.5666", "distance": "", "place_url": "http://place.map.kakao.com/8"
        },
        {
          "id": "9", "place_name": "좌표 없음", "category_name": "", "address_name": "", "road_address_name": "",
          "phone": "", "x": "", "y": "", "distance": ""
        }
      ]
    }
    ''';

    final result = await PlaceRepositoryImpl(
      KakaoPlaceApi(stubDio(StubAdapter(json: json))),
    ).searchByKeyword('시청');

    expect(
      result,
      const Result.ok([
        Place(
          id: '8',
          name: '서울시청',
          category: '시청',
          address: '서울 중구 세종대로 110',
          phone: '02-120',
          location: GeoPoint(latitude: 37.5666, longitude: 126.9784),
        ),
      ]),
    );
  });
}
