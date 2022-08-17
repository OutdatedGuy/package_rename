part of package_rename;

void _setMacOSConfigurations(dynamic macOSConfig) {
  try {
    if (macOSConfig == null) return;
    if (macOSConfig is! Map) throw _PackageRenameErrors.invalidMacOSConfig;

    final macOSConfigMap = Map<String, dynamic>.from(macOSConfig);

    _setMacOSAppName(macOSConfigMap[_appNameKey]);
    _setMacOSPackageName(macOSConfigMap[_packageNameKey]);
    _setMacOSCopyright(macOSConfigMap[_copyrightKey]);
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Skipping MacOS configuration!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Skipping MacOS configuration!!!');
  } finally {
    if (macOSConfig != null) _logger.w(_majorTaskDoneLine);
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
      RegExp('PRODUCT_NAME = (.*)'),
      'PRODUCT_NAME = $appName',
    );

    appInfoFile.writeAsStringSync(newAppNameAppInfoString);

    _logger.i('MacOS product name set to: `$appName` (AppInfo.xcconfig)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('MacOS Product Name change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('MacOS Product Name change failed!!!');
  } finally {
    if (appName != null) _logger.wtf(_minorTaskDoneLine);
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
      RegExp('PRODUCT_BUNDLE_IDENTIFIER = (.*)'),
      'PRODUCT_BUNDLE_IDENTIFIER = $packageName',
    );

    appInfoFile.writeAsStringSync(newPackageNameAppInfoString);

    _logger.i('MacOS bundle id set to: `$packageName` (AppInfo.xcconfig)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('MacOS Bundle ID change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('MacOS Bundle ID change failed!!!');
  } finally {
    if (packageName != null) _logger.wtf(_minorTaskDoneLine);
  }
}

void _setMacOSCopyright(dynamic notice) {
  try {
    if (notice == null) return;
    if (notice is! String) throw _PackageRenameErrors.invalidCopyrightNotice;

    final appInfoFile = File(_macOSAppInfoFilePath);
    if (!appInfoFile.existsSync()) {
      throw _PackageRenameErrors.macOSAppInfoNotFound;
    }

    final appInfoString = appInfoFile.readAsStringSync();
    final newCopyrightAppInfoString = appInfoString.replaceAll(
      RegExp('PRODUCT_COPYRIGHT = (.*)'),
      'PRODUCT_COPYRIGHT = $notice',
    );

    appInfoFile.writeAsStringSync(newCopyrightAppInfoString);

    _logger.i('MacOS product copyright set to: `$notice` (AppInfo.xcconfig)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('MacOS Product Copyright change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('MacOS Product Copyright change failed!!!');
  } finally {
    if (notice != null) _logger.wtf(_minorTaskDoneLine);
  }
}
