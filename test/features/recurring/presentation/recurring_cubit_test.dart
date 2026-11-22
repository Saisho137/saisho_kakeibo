import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/set_recurring_template_active.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/watch_recurring_templates.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/cubit/recurring_cubit.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/recurring_fixtures.dart';

class _MockWatchTemplates extends Mock implements WatchRecurringTemplates;

class _MockWatchAccounts extends Mock implements WatchAccounts;

class _MockWatchCategories extends Mock implements WatchCategories;

class _MockWatchPayees extends Mock implements WatchPayees;

class _MockWatchCurrencies extends Mock implements WatchCurrencies;

class _MockSetActive extends Mock implements SetRecurringTemplateActive;

void main() {
  late _MockWatchTemplates watchTemplates;
  late _MockWatchAccounts watchAccounts;
  late _MockWatchCategories watchCategories;
  late _MockWatchPayees watchPayees;
  late _MockWatchCurrencies watchCurrencies;
  late _MockSetActive setActive;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const netflix = Payee(id: 4, name: 'Netflix', key: 'netflix');
  final bank = account(id: 1);
  final food = category(id: 10);

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(
      const SetRecurringTemplateActiveParams(id: 0, active: true),
    );
  });

  setUp(() {
    watchTemplates = _MockWatchTemplates();
    watchAccounts = _MockWatchAccounts();
    watchCategories = _MockWatchCategories();
    watchPayees = _MockWatchPayees();
    watchCurrencies = _MockWatchCurrencies();
    setActive = _MockSetActive();
    when(() => watchTemplates(any()))
        .thenAnswer((_) => Stream.value([template(payeeId: 4)]));
    when(() => watchAccounts(any())).thenAnswer((_) => Stream.value([bank]));
    when(() => watchCategories(any())).thenAnswer((_) => Stream.value([food]));
    when(() => watchPayees(any())).thenAnswer((_) => Stream.value([netflix]));
    when(() => watchCurrencies(any())).thenAnswer((_) => Stream.value([cop]));
    when(() => setActive(any())).thenAnswer((_) async => const Ok(null));
  });

  RecurringCubit buildCubit() => RecurringCubit(
    watchTemplates: watchTemplates,
    watchAccounts: watchAccounts,
    watchCategories: watchCategories,
    watchPayees: watchPayees,
    watchCurrencies: watchCurrencies,
    setActive: setActive,
  );

  group('RecurringCubit', () {
    blocTest<RecurringCubit, RecurringState>(
      'is ready once every stream arrives',
      build: buildCubit,
      act: (cubit) => cubit.load(),
      verify: (cubit) {
        final state = cubit.state;
        final t = state.templates!.single;
        expect(state.status, RecurringStatus.success);
        expect(state.accountOf(t.accountId), bank);
        expect(state.categoryOf(t), food);
        expect(state.payeeOf(t), netflix);
        expect(state.currencyOf(t), cop);
      },
    );

    blocTest<RecurringCubit, RecurringState>(
      'pauses a template and reports failures',
      build: buildCubit,
      act: (cubit) async {
        await cubit.setActive(1, value: false);
        when(() => setActive(any()))
            .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
        await cubit.setActive(1, value: true);
      },
      verify: (cubit) {
        final params =
            verify(() => setActive(captureAny())).captured.first
                as SetRecurringTemplateActiveParams;
        expect(params.id, 1);
        expect(params.active, isFalse);
        expect(cubit.state.failure, isA<DatabaseFailure>());
      },
    );

    blocTest<RecurringCubit, RecurringState>(
      'reports a stream error',
      setUp: () =>
          when(() => watchTemplates(any()))
              .thenAnswer((_) => Stream.error(Exception('disk'))),
      build: buildCubit,
      act: (cubit) => cubit.load(),
      verify: (cubit) => expect(cubit.state.status, RecurringStatus.failure),
    );

    test('cancels its streams when closed', () async {
      final controller = StreamController<List<RecurringTemplate>>();
      when(() => watchTemplates(any())).thenAnswer((_) => controller.stream);
      final cubit = buildCubit()..load();

      await cubit.close();

      expect(controller.hasListener, isFalse);
    });
  });
}
