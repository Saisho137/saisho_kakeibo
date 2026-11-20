import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/config/env.dart';

void main() {
  group('Env', () {
    test('defaults to dev when no dart-define is given', () {
      expect(Env.appEnv, 'dev');
      expect(Env.isProduction, isFalse);
    });
  });
}
