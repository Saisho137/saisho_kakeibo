import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  tearDown(() => db.close());

  group('AppDatabase', () {
    test('opens with foreign keys enabled', () async {
      final result = await db.customSelect('PRAGMA foreign_keys').getSingle();

      expect(result.read<int>('foreign_keys'), 1);
    });

    test('starts at schema version 1', () {
      expect(db.schemaVersion, 1);
    });
  });
}
