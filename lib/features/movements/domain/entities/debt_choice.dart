import 'package:meta/meta.dart';

/// The debt a movement of a debt category works with (RF-09).
@immutable
sealed class DebtChoice {
  const new();
}

/// A debt that already exists: the one paid, collected or added to.
final class ExistingDebt extends DebtChoice {
  const new(this.id);

  final int id;

  @override
  bool operator ==(Object other) => other is ExistingDebt && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// A debt the movement creates: a loan received or a new loan given. It is
/// named after the movement's payee, which is the debt itself.
final class NewDebt extends DebtChoice {
  const new({this.pillarId, this.initialPending});

  /// Only a debt I owe has one.
  final int? pillarId;

  /// What I owe for a loan received; the amount received when `null`. A
  /// loan given starts at 0 and the loan adds its amount.
  final int? initialPending;

  @override
  bool operator ==(Object other) =>
      other is NewDebt &&
      other.pillarId == pillarId &&
      other.initialPending == initialPending;

  @override
  int get hashCode => Object.hash(pillarId, initialPending);
}
