import 'package:flutter_archetype/features/tasks/presentation/widgets/task_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('TaskTile', () {
    testWidgets('calls onToggle when the checkbox is tapped', (tester) async {
      var toggled = false;

      await tester.pumpApp(
        Material(
          child: TaskTile(
            task: buildTask(),
            onToggle: () => toggled = true,
            onDelete: () {},
          ),
        ),
      );
      await tester.tap(find.byType(Checkbox));

      expect(toggled, isTrue);
    });

    testWidgets('strikes through a done task', (tester) async {
      await tester.pumpApp(
        Material(
          child: TaskTile(
            task: buildTask(isDone: true),
            onToggle: () {},
            onDelete: () {},
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Buy milk'));
      expect(text.style?.decoration, TextDecoration.lineThrough);
    });
  });
}
