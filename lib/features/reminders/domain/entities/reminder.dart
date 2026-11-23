import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';

part 'reminder.freezed.dart';

enum ReminderKind {
  /// The due day of a recurring template (RF-06).
  recurring,

  /// The payment day of a credit card (RF-03).
  cardPayment,

  /// The due day of a debt I owe, or the due date of one owed to me
  /// (RF-09).
  debtPayment,
  debtCollection,
}

/// A local notification on [date] at the global reminder time (RT-11).
@freezed
abstract class Reminder with _$Reminder {
  const factory({
    /// Stable per source and month, so rescheduling replaces it.
    required int id,
    required ReminderKind kind,

    /// Payee or category of a template; name of a card or a debt.
    required String name,
    required LocalDate date,

    /// Formatted amount of a template or a debt's installment, or what is
    /// left on a debt owed to me, with its currency code.
    String? amount,
  }) = _Reminder;
}
