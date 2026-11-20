// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Flutter Archetype';

  @override
  String get genericError => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get tasksTitle => 'Tareas';

  @override
  String get tasksEmpty => 'Aún no hay tareas. Agrega la primera arriba.';

  @override
  String get tasksAddHint => '¿Qué hay que hacer?';

  @override
  String get tasksAddTooltip => 'Agregar tarea';

  @override
  String get tasksDeleteTooltip => 'Eliminar tarea';

  @override
  String get tasksTitleRequired => 'Escribe un título para la tarea.';
}
