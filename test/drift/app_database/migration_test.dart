import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';

import 'generated/schema.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  // Fails when the tables in code drift from the last exported schema:
  // run `make db-schema` after every schema change.
  test('current schema matches the exported schema', () async {
    final connection = await verifier.startAt(GeneratedHelper.versions.last);
    final db = AppDatabase(connection);
    addTearDown(db.close);

    await verifier.migrateAndValidate(db, db.schemaVersion);
  });

  // When schemaVersion goes above 1, add one test per upgrade step here
  // (or let `make db-schema` generate them): it must migrate the previous
  // version and keep its data.
}
