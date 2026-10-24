// [place/data] 최근 장소를 SharedPreferences에 JSON 문자열 목록으로 저장. 깨진 항목은 건너뛴다.

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_tracking/features/place/data/dto/recent_place_dto.dart';
import 'package:simple_tracking/features/place/domain/recent_place.dart';
import 'package:simple_tracking/features/place/domain/recent_place_repository.dart';

/// 최근 장소를 기기 안(SharedPreferences)에 JSON 문자열 목록으로 저장한다.
@LazySingleton(as: RecentPlaceRepository)
class SharedPrefsRecentPlaceRepository implements RecentPlaceRepository {
  const SharedPrefsRecentPlaceRepository(this._prefs);

  static const key = 'recentPlaces';

  final SharedPreferences _prefs;

  @override
  Future<List<RecentPlace>> load() async {
    final raw = _prefs.getStringList(key) ?? const [];
    // 형식이 바뀐 옛 항목은 건너뛴다.
    return [for (final item in raw) ?_decode(item)];
  }

  @override
  Future<void> save(List<RecentPlace> places) => _prefs.setStringList(key, [
    for (final p in places) jsonEncode(RecentPlaceDto.fromDomain(p).toJson()),
  ]);

  static RecentPlace? _decode(String item) {
    try {
      final json = jsonDecode(item) as Map<String, dynamic>;
      return RecentPlaceDto.fromJson(json).toDomain();
    } on FormatException {
      return null;
    } on CheckedFromJsonException {
      return null;
    }
  }
}
