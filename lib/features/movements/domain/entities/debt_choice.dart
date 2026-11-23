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

/// A debt the movement creates: a loan received or a new loan given.
final class NewDebt extends DebtChoice {
  const new({this.name = '', this.pillarId, this.initialPending});

  /// Empty takes the payee's name.
  final String name;

  /// Only a debt I owe has one.
  final int? pillarId;

  /// What I owe for a loan received; the amount received when `null`. A
  /// loan given starts at 0 and the loan adds its amount.
  final int? initialPending;

  @override
  bool operator ==(Object other) =>
      other is NewDebt &&
      other.name == name &&
      other.pillarId == pillarId &&
      other.initialPending == initialPending;

  @override
  int get hashCode => Object.hash(name, pillarId, initialPending);
}
