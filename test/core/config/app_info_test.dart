import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:saisho_kakeibo/core/config/app_info.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('loads the version from the platform', () async {
    PackageInfo.setMockInitialValues(
      appName: 'Saisho Kakeibo',
      packageName: 'com.saisho.kakeibo',
      version: '1.0.0',
      buildNumber: '7',
      buildSignature: '',
    );

    final info = await AppInfo.load();

    expect(info.version, '1.0.0');
    expect(info.buildNumber, '7');
  });
}
