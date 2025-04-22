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

    // Extract all bundle identifiers, accounting for both quoted and unquoted formats
    final bundleIdRegex = RegExp(
      r'PRODUCT_BUNDLE_IDENTIFIER = "?([^";]+)"?;',
      multiLine: true,
    );

    final bundleIdentifierMatches = bundleIdRegex
        .allMatches(iosProjectString)
        .map((m) => m.group(1)!)
        .toList();

    if (bundleIdentifierMatches.isEmpty) {
      throw Exception('No bundle identifiers found in project file');
    }

    // Find all unique base identifiers (without extensions)
    // We'll consider identifiers that are substrings of others as potential base identifiers
    final baseIdentifierCandidates = <String>[];

    for (final identifier in bundleIdentifierMatches) {
      bool isBaseForOthers = false;
      for (final other in bundleIdentifierMatches) {
        if (identifier != other && other.startsWith(identifier)) {
          isBaseForOthers = true;
          break;
        }
      }

      if (isBaseForOthers) {
        baseIdentifierCandidates.add(identifier);
      }
    }

    // If we couldn't find any base identifiers, use the shortest one as fallback
    String baseIdentifier;
    if (baseIdentifierCandidates.isEmpty) {
      // If there are no base candidates, it means all identifiers are unique
      // Or there's only one identifier. Use the shortest as the base.
      baseIdentifier = bundleIdentifierMatches
          .reduce((a, b) => a.length <= b.length ? a : b);
    } else {
      // Use the shortest base candidate
      baseIdentifier = baseIdentifierCandidates
          .reduce((a, b) => a.length <= b.length ? a : b);
    }

    // Create a map of all identifiers to their new values
    final identifierReplacements = <String, String>{};

    for (final identifier in bundleIdentifierMatches) {
      if (identifier == baseIdentifier) {
        identifierReplacements[identifier] = packageName;
      } else if (identifier.startsWith(baseIdentifier)) {
        // This is an extension
        final extension = identifier.substring(baseIdentifier.length);
        identifierReplacements[identifier] = '$packageName$extension';
      } else {
        // This is an unrelated identifier, skip it
        _logger.w('Skipping unrelated identifier: $identifier');
      }
    }

    // Apply all replacements to the project file
    var newIosProjectString = iosProjectString;

    identifierReplacements.forEach((oldId, newId) {
      // Replace unquoted format
      newIosProjectString = newIosProjectString.replaceAll(
        'PRODUCT_BUNDLE_IDENTIFIER = $oldId;',
        'PRODUCT_BUNDLE_IDENTIFIER = $newId;',
      );

      // Replace quoted format
      newIosProjectString = newIosProjectString.replaceAll(
        'PRODUCT_BUNDLE_IDENTIFIER = "$oldId";',
        'PRODUCT_BUNDLE_IDENTIFIER = "$newId";',
      );
    });

    // Special case for RunnerTests which might not be caught by the pattern above
    if (identifierReplacements.containsKey(baseIdentifier)) {
      newIosProjectString = newIosProjectString.replaceAll(
        RegExp('PRODUCT_BUNDLE_IDENTIFIER = "$baseIdentifier\\.RunnerTests";'),
        'PRODUCT_BUNDLE_IDENTIFIER = "$packageName.RunnerTests";',
      );

      newIosProjectString = newIosProjectString.replaceAll(
        RegExp('PRODUCT_BUNDLE_IDENTIFIER = $baseIdentifier\\.RunnerTests;'),
        'PRODUCT_BUNDLE_IDENTIFIER = $packageName.RunnerTests;',
      );
    }

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
