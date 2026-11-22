import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// "Today", "Yesterday", "Fri, Nov 20" or, outside the current year,
/// "Sun, Jan 5, 2025": the header of a day in a movement list.
String dayLabel(BuildContext context, LocalDate day) {
  final today = LocalDate.today();
  if (day == today) return context.l10n.dayToday;
  if (day == today.addDays(-1)) return context.l10n.dayYesterday;
  final locale = Localizations.localeOf(context).toLanguageTag();
  final format = day.year == today.year
      ? DateFormat.MMMEd(locale)
      : DateFormat.yMMMEd(locale);
  return format.format(day.toDateTime());
}
