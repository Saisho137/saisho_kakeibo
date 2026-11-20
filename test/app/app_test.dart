import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_archetype/app/app.dart';
import 'package:flutter_archetype/app/di/injector.dart';
import 'package:flutter_archetype/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_archetype/features/tasks/presentation/pages/tasks_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockTasksCubit extends MockCubit<TasksState> implements TasksCubit;

void main() {
  setUp(() {
    final cubit = _MockTasksCubit();
    when(() => cubit.state).thenReturn(const TasksState());
    when(cubit.load).thenReturn(null);
    getIt.registerFactory<TasksCubit>(() => cubit);
  });

  tearDown(getIt.reset);

  group('App', () {
    testWidgets('renders TasksPage as the initial route', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pump();

      expect(find.byType(TasksPage), findsOneWidget);
    });
  });
}
