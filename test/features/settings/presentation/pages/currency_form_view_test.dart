import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/settings/domain/rules/currency_rules.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/currency_form_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/pages/currency_form_page.dart';

import '../../../../helpers/helpers.dart';

void main() {
  late MockCurrencyFormCubit cubit;
  late MockSettingsCubit settingsCubit;
  late MockGoRouter router;

  const eur = Currency(
    code: 'EUR',
    symbol: '€',
    format: CurrencyFormat(decimals: 2, thousandsSeparator: ' '),
  );
  const creating = CurrencyFormState(status: CurrencyFormStatus.editing);
  const editing = CurrencyFormState(
    status: CurrencyFormStatus.editing,
    original: eur,
    code: 'EUR',
    symbol: '€',
    thousandsSeparator: ' ',
  );

  setUp(() {
    cubit = MockCurrencyFormCubit();
    settingsCubit = MockSettingsCubit();
    router = MockGoRouter();
    when(() => settingsCubit.state)
        .thenReturn(const SettingsState(status: SettingsStatus.ready));
    when(() => cubit.submit()).thenAnswer((_) async {});
    when(() => cubit.delete()).thenAnswer((_) async {});
    when(() => router.canPop()).thenReturn(true);
  });

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<CurrencyFormCubit>.value(value: cubit),
          BlocProvider<SettingsCubit>.value(value: settingsCubit),
        ],
        child: const CurrencyFormView(),
      ),
      router: router,
    );
  }

  group('CurrencyFormView', () {
    testWidgets('shows a progress indicator while loading', (tester) async {
      when(() => cubit.state).thenReturn(const CurrencyFormState());

      await pumpView(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains a missing currency', (tester) async {
      when(() => cubit.state).thenReturn(
        const CurrencyFormState(status: CurrencyFormStatus.notFound),
      );

      await pumpView(tester);

      expect(find.text('This currency no longer exists.'), findsOneWidget);
    });

    testWidgets('creating warns that decimals are permanent', (tester) async {
      when(() => cubit.state).thenReturn(creating);

      await pumpView(tester);

      expect(find.text('New currency'), findsOneWidget);
      expect(
        find.text("Decimals can't be changed after creating the currency."),
        findsOneWidget,
      );
      expect(find.text('Preview: 1.234.567,89'), findsOneWidget);
      expect(find.byTooltip('Delete currency'), findsNothing);
    });

    testWidgets('forwards every field to the cubit', (tester) async {
      when(() => cubit.state).thenReturn(creating);

      await pumpView(tester);
      await tester.enterText(find.byType(TextFormField).at(0), 'eur');
      await tester.enterText(find.byType(TextFormField).at(1), '€');
      await tester.tap(find.text('0'));
      await tester.tap(find.text('Space'));
      await tester.tap(find.text('Dot').last);
      await tester.tap(find.text('Save'));

      verify(() => cubit.codeChanged('eur')).called(1);
      verify(() => cubit.symbolChanged('€')).called(1);
      verify(() => cubit.decimalsChanged(0)).called(1);
      verify(() => cubit.thousandsSeparatorChanged(' ')).called(1);
      verify(() => cubit.decimalSeparatorChanged('.')).called(1);
      verify(() => cubit.submit()).called(1);
    });

    testWidgets('shows field errors', (tester) async {
      when(() => cubit.state).thenReturn(
        creating.copyWith(
          showErrors: true,
          decimalSeparator: '.',
          errors: {
            CurrencyError.invalidCode,
            CurrencyError.invalidSymbol,
            CurrencyError.sameSeparators,
          },
        ),
      );

      await pumpView(tester);

      expect(find.text('Use three letters, A to Z.'), findsOneWidget);
      expect(find.text('Use 1 to 4 characters.'), findsOneWidget);
      expect(find.text('Separators must be different.'), findsOneWidget);
      expect(find.textContaining('Preview'), findsNothing);
    });

    testWidgets('shows a duplicated code error', (tester) async {
      when(() => cubit.state).thenReturn(
        creating.copyWith(
          showErrors: true,
          errors: {CurrencyError.duplicateCode},
        ),
      );

      await pumpView(tester);

      expect(find.text('That currency already exists.'), findsOneWidget);
    });

    testWidgets('editing locks code and decimals', (tester) async {
      when(() => cubit.state).thenReturn(editing);

      await pumpView(tester);

      expect(find.text('Edit EUR'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(
        find.text(
          "Decimals can't be changed: every amount is stored with them.",
        ),
        findsOneWidget,
      );
      expect(find.text('Preview: 1 234 567,89'), findsOneWidget);
    });

    testWidgets('deletes a user currency after confirming', (tester) async {
      when(() => cubit.state).thenReturn(editing);

      await pumpView(tester);
      await tester.tap(find.byTooltip('Delete currency'));
      await tester.pumpAndSettle();
      expect(find.text('Delete EUR?'), findsOneWidget);
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      verify(() => cubit.delete()).called(1);
    });

    testWidgets('cancelling the confirmation keeps the currency', (
      tester,
    ) async {
      when(() => cubit.state).thenReturn(editing);

      await pumpView(tester);
      await tester.tap(find.byTooltip('Delete currency'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(() => cubit.delete());
    });

    testWidgets('built-in currencies cannot be deleted', (tester) async {
      when(
        () => cubit.state,
      ).thenReturn(editing.copyWith(original: eur.copyWith(isBuiltIn: true)));

      await pumpView(tester);

      expect(find.byTooltip('Delete currency'), findsNothing);
      expect(find.text("Built-in currencies can't be deleted."), findsOne);
    });

    testWidgets('the main currency cannot be deleted', (tester) async {
      when(() => settingsCubit.state).thenReturn(
        const SettingsState(settings: AppSettings(mainCurrencyCode: 'EUR')),
      );
      when(() => cubit.state).thenReturn(editing);

      await pumpView(tester);

      expect(find.byTooltip('Delete currency'), findsNothing);
      expect(find.text("The main currency can't be deleted."), findsOne);
    });

    testWidgets('currencies in use cannot be deleted', (tester) async {
      when(() => cubit.state).thenReturn(editing.copyWith(inUse: true));

      await pumpView(tester);

      expect(find.byTooltip('Delete currency'), findsNothing);
      expect(
        find.text("Currencies used by an account can't be deleted."),
        findsOne,
      );
    });

    testWidgets('goes back after saving', (tester) async {
      whenListen(
        cubit,
        Stream.value(editing.copyWith(status: CurrencyFormStatus.saved)),
        initialState: editing,
      );

      await pumpView(tester);
      await tester.pump();

      verify(() => router.pop<Object?>()).called(1);
    });

    testWidgets('shows a snackbar when saving fails', (tester) async {
      whenListen(
        cubit,
        Stream.value(editing.copyWith(failure: const DatabaseFailure('x'))),
        initialState: editing,
      );

      await pumpView(tester);
      await tester.pump();

      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });
  });
}
