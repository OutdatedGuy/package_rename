part of '../package_rename.dart';

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
    if (appName != null) _logger.f(_minorTaskDoneLine);
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
    if (bundleName != null) _logger.f(_minorTaskDoneLine);
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

    // Extract all bundle identifiers, using only allowed characters
    final bundleIdRegex = RegExp(
      r'PRODUCT_BUNDLE_IDENTIFIER = "?([A-Za-z0-9.-]+)"?;',
    );

    final bundleIdentifierMatches = bundleIdRegex
        .allMatches(iosProjectString)
        .map((m) => m.group(1)!)
        .toSet();

    if (bundleIdentifierMatches.isEmpty) {
      throw _PackageRenameErrors.baseIdentifierNotFound;
    }

    // Find the base identifier by counting extensions
    String? baseIdentifier;

    // Build a map of identifier to extension count
    final extensionCountMap = <String, int>{};
    for (final identifier in bundleIdentifierMatches) {
      extensionCountMap[identifier] = bundleIdentifierMatches
          .where((other) => other != identifier && other.startsWith('$identifier.'))
          .length;
    }
    baseIdentifier = extensionCountMap.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;

    // Replace all occurrences
    final newIosProjectString = iosProjectString.replaceAllMapped(
      RegExp(
        'PRODUCT_BUNDLE_IDENTIFIER = ("?)${RegExp.escape(baseIdentifier)}(\\.[A-Za-z0-9.-]+)?("?);',
      ),
      (match) {
        final openQuote = match.group(1) ?? '';
        final extension = match.group(2) ?? '';
        final closeQuote = match.group(3) ?? '';

        return 'PRODUCT_BUNDLE_IDENTIFIER = $openQuote$packageName$extension$closeQuote;';
      },
    );

    iosProjectFile.writeAsStringSync(newIosProjectString);

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
    if (packageName != null) _logger.f(_minorTaskDoneLine);
  }
}
