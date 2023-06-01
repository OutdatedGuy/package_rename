part of package_rename;

void _setMacOSConfigurations(dynamic macOSConfig) {
  try {
    if (macOSConfig == null) return;
    if (macOSConfig is! Map) throw _PackageRenameErrors.invalidMacOSConfig;

    final macOSConfigMap = Map<String, dynamic>.from(macOSConfig);

    _setMacOSAppName(macOSConfigMap[_appNameKey]);
    _setMacOSBundleID(macOSConfigMap[_packageNameKey]);
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

    _setMacOSProductName(appName);
    _setMacOSBuildableName(appName);
    _setMacOSAppNameInProjectFile(appName);
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('MacOS App Name change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('MacOS App Name change failed!!!');
  } finally {
    if (appName != null) _logger.wtf(_minorTaskDoneLine);
  }
}

void _setMacOSProductName(String productName) {
  try {
    final appInfoFile = File(_macOSAppInfoFilePath);
    if (!appInfoFile.existsSync()) {
      throw _PackageRenameErrors.macOSAppInfoNotFound;
    }

    final appInfoString = appInfoFile.readAsStringSync();
    final newProductNameAppInfoString = appInfoString.replaceAll(
      RegExp('PRODUCT_NAME = (.*)'),
      'PRODUCT_NAME = $productName',
    );

    appInfoFile.writeAsStringSync(newProductNameAppInfoString);

    _logger.i('MacOS product name set to: `$productName` (AppInfo.xcconfig)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('MacOS Product Name change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('MacOS Product Name change failed!!!');
  }
}

void _setMacOSBuildableName(String buildableName) {
  try {
    final runnerXCSchemeFile = File(_macOSRunnerXCSchemeFilePath);
    if (!runnerXCSchemeFile.existsSync()) {
      throw _PackageRenameErrors.macOSRunnerXCSchemeNotFound;
    }

    final runnerXCSchemeString = runnerXCSchemeFile.readAsStringSync();
    final newBuildableNameXCSchemeString = runnerXCSchemeString.replaceAll(
      RegExp('BuildableName = "(.*).app"'),
      'BuildableName = "$buildableName.app"',
    );

    runnerXCSchemeFile.writeAsStringSync(newBuildableNameXCSchemeString);

    _logger.i(
      'MacOS buildable name set to: `$buildableName` (Runner.xcscheme)',
    );
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('MacOS Buildable Name change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('MacOS Buildable Name change failed!!!');
  }
}

void _setMacOSAppNameInProjectFile(String appName) {
  try {
    final projectFile = File(_macOSProjectFilePath);
    if (!projectFile.existsSync()) {
      throw _PackageRenameErrors.macOSProjectFileNotFound;
    }

    final projectString = projectFile.readAsStringSync();
    final newDotAppProjectString = projectString
        .replaceAll(
          RegExp(r'/\* (.*).app \*/'),
          '/* $appName.app */',
        )
        .replaceAll(
          RegExp('path = "(.*).app";'),
          'path = "$appName.app";',
        )
        .replaceAll(
          RegExp('path = (.*).app;'),
          'path = "$appName.app";',
        )
        .replaceAll(
          RegExp(
            r'TEST_HOST = "\$\(BUILT_PRODUCTS_DIR\)/'
            r'(.*).app/\$\(BUNDLE_EXECUTABLE_FOLDER_PATH\)/(.*)"',
          ),
          r'TEST_HOST = "$(BUILT_PRODUCTS_DIR)/'
          '$appName.app/\$(BUNDLE_EXECUTABLE_FOLDER_PATH)/$appName"',
        );

    projectFile.writeAsStringSync(newDotAppProjectString);

    _logger.i('MacOS .app name set to: `$appName.app` (project.pbxproj)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('MacOS .app Name change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('MacOS .app Name change failed!!!');
  }
}

void _setMacOSBundleID(dynamic packageName) {
  try {
    if (packageName == null) return;
    if (packageName is! String) throw _PackageRenameErrors.invalidPackageName;

    _setMacOSAppInfoBundleID(packageName);
    _setMacOSProjectFileBundleID(packageName);
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

void _setMacOSAppInfoBundleID(String bundleID) {
  try {
    final appInfoFile = File(_macOSAppInfoFilePath);
    if (!appInfoFile.existsSync()) {
      throw _PackageRenameErrors.macOSAppInfoNotFound;
    }

    final appInfoString = appInfoFile.readAsStringSync();
    final newPackageNameAppInfoString = appInfoString.replaceAll(
      RegExp('PRODUCT_BUNDLE_IDENTIFIER = (.*)'),
      'PRODUCT_BUNDLE_IDENTIFIER = $bundleID',
    );

    appInfoFile.writeAsStringSync(newPackageNameAppInfoString);

    _logger.i('MacOS bundle id set to: `$bundleID` (AppInfo.xcconfig)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('MacOS Bundle ID change failed!!! (AppInfo.xcconfig)');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('MacOS Bundle ID change failed!!! (AppInfo.xcconfig)');
  }
}

void _setMacOSProjectFileBundleID(String bundleID) {
  try {
    final macOSProjectFile = File(_macOSProjectFilePath);
    if (!macOSProjectFile.existsSync()) {
      throw _PackageRenameErrors.iosProjectFileNotFound;
    }

    final macOSProjectString = macOSProjectFile.readAsStringSync();
    final newBundleIDMacOSProjectString = macOSProjectString
        // Replaces old bundle id from
        // `PRODUCT_BUNDLE_IDENTIFIER = {{BUNDLE_ID}}.RunnerTests;`
        .replaceAll(
      RegExp('PRODUCT_BUNDLE_IDENTIFIER = (.*?).RunnerTests;'),
      'PRODUCT_BUNDLE_IDENTIFIER = $bundleID.RunnerTests;',
    )
        // Removes old bundle id from
        // `PRODUCT_BUNDLE_IDENTIFIER = "{{BUNDLE_ID}}.{{EXTENSION_NAME}}";`
        .replaceAllMapped(
      RegExp(
        r'PRODUCT_BUNDLE_IDENTIFIER = "([A-Za-z0-9.-]+)\.([A-Za-z0-9.-]+)";',
      ),
      (match) {
        final extensionName = match.group(2);
        return 'PRODUCT_BUNDLE_IDENTIFIER = "$bundleID.$extensionName";';
      },
    );

    macOSProjectFile.writeAsStringSync(newBundleIDMacOSProjectString);

    _logger.i('MacOS bundle id set to: `$bundleID` (project.pbxproj)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('MacOS Bundle ID change failed!!! (project.pbxproj)');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('MacOS Bundle ID change failed!!! (project.pbxproj)');
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
