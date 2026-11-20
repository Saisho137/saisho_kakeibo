import 'package:flutter_archetype/app/di/injector.dart';
import 'package:flutter_archetype/core/error/failure.dart';
import 'package:flutter_archetype/core/theme/app_spacing.dart';
import 'package:flutter_archetype/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_archetype/features/tasks/presentation/widgets/task_tile.dart';
import 'package:flutter_archetype/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// Example feature page. Delete the `tasks` feature when starting a new app.
///
/// The page only wires dependencies; [TasksView] holds the UI so it can be
/// tested with a mocked cubit.
class TasksPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TasksCubit>()..load(),
      child: const TasksView(),
    );
  }
}

class TasksView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<TasksCubit, TasksState>(
      listenWhen: (previous, current) => previous.failure != current.failure,
      listener: (context, state) {
        final message = switch (state.failure) {
          ValidationFailure() => l10n.tasksTitleRequired,
          null => null,
          _ => l10n.genericError,
        };
        if (message != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.tasksTitle)),
        body: Column(
          children: [
            const _AddTaskField(),
            Expanded(
              child: BlocBuilder<TasksCubit, TasksState>(
                builder: (context, state) => switch (state.status) {
                  TasksStatus.loading => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  TasksStatus.failure => Center(child: Text(l10n.genericError)),
                  TasksStatus.success when state.tasks.isEmpty => Center(
                    child: Text(l10n.tasksEmpty),
                  ),
                  TasksStatus.success => ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      final cubit = context.read<TasksCubit>();
                      return TaskTile(
                        key: ValueKey(task.id),
                        task: task,
                        onToggle: () => cubit.toggle(task),
                        onDelete: () => cubit.delete(task.id),
                      );
                    },
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddTaskField extends StatefulWidget {
  const new();

  @override
  State<_AddTaskField> createState() => _AddTaskFieldState();
}

class _AddTaskFieldState extends State<_AddTaskField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    await context.read<TasksCubit>().add(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _submit(),
        decoration: InputDecoration(
          hintText: context.l10n.tasksAddHint,
          suffixIcon: IconButton(
            tooltip: context.l10n.tasksAddTooltip,
            icon: const Icon(Icons.add),
            onPressed: _submit,
          ),
        ),
      ),
    );
  }
}
