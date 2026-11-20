import 'package:meta/meta.dart';

/// What the quick entry form starts with, derived from use (RF-08).
@immutable
final class MovementDraft {
  const new({
    required this.categoryId,
    required this.accountId,
    this.payeeName,
    this.amount,
  });

  final int? categoryId;

  /// `null` only when there is no active account at all.
  final int? accountId;
  final String? payeeName;

  /// Last amount paid to the chosen payee, in minor units.
  final int? amount;
}
