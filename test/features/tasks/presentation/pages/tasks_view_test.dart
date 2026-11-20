import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_archetype/core/error/failure.dart';
import 'package:flutter_archetype/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_archetype/features/tasks/presentation/pages/tasks_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class _MockTasksCubit extends MockCubit<TasksState> implements TasksCubit;

void main() {
  late _MockTasksCubit cubit;

  setUp(() {
    cubit = _MockTasksCubit();
    when(() => cubit.add(any())).thenAnswer((_) async {});
    when(() => cubit.delete(any())).thenAnswer((_) async {});
  });

  Future<void> pumpView(WidgetTester tester) => tester.pumpApp(
    BlocProvider<TasksCubit>.value(value: cubit, child: const TasksView()),
  );

  group('TasksView', () {
    testWidgets('shows a progress indicator while loading', (tester) async {
      when(() => cubit.state).thenReturn(const TasksState());

      await pumpView(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows an empty message when there are no tasks', (
      tester,
    ) async {
      when(() => cubit.state)
          .thenReturn(const TasksState(status: TasksStatus.success));

      await pumpView(tester);

      expect(find.text('No tasks yet. Add your first one above.'), findsOne);
    });

    testWidgets('lists tasks and deletes one', (tester) async {
      when(() => cubit.state).thenReturn(
        TasksState(status: TasksStatus.success, tasks: [buildTask(id: 5)]),
      );

      await pumpView(tester);
      await tester.tap(find.byTooltip('Delete task'));

      expect(find.text('Buy milk'), findsOneWidget);
      verify(() => cubit.delete(5)).called(1);
    });

    testWidgets('submits the typed title', (tester) async {
      when(() => cubit.state)
          .thenReturn(const TasksState(status: TasksStatus.success));

      await pumpView(tester);
      await tester.enterText(find.byType(TextField), 'Walk the dog');
      await tester.tap(find.byTooltip('Add task'));

      verify(() => cubit.add('Walk the dog')).called(1);
    });

    testWidgets('shows a snackbar for a validation failure', (tester) async {
      whenListen(
        cubit,
        Stream.value(
          const TasksState(
            status: TasksStatus.success,
            failure: ValidationFailure('empty'),
          ),
        ),
        initialState: const TasksState(status: TasksStatus.success),
      );

      await pumpView(tester);
      await tester.pump();

      expect(find.text('Write a title for the task.'), findsOneWidget);
    });
  });
}
