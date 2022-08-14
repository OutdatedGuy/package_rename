part of package_rename;

void _setAndroidConfigurations(dynamic androidConfig) {
  try {
    if (androidConfig == null) return;
    if (androidConfig is! Map) throw _PackageRenameErrors.invalidAndroidConfig;

    final androidConfigMap = Map<String, dynamic>.from(androidConfig);

    _setAndroidAppName(androidConfigMap[_appNameKey]);
    _setAndroidPackageName(androidConfigMap[_packageNameKey]);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Skipping Android configuration!!!');
  } finally {
    _logger.i(_majorStepDoneLineBreak);
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

    _logger.i('Android app name set to: `$appName`');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Android App Name change failed!!!');
  } catch (e) {
    _logger.e(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Android App Name change failed!!!');
  } finally {
    _logger.i(_minorStepDoneLineBreak);
  }
}

void _setAndroidPackageName(dynamic packageName) {
  try {
    if (packageName == null) return;
    if (packageName is! String) throw _PackageRenameErrors.invalidPackageName;

    List<String> androidManifestFilePaths = [
      _androidMainManifestFilePath,
      _androidDebugManifestFilePath,
      _androidProfileManifestFilePath,
    ];

    _setManifestPackageName(
      manifestFilePaths: androidManifestFilePaths,
      packageName: packageName,
    );
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Android Package Name change failed!!!');
  } catch (e) {
    _logger.e(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Android Package Name change failed!!!');
  }
}

void _setManifestPackageName({
  required List<String> manifestFilePaths,
  required String packageName,
}) {
  for (String androidManifestFilePath in manifestFilePaths) {
    final androidManifestFile = File(androidManifestFilePath);
    if (!androidManifestFile.existsSync()) {
      _logger.w(
        'AndroidManifest.xml file not found at: $androidManifestFilePath',
      );
      continue;
    }

    RegExp regExp = RegExp(r'package="(.*?)"');
    final packageNameString = 'package="$packageName"';

    final androidManifestString = androidManifestFile.readAsStringSync();
    final androidManifestStringWithNewPackageName =
        androidManifestString.replaceAll(regExp, packageNameString);

    androidManifestFile.writeAsStringSync(
      androidManifestStringWithNewPackageName,
    );

    _logger.i(
      'Android package name set to: `$packageName` at: `$androidManifestFilePath`',
    );
  }
}
