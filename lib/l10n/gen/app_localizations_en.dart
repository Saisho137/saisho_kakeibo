// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Archetype';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get tasksTitle => 'Tasks';

  @override
  String get tasksEmpty => 'No tasks yet. Add your first one above.';

  @override
  String get tasksAddHint => 'What needs to be done?';

  @override
  String get tasksAddTooltip => 'Add task';

  @override
  String get tasksDeleteTooltip => 'Delete task';

  @override
  String get tasksTitleRequired => 'Write a title for the task.';
}
