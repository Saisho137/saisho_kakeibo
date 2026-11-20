import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/accounts_cubit.dart';

/// Settings → Balance: the "Include in Balance" switch of every active
/// account. Pockets follow their parent, so they are not listed.
class BalanceAccountsSection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final all = context.select<AccountsCubit, List<Account>?>(
      (cubit) => cubit.state.accounts,
    );
    final accounts = [
      for (final account in all ?? const <Account>[])
        if (!account.isPocket && !account.isArchived) account,
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final account in accounts)
          SwitchListTile(
            key: ValueKey(account.id),
            secondary: CatalogIconAvatar(
              iconKey: account.iconKey,
              color: Color(account.color),
            ),
            title: Text(account.name),
            subtitle: Text(account.currencyCode),
            value: account.includeInBalance,
            onChanged: (value) => context
                .read<AccountsCubit>()
                .setIncludeInBalance(account, value: value),
          ),
      ],
    );
  }
}
