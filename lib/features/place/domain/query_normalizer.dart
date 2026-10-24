// [place/domain] 검색어 공백 정리. 검색과 최근 검색어 저장이 같은 규칙을 쓰도록 한곳에 둔다.

/// 앞뒤 공백을 지우고 연속된 공백(탭·줄바꿈 포함)을 하나로 줄인다.
String normalizeQuery(String query) =>
    query.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).join(' ');
