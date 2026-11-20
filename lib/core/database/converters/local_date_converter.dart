import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';

/// Stores a [LocalDate] as ISO-8601 text (`YYYY-MM-DD`), consistent with the
/// `store_date_time_values_as_text` option used for timestamps.
class LocalDateConverter extends TypeConverter<LocalDate, String> {
  const new();

  @override
  LocalDate fromSql(String fromDb) => LocalDate.parse(fromDb);

  @override
  String toSql(LocalDate value) => value.toString();
}
