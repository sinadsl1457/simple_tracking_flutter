// [place/domain] 최근 검색어 규칙(최신순, 중복 제거, 10개). 검색 페이지 아래 목록.

import 'package:injectable/injectable.dart';
import 'package:simple_tracking/features/place/domain/query_normalizer.dart';
import 'package:simple_tracking/features/place/domain/recent_search_repository.dart';

/// 최근 검색어. 가장 최근 것이 앞에 오고, 같은 검색어는 한 번만,
/// 최대 [maxCount]개까지 둔다.
@injectable
class RecentSearchesUseCase {
  const RecentSearchesUseCase(this._repository);

  static const maxCount = 10;

  final RecentSearchRepository _repository;

  Future<List<String>> list() => _repository.load();

  Future<List<String>> add(String query) async {
    final normalized = normalizeQuery(query);
    if (normalized.isEmpty) return await _repository.load();
    final queries = [
      normalized,
      ...(await _repository.load()).where((q) => q != normalized),
    ].take(maxCount).toList();
    await _repository.save(queries);
    return queries;
  }

  Future<List<String>> remove(String query) async {
    final queries = (await _repository.load())
        .where((q) => q != query)
        .toList();
    await _repository.save(queries);
    return queries;
  }

  Future<void> clear() => _repository.save(const []);
}
