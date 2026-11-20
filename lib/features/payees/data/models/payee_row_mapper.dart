import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

extension PayeeRowMapper on PayeeRow {
  Payee toEntity() => Payee(id: id, name: name, key: key);
}
