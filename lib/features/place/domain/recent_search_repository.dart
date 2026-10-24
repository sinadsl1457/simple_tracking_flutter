// [place/domain] 최근 "검색어(문자열)" 저장소 인터페이스. 구현: data/shared_prefs_recent_search_repository.dart

/// 최근 검색어 저장소. 순서·개수 규칙은 `RecentSearchesUseCase`가 정한다.
abstract interface class RecentSearchRepository {
  Future<List<String>> load();
  Future<void> save(List<String> queries);
}
