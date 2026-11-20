// Fails when line coverage in coverage/lcov.info is below a threshold.
//
// Usage: dart run tool/check_coverage.dart [minPercent]
// Generated files are ignored, so only hand-written code counts.
import 'dart:io';

const _defaultMinimum = 80.0;
const _ignoredSuffixes = ['.g.dart', '.freezed.dart'];
const _ignoredPrefixes = ['lib/l10n/gen/'];

void main(List<String> args) {
  final minimum = args.isEmpty ? _defaultMinimum : double.parse(args.first);
  final lcov = File('coverage/lcov.info');
  if (!lcov.existsSync()) {
    stderr.writeln('coverage/lcov.info not found. Run `make coverage` first.');
    exit(1);
  }

  var found = 0;
  var hit = 0;
  var include = false;
  for (final line in lcov.readAsLinesSync()) {
    if (line.startsWith('SF:')) {
      final path = line.substring(3);
      include =
          !_ignoredSuffixes.any(path.endsWith) &&
          !_ignoredPrefixes.any(path.startsWith);
    } else if (include && line.startsWith('LF:')) {
      found += int.parse(line.substring(3));
    } else if (include && line.startsWith('LH:')) {
      hit += int.parse(line.substring(3));
    }
  }

  final percent = found == 0 ? 100.0 : hit * 100 / found;
  final summary =
      'Line coverage: ${percent.toStringAsFixed(1)}% '
      '(minimum ${minimum.toStringAsFixed(0)}%)';
  if (percent < minimum) {
    stderr.writeln(summary);
    exit(1);
  }
  stdout.writeln(summary);
}
