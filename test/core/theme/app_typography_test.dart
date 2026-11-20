import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/theme/app_theme.dart';
import 'package:saisho_kakeibo/core/theme/app_typography.dart';

double _width(TextStyle style) {
  final painter = TextPainter(
    text: TextSpan(text: 'Balance 4.250.000', style: style),
    textDirection: TextDirection.ltr,
  )..layout();
  return painter.width;
}

void main() {
  setUpAll(() async {
    final bytes = File('assets/fonts/roboto_flex/RobotoFlex.ttf')
        .readAsBytesSync();
    final loader = FontLoader(AppTypography.fontFamily)
      ..addFont(Future.value(ByteData.sublistView(bytes)));
    await loader.load();
  });

  group('AppTypography', () {
    test('themes use Roboto Flex', () {
      for (final theme in [AppTheme.light, AppTheme.dark]) {
        expect(theme.textTheme.bodyMedium?.fontFamily, 'RobotoFlex');
        expect(theme.primaryTextTheme.titleLarge?.fontFamily, 'RobotoFlex');
      }
    });

    // Guards the variable font: a fixed `wght` axis in the theme would make
    // `copyWith(fontWeight: ...)` render at the theme's weight.
    test('copyWith(fontWeight) changes the rendered weight', () {
      final body = AppTheme.light.textTheme.bodyMedium!;

      expect(body.fontVariations, isNull);
      expect(
        _width(body.copyWith(fontWeight: FontWeight.w700)),
        greaterThan(_width(body)),
      );
    });
  });
}
