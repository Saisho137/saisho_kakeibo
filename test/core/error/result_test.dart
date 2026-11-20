import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';

void main() {
  group('Result', () {
    test('Ok exposes its value', () {
      const Result<int> result = Ok(42);

      expect(result.isOk, isTrue);
      expect((result as Ok<int>).value, 42);
    });

    test('Err exposes its failure', () {
      const Result<int> result = Err(DatabaseFailure('boom'));

      expect(result.isOk, isFalse);
      expect((result as Err<int>).failure.message, 'boom');
    });
  });
}
