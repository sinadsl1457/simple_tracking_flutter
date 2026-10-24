// [place/data] 최근 검색어를 SharedPreferences 문자열 목록으로 저장.

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_tracking/features/place/domain/recent_search_repository.dart';

/// 최근 검색어를 기기 안(SharedPreferences)에만 저장한다.
@LazySingleton(as: RecentSearchRepository)
class SharedPrefsRecentSearchRepository implements RecentSearchRepository {
  const SharedPrefsRecentSearchRepository(this._prefs);

  static const key = 'recentSearchQueries';

  final SharedPreferences _prefs;

  @override
  Future<List<String>> load() async => _prefs.getStringList(key) ?? const [];

  @override
  Future<void> save(List<String> queries) => _prefs.setStringList(key, queries);
}
