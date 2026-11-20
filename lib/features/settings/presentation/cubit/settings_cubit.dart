import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/update_settings.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

/// App-wide settings. Provided above `MaterialApp`, so the theme and every
/// feature read the same values.
class SettingsCubit extends Cubit<SettingsState> {
  new({required this._watchSettings, required this._updateSettings})
    : super(const SettingsState());

  final WatchSettings _watchSettings;
  final UpdateSettings _updateSettings;
  StreamSubscription<AppSettings>? _subscription;

  /// Starts listening to the stored settings.
  void load() {
    unawaited(_subscription?.cancel());
    _subscription = _watchSettings(const NoParams()).listen(
      (settings) => emit(
        state.copyWith(status: SettingsStatus.ready, settings: settings),
      ),
      onError: (Object error) => emit(
        state.copyWith(
          status: SettingsStatus.failure,
          failure: UnexpectedFailure(error.toString()),
        ),
      ),
    );
  }

  /// Saves the result of applying [change] to the current settings, such as
  /// `update((s) => s.copyWith(cutoffDay: 5))`.
  Future<void> update(AppSettings Function(AppSettings) change) async {
    if (await _updateSettings(change(state.settings)) case Err(
      :final failure,
    )) {
      emit(state.copyWith(failure: failure));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
