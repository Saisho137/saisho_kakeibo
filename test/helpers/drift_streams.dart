import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

extension DriftStreams on WidgetTester {
  /// Unmounts the tree so drift cancels its query streams, then lets the
  /// zero-duration timer drift schedules on cancel run. Call it at the end of
  /// widget tests that use a real database.
  Future<void> disposeDriftStreams() async {
    await pumpWidget(const SizedBox.shrink());
    await pump(Duration.zero);
  }
}
