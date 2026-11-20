import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// "23 Oct – 22 Nov", "Since 23 Oct" or "2026" for a calendar year. Dates
/// outside the current year show it.
String periodLabel(BuildContext context, Period period) {
  final start = period.start;
  final end = period.end;
  if (end != null &&
      start == LocalDate(start.year, 1, 1) &&
      end == LocalDate(start.year, 12, 31)) {
    return '${start.year}';
  }
  final locale = Localizations.localeOf(context).toLanguageTag();
  final thisYear = LocalDate.today().year;
  final withYear =
      start.year != thisYear || (end?.year ?? thisYear) != thisYear;
  final format = withYear ? DateFormat.yMMMd(locale) : DateFormat.MMMd(locale);
  String text(LocalDate date) => format.format(date.toDateTime());
  final l10n = context.l10n;
  return end == null
      ? l10n.periodSince(text(start))
      : l10n.periodRange(text(start), text(end));
}
