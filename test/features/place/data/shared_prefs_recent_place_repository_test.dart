import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_tracking/features/place/data/shared_prefs_recent_place_repository.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';

import '../../../fakes/fixtures.dart';

void main() {
  test('저장한 장소를 그대로 읽는다', () async {
    SharedPreferences.setMockInitialValues({});
    final repository = SharedPrefsRecentPlaceRepository(
      await SharedPreferences.getInstance(),
    );
    final places = [
      RecentPlace(
        place: Fixtures.place('a', latitude: 37.1, longitude: 127.2),
        usedAt: DateTime(2026, 10, 19, 20, 36),
      ),
    ];

    await repository.save(places);

    expect(await repository.load(), places);
  });

  test('깨진 항목은 건너뛴다', () async {
    SharedPreferences.setMockInitialValues({
      SharedPrefsRecentPlaceRepository.key: ['not json', '{"id": 1}'],
    });
    final repository = SharedPrefsRecentPlaceRepository(
      await SharedPreferences.getInstance(),
    );

    expect(await repository.load(), isEmpty);
  });
}
