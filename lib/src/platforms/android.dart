// ignore_for_file: avoid_print

part of '../../package_rename_plus.dart';

void _setAndroidConfigurations(dynamic androidConfig) {
  try {
    if (androidConfig == null) return;
    if (androidConfig is! Map) throw _PackageRenameErrors.invalidAndroidConfig;

    final androidConfigMap = Map<String, dynamic>.from(androidConfig);

    _setAndroidAppName(androidConfigMap[_appNameKey]);
    _setAndroidPackageName(androidConfigMap[_packageNameKey]);
    _createNewMainActivity(
      lang: androidConfigMap[_languageKey],
      packageName: androidConfigMap[_packageNameKey],
      overrideOldPackage: androidConfigMap[_overrideOldPackageKey],
    );
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Skipping Android configuration!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Skipping Android configuration!!!');
  } finally {
    if (androidConfig != null) print(_majorTaskDoneLine);
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

    final androidManifestString = androidManifestFile.readAsStringSync();
    final newLabelAndroidManifestString = androidManifestString.replaceAll(
      RegExp('android:label="(.*)"'),
      'android:label="$appName"',
    );

    androidManifestFile.writeAsStringSync(newLabelAndroidManifestString);

    print('Android label set to: `$appName` (main AndroidManifest.xml)');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Android Label change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Android Label change failed!!!');
  } finally {
    if (appName != null) print(_minorTaskDoneLine);
  }
}

void _setAndroidPackageName(dynamic packageName) {
  try {
    if (packageName == null) return;
    if (packageName is! String) throw _PackageRenameErrors.invalidPackageName;

    final androidManifestFilePaths = [
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
    print('${e.message}ERR Code: ${e.code}');
    print('Android Package change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Android Package change failed!!!');
  } finally {
    if (packageName != null) print(_minorTaskDoneLine);
  }
}

void _setManifestPackageName({
  required List<String> manifestFilePaths,
  required String packageName,
}) {
  for (final androidManifestFilePath in manifestFilePaths) {
    final androidManifestFile = File(androidManifestFilePath);
    if (!androidManifestFile.existsSync()) {
      print(
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

    print(
      'Android package set to: `$packageName` ($dirName AndroidManifest.xml)',
    );
  }
}

void _setBuildGradlePackageName({
  required String buildGradleFilePath,
  required String packageName,
}) {
  final buildGradleFile = File(buildGradleFilePath);
  if (!buildGradleFile.existsSync()) {
    print(
      'build.gradle file not found at: $buildGradleFilePath',
    );
    return;
  }

  final buildGradleString = buildGradleFile.readAsStringSync();
  final newPackageIDBuildGradleString = buildGradleString
      .replaceAll(
        RegExp('applicationId "(.*?)"'),
        'applicationId "$packageName"',
      )
      .replaceAll(
        RegExp("applicationId '(.*?)'"),
        'applicationId "$packageName"',
      )
      .replaceAll(
        RegExp('namespace "(.*?)"'),
        'namespace "$packageName"',
      )
      .replaceAll(
        RegExp("namespace '(.*?)'"),
        'namespace "$packageName"',
      )

      /// Support that code using "="
      .replaceAll(
        RegExp('applicationId = "(.*?)"'),
        'applicationId "$packageName"',
      )
      .replaceAll(
        RegExp("applicationId = '(.*?)'"),
        'applicationId "$packageName"',
      )
      .replaceAll(
        RegExp('namespace = "(.*?)"'),
        'namespace "$packageName"',
      )
      .replaceAll(
        RegExp("namespace = '(.*?)'"),
        'namespace "$packageName"',
      );

  buildGradleFile.writeAsStringSync(newPackageIDBuildGradleString);

  print(
    'Android applicationId set to: `$packageName` (build.gradle)',
  );
}

void _createNewMainActivity({
  required dynamic lang,
  required dynamic packageName,
  required dynamic overrideOldPackage,
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
      final langDir = '$_androidMainDirPath/$lang';

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
      final langDir = '$_androidMainDirPath/$lang';

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

    print('New MainActivity.${lang == 'kotlin' ? 'kt' : 'java'} created');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('New MainActivity creation failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('New MainActivity creation failed!!!');
  } finally {
    if (packageName != null) print(_minorTaskDoneLine);
  }
}
