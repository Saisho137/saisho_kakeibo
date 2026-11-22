import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/cubit/recurring_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The Recurring screen (RF-06): every template with its amount, due day
/// and a switch to pause it.
class RecurringPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RecurringCubit>()..load(),
      child: const RecurringView(),
    );
  }
}

class RecurringView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<RecurringCubit, RecurringState>(
      listenWhen: (previous, current) =>
          current.failure != null && previous.failure != current.failure,
      listener: (context, state) => ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.recurringTitle),
          actions: [
            IconButton(
              tooltip: l10n.recurringNewTooltip,
              icon: const Icon(Icons.add_rounded),
              onPressed: () => context.push(AppRoutes.newRecurring()),
            ),
          ],
        ),
        body: BlocBuilder<RecurringCubit, RecurringState>(
          builder: (context, state) => switch (state.status) {
            RecurringStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            RecurringStatus.failure => Center(child: Text(l10n.genericError)),
            RecurringStatus.success when state.templates!.isEmpty => Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(l10n.recurringEmpty, textAlign: TextAlign.center),
            ),
            RecurringStatus.success => ListView(
              children: [
                for (final template in state.templates!)
                  _TemplateTile(
                    key: ValueKey(template.id),
                    template: template,
                    state: state,
                  ),
              ],
            ),
          },
        ),
      ),
    );
  }
}

class _TemplateTile extends StatelessWidget {
  const new({required this.template, required this.state, super.key});

  final RecurringTemplate template;
  final RecurringState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final category = state.categoryOf(template);
    final account = state.accountOf(template.accountId);
    final toAccount = state.accountOf(template.toAccountId);
    final currency = state.currencyOf(template);
    final name = state.payeeOf(template)?.name ?? category?.name ?? '';
    final amount = currency == null
        ? ''
        : MoneyFormatter.format(
            Money(template.amount, currency.code),
            currency.format,
          );
    final dueDay = template.dueDay;
    final details = [
      amount,
      if (template.type == MovementType.transfer)
        '${account?.name} → ${toAccount?.name}',
      if (dueDay != null && template.remind)
        '🔔 ${l10n.recurringDueDayValue(dueDay)}'
      else if (dueDay != null)
        l10n.recurringDueDayValue(dueDay),
      if (!template.isActive) l10n.recurringPaused,
    ];
    final tile = ListTile(
      onTap: () => context.push(AppRoutes.editRecurring(template.id)),
      leading: CatalogIconAvatar(
        iconKey: category?.iconKey ?? '',
        color: Color(category?.color ?? context.tokens.neutral.toARGB32()),
      ),
      title: Text(
        template.type == MovementType.transfer
            ? name
            : '$name · ${account?.name ?? ''}',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(details.join(' · '), overflow: TextOverflow.ellipsis),
      trailing: Tooltip(
        message: l10n.recurringActiveTooltip,
        child: Switch(
          value: template.isActive,
          onChanged: (value) => context.read<RecurringCubit>().setActive(
            template.id,
            value: value,
          ),
        ),
      ),
    );
    return template.isActive ? tile : Opacity(opacity: 0.6, child: tile);
  }
}
