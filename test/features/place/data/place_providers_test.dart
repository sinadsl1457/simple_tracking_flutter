// [place/data] 조립 확인: UseCase 레시피가 저장소 레시피를, 저장소가 prefs·Dio를 재료로 받는다.
// 맨 아래(저장소·prefs)만 바꿔 끼워도 UseCase가 그걸 쓰는지 본다(get_it 다리였을 때는 안 됐던 것).

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_tracking/core/storage/shared_preferences_provider.dart';
import 'package:simple_tracking/features/place/data/place_providers.dart';
import 'package:simple_tracking/features/place/data/place_repository_impl.dart';

import '../../../fakes/fake_repositories.dart';

void main() {
  test('저장소만 가짜로 바꿔도 검색 UseCase가 그 저장소를 쓴다', () async {
    final fake = FakePlaceRepository();
    final container = ProviderContainer.test(
      overrides: [placeRepositoryProvider.overrideWithValue(fake)],
    );

    await container.read(searchPlacesUseCaseProvider)('  카페  ');

    expect(fake.receivedQueries, ['카페']);
  });

  test('최근 검색어는 main에서 넣은 SharedPreferences에 저장된다', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer.test(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );

    await container.read(recentSearchesUseCaseProvider).add('스타벅스');

    // 창고를 새로 열어도(앱 재실행) 같은 prefs면 남아 있다.
    final next = ProviderContainer.test(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    expect(await next.read(recentSearchesUseCaseProvider).list(), ['스타벅스']);
  });

  test('아무것도 안 바꾸면 진짜 저장소(Dio로 카카오 API)가 조립된다', () {
    final container = ProviderContainer.test();

    expect(container.read(placeRepositoryProvider), isA<PlaceRepositoryImpl>());
  });
}
