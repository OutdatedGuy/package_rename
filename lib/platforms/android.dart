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
    _logger.e('Skipping Android configuration!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Skipping Android configuration!!!');
  } finally {
    if (androidConfig != null) _logger.w(_majorStepDoneLineBreak);
  }
}

void _setAndroidAppName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    final androidManifestFile = File(_androidMainManifestFilePath);
    if (!androidManifestFile.existsSync()) {
      throw _PackageRenameErrors.androidMainManifestNotFound;
    }

    final regExp = RegExp(r'android:label="(.*?)"');
    final appNameString = 'android:label="$appName"';

    final androidManifestString = androidManifestFile.readAsStringSync();
    final newLabelAndroidManifestString = androidManifestString.replaceAll(
      regExp,
      appNameString,
    );

    androidManifestFile.writeAsStringSync(newLabelAndroidManifestString);

    _logger.i('Android label set to: `$appName` (main AndroidManifest.xml)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Android Label change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Android Label change failed!!!');
  } finally {
    if (appName != null) _logger.wtf(_minorStepDoneLineBreak);
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

    _setBuildGradlePackageName(
      buildGradleFilePath: _androidAppLevelBuildGradleFilePath,
      packageName: packageName,
    );
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Android Package change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Android Package change failed!!!');
  } finally {
    if (packageName != null) _logger.wtf(_minorStepDoneLineBreak);
  }
}

void _setManifestPackageName({
  required List<String> manifestFilePaths,
  required String packageName,
}) {
  final regExp = RegExp(r'package="(.*?)"');
  final packageNameString = 'package="$packageName"';

  for (String androidManifestFilePath in manifestFilePaths) {
    final androidManifestFile = File(androidManifestFilePath);
    if (!androidManifestFile.existsSync()) {
      _logger.w(
        'AndroidManifest.xml file not found at: $androidManifestFilePath',
      );
      continue;
    }

    final androidManifestString = androidManifestFile.readAsStringSync();
    final newPackageAndroidManifestString = androidManifestString.replaceAll(
      regExp,
      packageNameString,
    );

    androidManifestFile.writeAsStringSync(newPackageAndroidManifestString);

    // Get folder name from path
    final folderName = androidManifestFilePath.split('/').reversed.toList()[1];

    _logger.i(
      'Android package set to: `$packageName` ($folderName AndroidManifest.xml)',
    );
  }
}

void _setBuildGradlePackageName({
  required String buildGradleFilePath,
  required String packageName,
}) {
  final buildGradleFile = File(buildGradleFilePath);
  if (!buildGradleFile.existsSync()) {
    _logger.w(
      'build.gradle file not found at: $buildGradleFilePath',
    );
    return;
  }

  final buildGradleString = buildGradleFile.readAsStringSync();
  final newAppIDBuildGradleString = buildGradleString.replaceAll(
    RegExp(r'applicationId "(.*?)"'),
    'applicationId "$packageName"',
  );

  buildGradleFile.writeAsStringSync(newAppIDBuildGradleString);

  _logger.i(
    'Android applicationId set to: `$packageName` (build.gradle)',
  );
}
