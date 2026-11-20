import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/services/accounts_overview.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// An account of the Accounts list with its pockets and the "Free" line,
/// or its credit limit bar.
class AccountLineCard extends StatelessWidget {
  const new({
    required this.line,
    required this.format,
    required this.onTap,
    super.key,
  });

  final AccountLine line;
  final CurrencyFormat format;
  final ValueChanged<Account> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final account = line.account;
    final free = line.free;
    final available = line.available;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: CatalogIconAvatar(
            iconKey: account.iconKey,
            color: Color(account.color),
          ),
          title: Row(
            children: [
              Flexible(
                child: Text(account.name, overflow: TextOverflow.ellipsis),
              ),
              if (account.isMain)
                _Marker(Icons.star_rounded, l10n.accountMainMarker),
              if (account.includeInBalance)
                _Marker(
                  Icons.radio_button_checked_rounded,
                  l10n.accountInBalanceMarker,
                ),
            ],
          ),
          subtitle: account.isArchived ? Text(l10n.accountArchived) : null,
          trailing: _Amount(line.balance, format),
          onTap: () => onTap(account),
        ),
        for (final pocket in line.pockets)
          _SubLine(
            leading: CatalogIconAvatar(
              iconKey: pocket.account.iconKey,
              color: Color(pocket.account.color),
              radius: 14,
            ),
            title: pocket.account.name,
            subtitle: pocket.account.isArchived ? l10n.accountArchived : null,
            amount: _Amount(pocket.balance, format, warnIfNegative: true),
            onTap: () => onTap(pocket.account),
          ),
        if (free != null)
          _SubLine(
            leading: const SizedBox.square(dimension: 28),
            title: l10n.accountFree,
            amount: _Amount(free, format, warnIfNegative: true),
          ),
        if (available != null)
          _CreditLimitBar(
            available: available,
            limit: account.creditLimit ?? 0,
            paymentDay: account.paymentDay,
            format: format,
          ),
      ],
    );
  }
}

class _Marker extends StatelessWidget {
  const new(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.xs),
      child: Icon(
        icon,
        size: 16,
        color: context.colors.primary,
        semanticLabel: label,
      ),
    );
  }
}

class _SubLine extends StatelessWidget {
  const new({
    required this.leading,
    required this.title,
    required this.amount,
    this.subtitle,
    this.onTap,
  });

  final Widget leading;
  final String title;
  final String? subtitle;
  final Widget amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(
        left: AppSpacing.xl + AppSpacing.md,
        right: AppSpacing.md,
      ),
      leading: leading,
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: amount,
      onTap: onTap,
    );
  }
}

class _Amount extends StatelessWidget {
  const new(this.money, this.format, {this.warnIfNegative = false});

  final Money money;
  final CurrencyFormat format;

  /// Pockets in negative are shown in red as a warning (RF-15).
  final bool warnIfNegative;

  @override
  Widget build(BuildContext context) {
    return Text(
      MoneyFormatter.format(money, format),
      style: context.textTheme.bodyLarge?.copyWith(
        color: warnIfNegative && money.isNegative
            ? context.tokens.expense
            : null,
      ),
    );
  }
}

class _CreditLimitBar extends StatelessWidget {
  const new({
    required this.available,
    required this.limit,
    required this.paymentDay,
    required this.format,
  });

  final Money available;
  final int limit;
  final int? paymentDay;
  final CurrencyFormat format;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final used = limit <= 0 ? 0.0 : 1 - available.minor / limit;
    final left = MoneyFormatter.format(available, format);
    final day = paymentDay;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl + AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: used.clamp(0, 1),
              borderRadius: BorderRadius.circular(context.tokens.radiusSmall),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            day == null
                ? l10n.accountCreditLeft(left)
                : l10n.accountCreditLeftWithDay(left, day),
            style: context.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
