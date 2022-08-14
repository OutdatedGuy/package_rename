part of package_rename;

void _setAndroidConfigurations(dynamic androidConfig) {
  try {
    if (androidConfig == null) return;
    if (androidConfig is! Map) throw _PackageRenameErrors.invalidAndroidConfig;

    final androidConfigMap = Map<String, dynamic>.from(androidConfig);

    _setAndroidAppName(androidConfigMap[_appNameKey]);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Skipping Android configuration!!!');
  }
}

void _setAndroidAppName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    final androidMainManifestFile = File(_androidMainManifestFilePath);
    if (!androidMainManifestFile.existsSync()) {
      throw _PackageRenameErrors.androidMainManifestNotFound;
    }

    RegExp regExp = RegExp(r'android:label="(.*?)"');
    final appNameString = 'android:label="$appName"';

    final androidMainManifestString =
        androidMainManifestFile.readAsStringSync();
    final androidMainManifestStringWithNewAppName =
        androidMainManifestString.replaceAll(regExp, appNameString);

    androidMainManifestFile.writeAsStringSync(
      androidMainManifestStringWithNewAppName,
    );

    _logger.i('Android app name set to: $appName');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Android App Name change failed!!!');
  } catch (e) {
    _logger.e(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Android App Name change failed!!!');
  }
}
