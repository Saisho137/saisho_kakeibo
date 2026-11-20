import 'package:flutter_archetype/core/config/env.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Env', () {
    test('defaults to dev when no dart-define is given', () {
      expect(Env.appEnv, 'dev');
      expect(Env.isProduction, isFalse);
    });
  });
}
