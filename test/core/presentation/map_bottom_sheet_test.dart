import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/core/presentation/widgets/map_bottom_sheet.dart';

void main() {
  testWidgets('핸들을 끌면 펼쳐지고 목록은 스크롤된다', (tester) async {
    final heights = <double>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: StatefulBuilder(
                  builder: (context, setState) => MapBottomSheet(
                    detent: SheetDetent.medium,
                    onHeightChanged: (h) {
                      if (heights.isEmpty || heights.last != h) {
                        setState(() => heights.add(h));
                      }
                    },
                    header: const Text('header'),
                    slivers: [
                      SliverList.builder(
                        itemCount: 40,
                        itemBuilder: (_, i) =>
                            SizedBox(height: 60, child: Text('row $i')),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    // 테스트 화면 높이 600: 중간 = 600 * 0.45, 펼침 = 600 - 72
    expect(heights.last, 270);

    // timedDrag: 실제 손가락처럼 프레임 사이사이에 움직인다. tester.drag는 이동을
    // 한꺼번에 보내서, 다음 프레임에 일어나는 리셋 버그를 재현하지 못했다.
    await tester.timedDrag(
      find.text('header'),
      const Offset(0, -200),
      const Duration(milliseconds: 400),
    );
    await tester.pumpAndSettle();
    expect(heights.last, 528);

    await tester.timedDrag(
      find.text('row 3'),
      const Offset(0, -300),
      const Duration(milliseconds: 400),
    );
    await tester.pumpAndSettle();
    expect(find.text('row 0'), findsNothing);
  });
}
