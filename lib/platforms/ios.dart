part of package_rename;

void _setIOSConfigurations(dynamic iosConfig) {
  try {
    if (iosConfig == null) return;
    if (iosConfig is! Map) throw _PackageRenameErrors.invalidIOSConfig;

    final iosConfigMap = Map<String, dynamic>.from(iosConfig);

    _setIOSDisplayName(iosConfigMap[_appNameKey]);
    _setIOSBundleName(iosConfigMap[_bundleNameKey]);
    _setIOSPackageName(iosConfigMap[_packageNameKey]);
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Skipping iOS configuration!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Skipping iOS configuration!!!');
  } finally {
    if (iosConfig != null) _logger.w(_majorTaskDoneLine);
  }
}

void _setIOSDisplayName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    final iosInfoPlistFile = File(_iosInfoPlistFilePath);
    if (!iosInfoPlistFile.existsSync()) {
      throw _PackageRenameErrors.iosInfoPlistNotFound;
    }

    final iosInfoPlistString = iosInfoPlistFile.readAsStringSync();
    final newDisplayNameIOSInfoPlistString = iosInfoPlistString.replaceAll(
      RegExp(r'<key>CFBundleDisplayName</key>\s*<string>(.*?)</string>'),
      '<key>CFBundleDisplayName</key>\n\t<string>$appName</string>',
    );

    iosInfoPlistFile.writeAsStringSync(newDisplayNameIOSInfoPlistString);

    _logger.i('iOS display name set to: `$appName` (Info.plist)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('iOS Display Name change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('iOS Display Name change failed!!!');
  } finally {
    if (appName != null) _logger.wtf(_minorTaskDoneLine);
  }
}

void _setIOSBundleName(dynamic bundleName) {
  try {
    if (bundleName == null) return;
    if (bundleName is! String) throw _PackageRenameErrors.invalidBundleName;

    if (bundleName.length > 15) {
      _logger.w(
        'Bundle name is too long. Maximum length should be 15 characters.',
      );
    }

    final iosInfoPlistFile = File(_iosInfoPlistFilePath);
    if (!iosInfoPlistFile.existsSync()) {
      throw _PackageRenameErrors.iosInfoPlistNotFound;
    }

    final iosInfoPlistString = iosInfoPlistFile.readAsStringSync();
    final newBundleNameIOSInfoPlistString = iosInfoPlistString.replaceAll(
      RegExp(r'<key>CFBundleName</key>\s*<string>(.*?)</string>'),
      '<key>CFBundleName</key>\n\t<string>$bundleName</string>',
    );

    iosInfoPlistFile.writeAsStringSync(newBundleNameIOSInfoPlistString);

    _logger.i('iOS bundle name set to: `$bundleName` (Info.plist)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('iOS Bundle Name change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('iOS Bundle Name change failed!!!');
  } finally {
    if (bundleName != null) _logger.wtf(_minorTaskDoneLine);
  }
}

void _setIOSPackageName(dynamic packageName) {
  try {
    if (packageName == null) return;
    if (packageName is! String) throw _PackageRenameErrors.invalidPackageName;

    final iosProjectFile = File(_iosProjectFilePath);
    if (!iosProjectFile.existsSync()) {
      throw _PackageRenameErrors.iosProjectFileNotFound;
    }

    final iosProjectString = iosProjectFile.readAsStringSync();
    final newBundleIDIOSProjectString = iosProjectString
        // Replaces old bundle id from
        // `PRODUCT_BUNDLE_IDENTIFIER = {{BUNDLE_ID}};`
        .replaceAll(
          RegExp(
            r'PRODUCT_BUNDLE_IDENTIFIER = ([A-Za-z0-9.-]+)(?<!\.RunnerTests);',
          ),
          'PRODUCT_BUNDLE_IDENTIFIER = $packageName;',
        )
        // Replaces old bundle id from
        // `PRODUCT_BUNDLE_IDENTIFIER = {{BUNDLE_ID}}.RunnerTests;`
        .replaceAll(
          RegExp('PRODUCT_BUNDLE_IDENTIFIER = (.*?).RunnerTests;'),
          'PRODUCT_BUNDLE_IDENTIFIER = $packageName.RunnerTests;',
        )
        // Removes old bundle id from
        // `PRODUCT_BUNDLE_IDENTIFIER = "{{BUNDLE_ID}}.{{EXTENSION_NAME}}";`
        .replaceAllMapped(
      RegExp(
        r'PRODUCT_BUNDLE_IDENTIFIER = "([A-Za-z0-9.-]+)\.([A-Za-z0-9.-]+)";',
      ),
      (match) {
        final extensionName = match.group(2);
        return 'PRODUCT_BUNDLE_IDENTIFIER = "$packageName.$extensionName";';
      },
    );

    iosProjectFile.writeAsStringSync(newBundleIDIOSProjectString);

    _logger.i('iOS bundle identifier set to: `$packageName` (project.pbxproj)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('iOS Bundle Identifier change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('iOS Bundle Identifier change failed!!!');
  } finally {
    if (packageName != null) _logger.wtf(_minorTaskDoneLine);
  }
}
