part of '../package_rename.dart';

void _setAndroidConfigurations(dynamic androidConfig) {
  try {
    if (androidConfig == null) return;
    if (androidConfig is! Map) throw _PackageRenameErrors.invalidAndroidConfig;

    final androidConfigMap = Map<String, dynamic>.from(androidConfig);

    _setAndroidAppName(
        androidConfigMap[_appNameKey], androidConfigMap[_customDirPath], androidConfigMap[_host]);
    _setAndroidPackageName(
        androidConfigMap[_packageNameKey], androidConfigMap[_customDirPath]);
    _createNewMainActivity(
      lang: androidConfigMap[_languageKey],
      packageName: androidConfigMap[_packageNameKey],
      overrideOldPackage: androidConfigMap[_overrideOldPackageKey],
      customDirPath: androidConfigMap[_customDirPath],
    );
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Skipping Android configuration!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Skipping Android configuration!!!');
  } finally {
    if (androidConfig != null) _logger.w(_majorTaskDoneLine);
  }
}

void _setAndroidAppName(dynamic appName, String? customDirPath, dynamic host) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    final androidMainManifestFilePath =
        (customDirPath is String && customDirPath.isNotEmpty)
            ? _androidMainManifestFilePath.replaceAll(
                _androidAppDirPath, customDirPath)
            : _androidMainManifestFilePath;

    final androidManifestFile = File(androidMainManifestFilePath);
    if (!androidManifestFile.existsSync()) {
      throw _PackageRenameErrors.androidMainManifestNotFound;
    }

    final androidManifestString = androidManifestFile.readAsStringSync();
    String newLabelAndroidManifestString = androidManifestString.replaceAll(
      RegExp('android:label="(.*)"'),
      'android:label="$appName"',
    );
    if (host is String && host.isNotEmpty) {
      newLabelAndroidManifestString = newLabelAndroidManifestString.replaceAll(
        RegExp('android:host="(.*)"'),
        'android:host="$host"',
      );
      _logger.i('Android Host set to: `$host` (main AndroidManifest.xml)');
    }

    androidManifestFile.writeAsStringSync(newLabelAndroidManifestString);

    _logger.i('Android label set to: `$appName` (main AndroidManifest.xml)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Android Label change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Android Label change failed!!!');
  } finally {
    if (appName != null) _logger.f(_minorTaskDoneLine);
  }
}

void _setAndroidPackageName(dynamic packageName, String? customDirPath) {
  try {
    if (packageName == null) return;
    if (packageName is! String) throw _PackageRenameErrors.invalidPackageName;

    final androidManifestFilePaths = [
      (customDirPath is String && customDirPath.isNotEmpty)
          ? _androidMainManifestFilePath.replaceAll(
              _androidAppDirPath, customDirPath)
          : _androidMainManifestFilePath,
      (customDirPath is String && customDirPath.isNotEmpty)
          ? _androidDebugManifestFilePath.replaceAll(
              _androidAppDirPath, customDirPath)
          : _androidDebugManifestFilePath,
      (customDirPath is String && customDirPath.isNotEmpty)
          ? _androidProfileManifestFilePath.replaceAll(
              _androidAppDirPath, customDirPath)
          : _androidProfileManifestFilePath,
    ];

    _setManifestPackageName(
      manifestFilePaths: androidManifestFilePaths,
      packageName: packageName,
    );

    _setBuildGradlePackageName(
      buildGradleFilePath: (customDirPath is String && customDirPath.isNotEmpty)
          ? _androidAppLevelBuildGradleFilePath.replaceAll(
              _androidAppDirPath, customDirPath)
          : _androidAppLevelBuildGradleFilePath,
      kotlinBuildGradleFilePath:
          (customDirPath is String && customDirPath.isNotEmpty)
              ? _androidAppLevelKotlinBuildGradleFilePath.replaceAll(
                  _androidAppDirPath, customDirPath)
              : _androidAppLevelKotlinBuildGradleFilePath,
      packageName: packageName,
    );
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Android Package change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Android Package change failed!!!');
  } finally {
    if (packageName != null) _logger.f(_minorTaskDoneLine);
  }
}

void _setManifestPackageName({
  required List<String> manifestFilePaths,
  required String packageName,
}) {
  for (final androidManifestFilePath in manifestFilePaths) {
    final androidManifestFile = File(androidManifestFilePath);
    if (!androidManifestFile.existsSync()) {
      _logger.w(
        'AndroidManifest.xml file not found at: $androidManifestFilePath',
      );
      continue;
    }

    final androidManifestString = androidManifestFile.readAsStringSync();
    final newPackageAndroidManifestString = androidManifestString.replaceAll(
      RegExp('package="(.*?)"'),
      'package="$packageName"',
    );

    androidManifestFile.writeAsStringSync(newPackageAndroidManifestString);

    // Get directory name from path
    final dirName = androidManifestFilePath.split('/').reversed.toList()[1];

    _logger.i(
      'Android package set to: `$packageName` ($dirName AndroidManifest.xml)',
    );
  }
}

