import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';

/// Runs a database [action] and translates its exceptions into a
/// [DatabaseFailure], so repositories never leak drift or SQLite errors.
Future<Result<T>> guardDatabase<T>(Future<T> Function() action) async {
  try {
    return Ok(await action());
  } on Exception catch (e) {
    return Err(DatabaseFailure(e.toString()));
  }
}
