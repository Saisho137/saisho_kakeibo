import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/features/settings/presentation/widgets/currency_preview.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// A currency in the Settings list: code, symbol and a formatted sample.
class CurrencyTile extends StatelessWidget {
  const new({required this.currency, required this.onTap, super.key});

  final Currency currency;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(currency.code),
      subtitle: Text('${currency.symbol} ${currencyPreview(currency.format)}'),
      trailing: currency.isBuiltIn
          ? Chip(label: Text(context.l10n.currencyBuiltIn))
          : null,
      onTap: onTap,
    );
  }
}
