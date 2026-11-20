import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/converters/local_date_converter.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';

void main() {
  const converter = LocalDateConverter();

  test('round-trips a LocalDate through ISO-8601 text', () {
    final date = LocalDate(2026, 11, 19);

    expect(converter.toSql(date), '2026-11-19');
    expect(converter.fromSql('2026-11-19'), date);
  });
}
