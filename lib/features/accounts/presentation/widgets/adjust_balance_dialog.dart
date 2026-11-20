import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/money/amount_parser.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/form_parts.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Asks for the real balance of [account] and returns it in minor units,
/// or `null` if cancelled (RF-15). A credit card asks for its debt, as a
/// positive number, like when it was created.
Future<int?> showAdjustBalanceDialog(
  BuildContext context, {
  required Account account,
  required Currency currency,
  required int current,
}) => showDialog<int>(
  context: context,
  builder: (_) => AdjustBalanceDialog(
    account: account,
    currency: currency,
    current: current,
  ),
);

class AdjustBalanceDialog extends StatefulWidget {
  const new({
    required this.account,
    required this.currency,
    required this.current,
    super.key,
  });

  final Account account;
  final Currency currency;

  /// Balance the app has now, pockets included.
  final int current;

  @override
  State<AdjustBalanceDialog> createState() => _AdjustBalanceDialogState();
}

class _AdjustBalanceDialogState extends State<AdjustBalanceDialog> {
  late final bool _isCard = widget.account.type == AccountType.creditCard;
  late String _text = _format(_isCard ? -widget.current : widget.current);
  bool _showError = false;

  String _format(int minor) => MoneyFormatter.format(
    Money(minor, widget.currency.code),
    widget.currency.format,
  );

  /// The typed balance, `null` when it can't be read. A leading minus is
  /// accepted, except for a card's debt.
  int? get _balance {
    final text = _text.trim();
    final negative = !_isCard && text.startsWith('-');
    final amount = AmountParser.parse(
      negative ? text.substring(1) : text,
      widget.currency.format,
    );
    if (amount == null || text.isEmpty) return null;
    final signed = negative ? -amount : amount;
    return _isCard ? -signed : signed;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final balance = _balance;
    final difference = balance == null ? null : balance - widget.current;
    final label = switch (widget.account.type) {
      AccountType.creditCard => l10n.adjustCurrentDebt,
      AccountType.investment => l10n.adjustCurrentValue,
      _ => l10n.adjustRealBalance,
    };
    return AlertDialog(
      title: Text(
        widget.account.type == AccountType.investment
            ? l10n.accountUpdateValue
            : l10n.accountAdjustBalance,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: _text,
            autofocus: true,
            keyboardType: TextInputType.numberWithOptions(
              signed: !_isCard,
              decimal: widget.currency.format.decimals > 0,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d.,\s-]')),
            ],
            onChanged: (text) => setState(() => _text = text),
            decoration: InputDecoration(
              labelText: label,
              suffixText: widget.currency.code,
              errorText: _showError && balance == null
                  ? l10n.adjustErrorAmount
                  : null,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (difference != null)
            Text(
              l10n.adjustDifference(
                '${difference > 0 ? '+' : ''}${_format(difference)}',
              ),
            ),
          FormNote(l10n.adjustHint),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        TextButton(
          onPressed: () {
            final value = _balance;
            if (value == null) return setState(() => _showError = true);
            Navigator.of(context).pop(value);
          },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
