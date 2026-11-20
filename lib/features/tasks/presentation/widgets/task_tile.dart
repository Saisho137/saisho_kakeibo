import 'package:flutter_archetype/core/extensions/build_context_x.dart';
import 'package:flutter_archetype/features/tasks/domain/entities/task.dart';
import 'package:flutter_archetype/l10n/l10n.dart';
import 'package:material_ui/material_ui.dart';

class TaskTile extends StatelessWidget {
  const new({
    required this.task,
    required this.onToggle,
    required this.onDelete,
    super.key,
  });

  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(value: task.isDone, onChanged: (_) => onToggle()),
      title: Text(
        task.title,
        style: task.isDone
            ? context.textTheme.bodyLarge?.copyWith(
                decoration: TextDecoration.lineThrough,
                color: context.colors.onSurfaceVariant,
              )
            : null,
      ),
      trailing: IconButton(
        tooltip: context.l10n.tasksDeleteTooltip,
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
    );
  }
}