void _setBuildGradlePackageName({
  required String buildGradleFilePath,
  required String kotlinBuildGradleFilePath,
  required String packageName,
}) {
  final gradleFile = _getAvailableGradleFile(
    buildGradleFilePath: buildGradleFilePath,
    kotlinBuildGradleFilePath: kotlinBuildGradleFilePath,
  );

  if (gradleFile == null) {
    _logger.w(
      'build.gradle or build.gradle.kts file not found at: '
      '$buildGradleFilePath or $kotlinBuildGradleFilePath',
    );
    return;
  }

  final buildGradleString = gradleFile.readAsStringSync();
  final newPackageIDBuildGradleString = buildGradleString
      .replaceAll(
        RegExp('applicationId\\s*=?\\s*["\'].*?["\']'),
        'applicationId = "$packageName"',
      )
      .replaceAll(
        RegExp('namespace\\s*=?\\s*["\'].*?["\']'),
        'namespace = "$packageName"',
      );

  gradleFile.writeAsStringSync(newPackageIDBuildGradleString);

  _logger.i(
    'Android applicationId set to: `$packageName` (build.gradle)',
  );
}

File? _getAvailableGradleFile({
  required String buildGradleFilePath,
  required String kotlinBuildGradleFilePath,
}) {
  final kotlinBuildGradleFile = File(kotlinBuildGradleFilePath);
  if (kotlinBuildGradleFile.existsSync()) {
    return kotlinBuildGradleFile;
  }

  final buildGradleFile = File(buildGradleFilePath);
  if (buildGradleFile.existsSync()) {
    return buildGradleFile;
  }

  return null;
}

void _createNewMainActivity({
  required dynamic lang,
  required dynamic packageName,
  required dynamic overrideOldPackage,
  String? customDirPath,
}) {
  try {
    if (packageName == null) return;
    if (packageName is! String) throw _PackageRenameErrors.invalidPackageName;

    lang ??= 'kotlin';
    if (lang is! String) throw _PackageRenameErrors.invalidLanguageType;

    late String fileExtension;
    switch (lang) {
      case 'kotlin':
        fileExtension = 'kt';
        break;
      case 'java':
        fileExtension = 'java';
        break;
      default:
        throw _PackageRenameErrors.invalidAndroidLanguageValue;
    }

    if (overrideOldPackage == null) {
      final packageDirs = packageName.replaceAll('.', '/');
      final dirPath = (customDirPath is String && customDirPath.isNotEmpty)
          ? '${_androidMainDirPath.replaceAll(_androidAppDirPath, customDirPath)}/$lang'
          : '$_androidMainDirPath/$lang';
      final langDir = dirPath;

      final mainActivityFile = File(
        '$langDir/$packageDirs/MainActivity.$fileExtension',
      )..createSync(recursive: true);

      var fileContent = lang == 'kotlin'
          ? _androidKotlinMainActivityTemplate
          : _androidJavaMainActivityTemplate;

      late String newPackageName;
      if (lang == 'kotlin') {
        newPackageName = packageName.split('.').map((element) {
          if (element == 'in') return '`in`';
          return element;
        }).join('.');
      } else {
        newPackageName = packageName;
      }

      fileContent = fileContent.replaceAll(
        RegExp('{{packageName}}'),
        newPackageName,
      );

      mainActivityFile.writeAsStringSync(fileContent);
    } else {
      if (overrideOldPackage is! String) {
        throw _PackageRenameErrors.invalidPackageName;
      }

      // Rename(move) all files from old package directory structure
      // to new package directory structure
      final oldPackageDirs = overrideOldPackage.replaceAll('.', '/');
      final newPackageDirs = packageName.replaceAll('.', '/');
      final dirPath = (customDirPath is String && customDirPath.isNotEmpty)
          ? '${_androidMainDirPath.replaceAll(_androidAppDirPath, customDirPath)}/$lang'
          : '$_androidMainDirPath/$lang';
      final langDir = dirPath;

      final oldMainActivityDir = Directory('$langDir/$oldPackageDirs');
      if (!oldMainActivityDir.existsSync()) {
        throw _PackageRenameErrors.androidOldDirectoryNotFound;
      }

      // Loop through all files in old package directory and move them
      // to new package directory
      final oldDirContents = oldMainActivityDir.listSync();
      final newMainActivityDir = Directory('$langDir/$newPackageDirs')
        ..createSync(recursive: true);
      for (final element in oldDirContents) {
        element.renameSync(
          '$langDir/$newPackageDirs/'
          '${element.path.split(Platform.pathSeparator).last}',
        );
      }

      // Delete empty old package directory from child to parent
      // To avoid deleteing newly created package directory if it's name
      // is a substring of old package name
      // e.g. com.example and com.example2
      var oldPackageDir = oldMainActivityDir;
      while (oldPackageDir.listSync().isEmpty) {
        oldPackageDir.deleteSync();
        oldPackageDir = oldPackageDir.parent;
      }

      // Change occurences of old package name to new package name
      // in all files in new package directory
      final newMainActivityDirFiles =
          newMainActivityDir.listSync(recursive: true).whereType<File>();

      late String newPackageName;
      if (lang == 'kotlin') {
        newPackageName = packageName.split('.').map((element) {
          if (element == 'in') return '`in`';
          return element;
        }).join('.');
      } else {
        newPackageName = packageName;
      }

      for (final file in newMainActivityDirFiles) {
        var fileContent = file.readAsStringSync();
        fileContent = fileContent.replaceAll(
          RegExp(overrideOldPackage),
          newPackageName,
        );
        file.writeAsStringSync(fileContent);
      }
    }

    _logger.i('New MainActivity.${lang == 'kotlin' ? 'kt' : 'java'} created');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('New MainActivity creation failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('New MainActivity creation failed!!!');
  } finally {
    if (packageName != null) _logger.f(_minorTaskDoneLine);
  }
}
