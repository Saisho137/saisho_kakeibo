import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// A movement as seen from [accountId]: what it is and how much it moved
/// that account's balance. Pending movements are dimmed (RF-06).
class MovementTile extends StatelessWidget {
  const new({
    required this.movement,
    required this.accountId,
    required this.currency,
    this.category,
    this.payee,
    this.otherAccount,
    this.onTap,
    super.key,
  });

  final Movement movement;
  final int accountId;
  final Currency currency;
  final Category? category;
  final Payee? payee;

  /// The other side of a transfer.
  final Account? otherAccount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tokens = context.tokens;
    final isAdjustment = movement.type == MovementType.adjustment;
    final effect = movement.type == MovementType.income && movement.isPending
        ? movement.amount
        : movement.effectOn(accountId);
    final color = switch (movement.type) {
      MovementType.income => tokens.income,
      MovementType.expense => tokens.expense,
      MovementType.transfer => tokens.transfer,
      MovementType.adjustment => context.colors.onSurfaceVariant,
    };
    final sign = effect > 0 ? '+' : '';
    final other = otherAccount?.name;
    final outgoing = movement.accountId == accountId;
    final details = [
      if (movement.type == MovementType.transfer && other != null)
        if (outgoing)
          l10n.movementTransferTo(other)
        else
          l10n.movementTransferFrom(other),
      ?payee?.name,
      ?movement.note,
      if (movement.isPending) l10n.movementPending,
    ];
    final amount = MoneyFormatter.format(
      Money(effect, currency.code),
      currency.format,
    );
    final tile = ListTile(
      onTap: onTap,
      leading: isAdjustment
          ? SizedBox.square(
              dimension: 40,
              child: Icon(
                Icons.tune_outlined,
                color: tokens.transfer,
                size: 30,
              ),
            )
          : CatalogIconAvatar(
              iconKey: category?.iconKey ?? '',
              color: Color(category?.color ?? tokens.neutral.toARGB32()),
            ),
      title: Text(
        isAdjustment ? l10n.movementAdjustment : category?.name ?? '',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: details.isEmpty
          ? null
          : Text(details.join(' · '), overflow: TextOverflow.ellipsis),
      trailing: Text(
        '$sign$amount',
        style: context.textTheme.titleSmall?.copyWith(color: color),
      ),
    );
    return movement.isPending ? Opacity(opacity: 0.6, child: tile) : tile;
  }
}
