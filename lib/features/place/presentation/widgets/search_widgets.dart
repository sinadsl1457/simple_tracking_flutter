// [place/presentation] 검색 페이지 공용 조각(검색창 줄, 최근 검색어 줄). SearchPage와 EndpointPickerPage가 같이 쓴다.

import 'package:flutter/material.dart';

/// 검색 페이지 상단 줄: 뒤로, 입력칸, 진행 표시 또는 지우기 버튼.
/// 지도 검색 페이지와 길찾기 출발지·도착지 선택 페이지가 같이 쓴다.
class SearchFieldBar extends StatelessWidget {
  const SearchFieldBar({
    required this.controller,
    required this.isSubmitting,
    required this.onBack,
    required this.onChanged,
    required this.onSubmitted,
    this.hintText = '장소, 주소 검색',
    super.key,
  });

  final TextEditingController controller;
  final bool isSubmitting;
  final VoidCallback onBack;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new),
            tooltip: '뒤로',
          ),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              autocorrect: false,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              onChanged: onChanged,
              onSubmitted: (_) => onSubmitted(),
            ),
          ),
          if (isSubmitting)
            const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            ListenableBuilder(
              listenable: controller,
              builder: (context, _) => controller.text.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () {
                        controller.clear();
                        onChanged('');
                      },
                      icon: Icon(Icons.cancel, color: secondary),
                      tooltip: '입력 지우기',
                    ),
            ),
        ],
      ),
    );
  }
}

/// 최근 검색어 한 줄. 누르면 다시 검색하고, X로 지운다.
class RecentQueryTile extends StatelessWidget {
  const RecentQueryTile({
    required this.query,
    required this.onTap,
    required this.onRemove,
    super.key,
  });

  final String query;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.onSurfaceVariant;
    return ListTile(
      leading: Icon(Icons.history, color: secondary),
      title: Text(query),
      onTap: onTap,
      trailing: IconButton(
        onPressed: onRemove,
        icon: Icon(Icons.close, size: 18, color: secondary),
        tooltip: '$query 삭제',
      ),
    );
  }
}
