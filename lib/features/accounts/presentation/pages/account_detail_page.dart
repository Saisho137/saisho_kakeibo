import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/section_header.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_detail_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/widgets/adjust_balance_dialog.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/widgets/movement_tile.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/presentation/widgets/period_label.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// An account with its balance, its actions and its movements by day, one
/// period per page: swiping right goes back in time.
class AccountDetailPage extends StatelessWidget {
  const new({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AccountDetailCubit>()..load(id),
      child: const AccountDetailView(),
    );
  }
}

class AccountDetailView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        // The account was deleted from its edit form.
        BlocListener<AccountDetailCubit, AccountDetailState>(
          listenWhen: (previous, current) =>
              previous.status == AccountDetailStatus.success &&
              current.status == AccountDetailStatus.notFound,
          listener: (context, state) => context.pop(),
        ),
        BlocListener<AccountDetailCubit, AccountDetailState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        ),
      ],
      child: BlocBuilder<AccountDetailCubit, AccountDetailState>(
        builder: (context, state) {
          final account = state.account;
          final currency = state.currency;
          return Scaffold(
            appBar: AppBar(
              title: Text(account?.name ?? ''),
              actions: [
                if (account != null)
                  IconButton(
                    tooltip: l10n.accountEditTooltip,
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () =>
                        context.push(AppRoutes.editAccount(account.id)),
                  ),
              ],
            ),
            body: switch (state.status) {
              AccountDetailStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              AccountDetailStatus.notFound => Center(
                child: Text(l10n.accountDetailNotFound),
              ),
              AccountDetailStatus.success
                  when account != null && currency != null =>
                _Detail(state: state, account: account, currency: currency),
              _ => Center(child: Text(l10n.genericError)),
            },
          );
        },
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const new({
    required this.state,
    required this.account,
    required this.currency,
  });

  final AccountDetailState state;
  final Account account;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final balance = state.balance!;
    final free = state.free;
    final settings = state.settings!;
    return Column(
      children: [
        ListTile(
          leading: CatalogIconAvatar(
            iconKey: account.iconKey,
            color: Color(account.color),
            radius: 24,
          ),
          title: Text(
            '${MoneyFormatter.format(balance, currency.format)} '
            '${currency.code}',
            style: context.textTheme.headlineSmall,
          ),
          subtitle: free == null
              ? null
              : Text(
                  '${l10n.accountFree} '
                  '${MoneyFormatter.format(free, currency.format)}',
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.tune_rounded),
                  label: Text(
                    account.type == AccountType.investment
                        ? l10n.accountUpdateValue
                        : l10n.accountAdjustBalance,
                  ),
                  onPressed: () async {
                    final cubit = context.read<AccountDetailCubit>();
                    final actual = await showAdjustBalanceDialog(
                      context,
                      account: account,
                      currency: currency,
                      current: balance.minor,
                    );
                    if (actual != null) await cubit.adjustBalance(actual);
                  },
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.swap_horiz_rounded),
                  label: Text(l10n.accountTransfer),
                  onPressed: () => context.push(
                    AppRoutes.newTransfer(fromAccountId: account.id),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        Expanded(
          // A new period type or cutoff day starts over on today's period.
          child: _PeriodPages(
            key: ValueKey((settings.periodType, settings.cutoffDay)),
            state: state,
            account: account,
            currency: currency,
          ),
        ),
      ],
    );
  }
}

/// One page per period, today's first; older ones are to the left.
class _PeriodPages extends StatefulWidget {
  const new({
    required this.state,
    required this.account,
    required this.currency,
    super.key,
  });

  final AccountDetailState state;
  final Account account;
  final Currency currency;

  @override
  State<_PeriodPages> createState() => _PeriodPagesState();
}

class _PeriodPagesState extends State<_PeriodPages> {
  late final PageController _controller = PageController(
    initialPage: widget.state.currentIndex,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final periods = widget.state.periods;
    return PageView.builder(
      controller: _controller,
      reverse: true,
      itemCount: periods.length,
      itemBuilder: (context, index) => _PeriodPage(
        period: periods[index],
        state: widget.state,
        account: widget.account,
        currency: widget.currency,
      ),
    );
  }
}

class _PeriodPage extends StatelessWidget {
  const new({
    required this.period,
    required this.state,
    required this.account,
    required this.currency,
  });

  final Period period;
  final AccountDetailState state;
  final Account account;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final days = state.daysIn(period);
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Text(
            periodLabel(context, period),
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium,
          ),
        ),
        if (days.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              l10n.accountNoMovementsInPeriod,
              textAlign: TextAlign.center,
            ),
          ),
        for (final (day, movements) in days) ...[
          SectionHeader(_dayLabel(context, day)),
          for (final movement in movements)
            MovementTile(
              key: ValueKey(movement.id),
              movement: movement,
              accountId: account.id,
              currency: currency,
              category: state.categoryOf(movement),
              payee: state.payeeOf(movement),
              otherAccount: state.accountById(
                movement.accountId == account.id
                    ? movement.toAccountId
                    : movement.accountId,
              ),
              onTap: switch (movement.type) {
                MovementType.adjustment => () => _confirmDeleteAdjustment(
                  context,
                  movement,
                ),
                MovementType.income || MovementType.expense =>
                  () => context.push(AppRoutes.editMovement(movement.id)),
                MovementType.transfer => () => context.push(
                  AppRoutes.editTransfer(movement.id),
                ),
              },
            ),
        ],
      ],
    );
  }

  static String _dayLabel(BuildContext context, LocalDate day) {
    final today = LocalDate.today();
    if (day == today) return context.l10n.dayToday;
    if (day == today.addDays(-1)) return context.l10n.dayYesterday;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final format = day.year == today.year
        ? DateFormat.MMMEd(locale)
        : DateFormat.yMMMEd(locale);
    return format.format(day.toDateTime());
  }

  static Future<void> _confirmDeleteAdjustment(
    BuildContext context,
    Movement movement,
  ) async {
    final l10n = context.l10n;
    final cubit = context.read<AccountDetailCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.movementDeleteAdjustmentTitle),
        content: Text(l10n.movementDeleteAdjustmentMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.deleteMovement(movement.id);
  }
}
