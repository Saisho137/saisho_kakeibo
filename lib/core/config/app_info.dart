import 'package:package_info_plus/package_info_plus.dart';

/// Version of the installed app, shown in Settings → About.
final class AppInfo {
  const new({required this.version, required this.buildNumber});

  static Future<AppInfo> load() async {
    final info = await PackageInfo.fromPlatform();
    return AppInfo(version: info.version, buildNumber: info.buildNumber);
  }

  final String version;
  final String buildNumber;
}
