import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/place/domain/recent_searches_use_case.dart';

import '../../fakes/fake_repositories.dart';

void main() {
  RecentSearchesUseCase useCase([List<String> initial = const []]) =>
      RecentSearchesUseCase(FakeRecentSearchRepository(initial));

  test('새 검색어가 맨 앞에 온다', () async {
    expect(await useCase(['카페']).add('편의점'), ['편의점', '카페']);
  });

  test('중복 검색어는 맨 앞으로 옮긴다', () async {
    expect(await useCase(['a', 'b', 'c']).add('c'), ['c', 'a', 'b']);
  });

  test('공백을 정리하고, 빈 검색어는 무시한다', () async {
    final sut = useCase(['카페']);
    expect(await sut.add('  강남   역 '), ['강남 역', '카페']);
    expect(await sut.add('   '), ['강남 역', '카페']);
  });

  test('최대 10개까지만 둔다', () async {
    final result = await useCase([for (var i = 1; i <= 10; i++) 'q$i'])
        .add('new');

    expect(result, hasLength(10));
    expect(result.first, 'new');
    expect(result, isNot(contains('q10')));
  });

  test('삭제와 전체 삭제', () async {
    final sut = useCase(['a', 'b']);
    expect(await sut.remove('a'), ['b']);
    await sut.clear();
    expect(await sut.list(), isEmpty);
  });
}
