part of package_rename;

void _setIOSConfigurations(dynamic iosConfig) {
  try {
    if (iosConfig == null) return;
    if (iosConfig is! Map) throw _PackageRenameErrors.invalidIOSConfig;

    final iosConfigMap = Map<String, dynamic>.from(iosConfig);

    _setIOSDisplayName(iosConfigMap[_appNameKey]);
    _setIOSBundleName(iosConfigMap[_bundleNameKey]);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Skipping iOS configuration!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Skipping iOS configuration!!!');
  } finally {
    if (iosConfig != null) _logger.i(_majorStepDoneLineBreak);
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

    RegExp regExp = RegExp(
      r'<key>CFBundleDisplayName</key>\s*<string>(.*?)</string>',
    );
    final appNameString =
        '<key>CFBundleDisplayName</key>\n\t<string>$appName</string>';

    final iosInfoPlistString = iosInfoPlistFile.readAsStringSync();
    final iosInfoPlistStringWithNewAppName =
        iosInfoPlistString.replaceAll(regExp, appNameString);

    iosInfoPlistFile.writeAsStringSync(iosInfoPlistStringWithNewAppName);

    _logger.i('iOS display name set to: `$appName`');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('iOS Display Name change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('iOS Display Name change failed!!!');
  } finally {
    _logger.i(_minorStepDoneLineBreak);
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

    RegExp regExp = RegExp(
      r'<key>CFBundleName</key>\s*<string>(.*?)</string>',
    );
    final bundleNameString =
        '<key>CFBundleName</key>\n\t<string>$bundleName</string>';

    final iosInfoPlistString = iosInfoPlistFile.readAsStringSync();
    final iosInfoPlistStringWithNewBundleName =
        iosInfoPlistString.replaceAll(regExp, bundleNameString);

    iosInfoPlistFile.writeAsStringSync(iosInfoPlistStringWithNewBundleName);

    _logger.i('iOS bundle name set to: `$bundleName`');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('iOS Bundle Name change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('iOS Bundle Name change failed!!!');
  } finally {
    _logger.i(_minorStepDoneLineBreak);
  }
}
