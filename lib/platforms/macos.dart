part of package_rename;

void _setMacOSConfigurations(dynamic macOSConfig) {
  try {
    if (macOSConfig == null) return;
    if (macOSConfig is! Map) throw _PackageRenameErrors.invalidMacOSConfig;

    final macOSConfigMap = Map<String, dynamic>.from(macOSConfig);

    _setMacOSAppName(macOSConfigMap[_appNameKey]);
    _setMacOSPackageName(macOSConfigMap[_packageNameKey]);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Skipping MacOS configuration!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Skipping MacOS configuration!!!');
  } finally {
    if (macOSConfig != null) _logger.w(_majorStepDoneLineBreak);
  }
}

void _setMacOSAppName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    final appInfoFile = File(_macOSAppInfoFilePath);
    if (!appInfoFile.existsSync()) {
      throw _PackageRenameErrors.macOSAppInfoNotFound;
    }

    final appInfoString = appInfoFile.readAsStringSync();
    final newAppNameAppInfoString = appInfoString.replaceAll(
      RegExp(r'PRODUCT_NAME = (.*)'),
      'PRODUCT_NAME = $appName',
    );

    appInfoFile.writeAsStringSync(newAppNameAppInfoString);

    _logger.i('MacOS product name set to: `$appName` (AppInfo.xcconfig)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('MacOS Product Name change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('MacOS Product Name change failed!!!');
  } finally {
    if (appName != null) _logger.wtf(_minorStepDoneLineBreak);
  }
}

void _setMacOSPackageName(dynamic packageName) {
  try {
    if (packageName == null) return;
    if (packageName is! String) throw _PackageRenameErrors.invalidPackageName;

    final appInfoFile = File(_macOSAppInfoFilePath);
    if (!appInfoFile.existsSync()) {
      throw _PackageRenameErrors.macOSAppInfoNotFound;
    }

    final appInfoString = appInfoFile.readAsStringSync();
    final newPackageNameAppInfoString = appInfoString.replaceAll(
      RegExp(r'PRODUCT_BUNDLE_IDENTIFIER = (.*)'),
      'PRODUCT_BUNDLE_IDENTIFIER = $packageName',
    );

    appInfoFile.writeAsStringSync(newPackageNameAppInfoString);

    _logger.i('MacOS bundle id set to: `$packageName` (AppInfo.xcconfig)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('MacOS Bundle ID change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('MacOS Bundle ID change failed!!!');
  } finally {
    if (packageName != null) _logger.wtf(_minorStepDoneLineBreak);
  }
}
