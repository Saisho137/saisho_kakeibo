part of 'settings_cubit.dart';

enum SettingsStatus { loading, ready, failure }

@freezed
abstract class SettingsState with _$SettingsState {
  const factory({
    @Default(SettingsStatus.loading) SettingsStatus status,

    /// Defaults until the stored settings arrive.
    @Default(AppSettings()) AppSettings settings,

    /// Last failure of a user action, shown once by the UI.
    Failure? failure,
  }) = _SettingsState;
}
