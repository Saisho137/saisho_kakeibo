import 'dart:developer';

import 'package:bloc/bloc.dart';

/// Logs state changes and errors of every Bloc/Cubit in debug sessions.
class AppBlocObserver extends BlocObserver {
  const new();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error)', stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
