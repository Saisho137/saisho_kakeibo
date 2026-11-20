/// Compile-time configuration injected with `--dart-define-from-file`.
///
/// Values come from `env/<environment>.json` (see the Makefile `run` and
/// `build` targets). Never put secrets in these files: anything compiled into
/// the app can be extracted from the binary.
abstract final class Env {
  static const String appEnv = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  static bool get isProduction => appEnv == 'prod';
}
