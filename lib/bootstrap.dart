import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_archetype/app/di/injector.dart';
import 'package:flutter_archetype/app/observers/app_bloc_observer.dart';
import 'package:flutter_archetype/core/config/env.dart';

/// Initializes cross-cutting concerns (error handling, bloc observer,
/// dependency injection) before running the app.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };

  Bloc.observer = const AppBlocObserver();

  await configureDependencies();

  log('Starting app (env: ${Env.appEnv})');
  runApp(await builder());
}
