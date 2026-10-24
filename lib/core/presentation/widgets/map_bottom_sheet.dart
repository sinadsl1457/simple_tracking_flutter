// [core/presentation] 지도 위 하단 시트(접힘·중간·펼침). 현재 높이를 부모에 알려 내 위치 버튼을 시트 위에 붙인다.
// 사용처: MapScreen의 장소 결과 시트, 대중교통 목록 시트

import 'package:flutter/material.dart';

enum SheetDetent { collapsed, medium, large }

/// 지도 위에 얹는 하단 시트. 끌어서 세 높이(접힘·중간·펼침)에 붙는다.
///
/// 현재 높이를 [onHeightChanged]로 알려 다른 버튼을 시트 위에 붙일 수 있다.
/// [detent]를 바꾸면 그 높이로 움직인다.
class MapBottomSheet extends StatefulWidget {
  const MapBottomSheet({
    required this.detent,
    required this.header,
    required this.slivers,
    required this.onHeightChanged,
    this.topReservedHeight = 72,
    super.key,
  });

  final SheetDetent detent;
  final Widget header;

  /// 본문. 목록은 SliverList, 나머지는 SliverToBoxAdapter로 넘긴다.
  final List<Widget> slivers;
  final ValueChanged<double> onHeightChanged;

  /// 펼쳤을 때 위에 남겨 둘 공간(검색창 자리).
  final double topReservedHeight;

  static const collapsedHeight = 230.0;
  static const mediumSize = 0.45;

  @override
  State<MapBottomSheet> createState() => _MapBottomSheetState();
}

class _MapBottomSheetState extends State<MapBottomSheet> {
  final _controller = DraggableScrollableController();
  double _containerHeight = 0;

  double _size(SheetDetent detent) => switch (detent) {
    SheetDetent.collapsed => MapBottomSheet.collapsedHeight / _containerHeight,
    SheetDetent.medium => MapBottomSheet.mediumSize,
    SheetDetent.large =>
      (_containerHeight - widget.topReservedHeight) / _containerHeight,
  };

  @override
  void didUpdateWidget(MapBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.detent != widget.detent && _controller.isAttached) {
      _controller
          .animateTo(
            _size(widget.detent),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          )
          .ignore();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _containerHeight = constraints.maxHeight;
        final sizes = [for (final d in SheetDetent.values) _size(d)];
        final initial = _size(widget.detent);
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => widget.onHeightChanged(
            (_controller.isAttached ? _controller.size : initial) *
                _containerHeight,
          ),
        );

        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (n) {
            widget.onHeightChanged(n.extent * _containerHeight);
            return false;
          },
          child: DraggableScrollableSheet(
            controller: _controller,
            initialChildSize: initial,
            minChildSize: sizes.first,
            maxChildSize: sizes.last,
            snap: true,
            // 반드시 const. DraggableScrollableSheet는 snapSizes를 ==가 아닌
            // 객체 동일성으로 비교해, 빌드마다 새 리스트를 주면 "snap 설정이 바뀌었다"며
            // 다음 프레임에 가장 가까운 높이로 되돌리고 사용자 드래그를 끊는다.
            snapSizes: const [MapBottomSheet.mediumSize],
            builder: (context, scrollController) => DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(child: _Handle(header: widget.header)),
                  ...widget.slivers,
                  SliverPadding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.paddingOf(context).bottom + 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Handle extends StatelessWidget {
  const _Handle({required this.header});

  final Widget header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 5,
          margin: const EdgeInsets.only(top: 8, bottom: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        header,
      ],
    );
  }
}
