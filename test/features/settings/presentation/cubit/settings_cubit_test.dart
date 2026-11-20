import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/update_settings.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';

class _MockWatchSettings extends Mock implements WatchSettings;

class _MockUpdateSettings extends Mock implements UpdateSettings;

void main() {
  late _MockWatchSettings watchSettings;
  late _MockUpdateSettings updateSettings;

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(const AppSettings());
  });

  setUp(() {
    watchSettings = _MockWatchSettings();
    updateSettings = _MockUpdateSettings();
  });

  SettingsCubit buildCubit() => SettingsCubit(
    watchSettings: watchSettings,
    updateSettings: updateSettings,
  );

  const stored = AppSettings(themeMode: AppThemeMode.dark, cutoffDay: 23);

  group('SettingsCubit', () {
    test('starts loading with default settings', () {
      expect(buildCubit().state, const SettingsState());
    });

    blocTest<SettingsCubit, SettingsState>(
      'emits the stored settings',
      setUp: () =>
          when(() => watchSettings(any()))
              .thenAnswer((_) => Stream.value(stored)),
      build: buildCubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        const SettingsState(status: SettingsStatus.ready, settings: stored),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'emits failure when the stream errors',
      setUp: () =>
          when(() => watchSettings(any()))
              .thenAnswer((_) => Stream.error(Exception('boom'))),
      build: buildCubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<SettingsState>()
            .having((s) => s.status, 'status', SettingsStatus.failure)
            .having((s) => s.failure, 'failure', isA<UnexpectedFailure>()),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'saves the changed settings',
      setUp: () =>
          when(() => updateSettings(any()))
              .thenAnswer((_) async => const Ok(null)),
      build: buildCubit,
      seed: () =>
          const SettingsState(status: SettingsStatus.ready, settings: stored),
      act: (cubit) => cubit.update((s) => s.copyWith(cutoffDay: 5)),
      expect: () => <SettingsState>[],
      verify: (_) =>
          verify(() => updateSettings(stored.copyWith(cutoffDay: 5))).called(1),
    );

    blocTest<SettingsCubit, SettingsState>(
      'exposes the failure of a rejected change',
      setUp: () =>
          when(() => updateSettings(any()))
              .thenAnswer((_) async => const Err(ValidationFailure('range'))),
      build: buildCubit,
      act: (cubit) => cubit.update((s) => s.copyWith(cutoffDay: 40)),
      expect: () => [
        isA<SettingsState>().having(
          (s) => s.failure,
          'failure',
          isA<ValidationFailure>(),
        ),
      ],
    );
  });
}
