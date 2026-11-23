import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/features/payees/domain/services/payee_stats.dart';

/// What an entity adds up to (RF-08): what it was paid, or, when it paid me
/// more, a green `+` amount.
class PayeeNetText extends StatelessWidget {
  const new({
    required this.stats,
    required this.currency,
    this.style,
    super.key,
  });

  final PayeeStats stats;
  final Currency currency;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final net = stats.net;
    final text = MoneyFormatter.format(
      Money(net.abs(), currency.code),
      currency.format,
    );
    final base = style ?? context.textTheme.titleSmall;
    return Text(
      net > 0 ? '+$text' : text,
      style: net > 0 ? base?.copyWith(color: context.tokens.income) : base,
    );
  }
}
