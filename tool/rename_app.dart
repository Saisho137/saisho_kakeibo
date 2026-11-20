// Renames the archetype into a new app.
//
// Usage:
//   dart run tool/rename_app.dart \
//     --package my_app --org com.mycompany --name "My App"
//
// It updates the Dart package name (pubspec and imports), the Android
// applicationId/namespace, the Kotlin package folder and the display name.
import 'dart:io';

void main(List<String> args) {
  final options = _parseArgs(args);
  final newPackage = options['package'];
  final newOrg = options['org'];
  final newName = options['name'];

  if (newPackage == null || newOrg == null || newName == null) {
    stderr.writeln(
      'Usage: dart run tool/rename_app.dart '
      '--package my_app --org com.mycompany --name "My App"',
    );
    exit(64);
  }
  if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(newPackage)) {
    stderr.writeln('--package must be snake_case (e.g. my_app).');
    exit(64);
  }
  if (!RegExp(r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$').hasMatch(newOrg)) {
    stderr.writeln('--org must be a reverse domain (e.g. com.mycompany).');
    exit(64);
  }

  final gradle = File('android/app/build.gradle.kts');
  final manifest = File('android/app/src/main/AndroidManifest.xml');
  final arb = File('lib/l10n/arb/app_en.arb');

  final oldPackage = _match(
    File('pubspec.yaml'),
    RegExp(r'^name: (\w+)', multiLine: true),
  );
  final oldAppId = _match(gradle, RegExp(r'applicationId = "([\w.]+)"'));
  final oldName = _match(manifest, RegExp('android:label="([^"]+)"'));
  final newAppId = '$newOrg.$newPackage';

  // Dart package name: pubspec, imports and string literals in Dart sources.
  _replaceIn(File('pubspec.yaml'), 'name: $oldPackage', 'name: $newPackage');
  for (final file in _dartFiles(['lib', 'test', 'tool'])) {
    _replaceIn(file, 'package:$oldPackage/', 'package:$newPackage/');
    _replaceIn(file, "'$oldPackage'", "'$newPackage'");
  }

  // Android applicationId, namespace and Kotlin package.
  _replaceIn(gradle, oldAppId, newAppId);
  final kotlinRoot = Directory('android/app/src/main/kotlin');
  final oldDir = Directory(
    '${kotlinRoot.path}/${oldAppId.replaceAll('.', '/')}',
  );
  final newDir = Directory(
    '${kotlinRoot.path}/${newAppId.replaceAll('.', '/')}',
  );
  if (oldDir.path != newDir.path && oldDir.existsSync()) {
    newDir.createSync(recursive: true);
    for (final entity in oldDir.listSync()) {
      final target = '${newDir.path}/${entity.uri.pathSegments.last}';
      entity.renameSync(target);
    }
    _deleteEmptyParents(oldDir, kotlinRoot);
  }
  for (final file in newDir.listSync().whereType<File>()) {
    _replaceIn(file, 'package $oldAppId', 'package $newAppId');
  }

  // Display name.
  _replaceIn(manifest, 'android:label="$oldName"', 'android:label="$newName"');
  _replaceIn(arb, '"appTitle": "$oldName"', '"appTitle": "$newName"');

  stdout
    ..writeln('Renamed $oldPackage ($oldAppId) -> $newPackage ($newAppId).')
    ..writeln('Next: flutter pub get && make gen && make l10n');
}

Map<String, String> _parseArgs(List<String> args) {
  final result = <String, String>{};
  for (var i = 0; i < args.length - 1; i++) {
    if (args[i].startsWith('--')) result[args[i].substring(2)] = args[i + 1];
  }
  return result;
}

String _match(File file, RegExp pattern) {
  final match = pattern.firstMatch(file.readAsStringSync());
  if (match == null) {
    stderr.writeln('Could not find ${pattern.pattern} in ${file.path}.');
    exit(1);
  }
  return match.group(1)!;
}

Iterable<File> _dartFiles(List<String> roots) sync* {
  for (final root in roots) {
    final dir = Directory(root);
    if (!dir.existsSync()) continue;
    yield* dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));
  }
}

void _replaceIn(File file, String from, String to) {
  if (!file.existsSync()) return;
  final content = file.readAsStringSync();
  if (content.contains(from)) {
    file.writeAsStringSync(content.replaceAll(from, to));
  }
}

void _deleteEmptyParents(Directory dir, Directory stopAt) {
  var current = dir;
  while (current.path != stopAt.path &&
      current.existsSync() &&
      current.listSync().isEmpty) {
    current.deleteSync();
    current = current.parent;
  }
}
