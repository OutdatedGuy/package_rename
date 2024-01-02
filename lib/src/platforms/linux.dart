// ignore_for_file: avoid_print

part of '../../package_rename_plus.dart';

void _setLinuxConfigurations(dynamic linuxConfig) {
  try {
    if (linuxConfig == null) return;
    if (linuxConfig is! Map) throw _PackageRenameErrors.invalidLinuxConfig;

    final linuxConfigMap = Map<String, dynamic>.from(linuxConfig);

    _setLinuxAppName(linuxConfigMap[_appNameKey]);
    _setLinuxPackageName(linuxConfigMap[_packageNameKey]);
    _setLinuxExecutableName(linuxConfigMap[_executableKey]);
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Skipping Linux configuration!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Skipping Linux configuration!!!');
  } finally {
    if (linuxConfig != null) print(_majorTaskDoneLine);
  }
}

void _setLinuxAppName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    final myAppFile = File(_linuxMyApplicationFilePath);
    if (!myAppFile.existsSync()) {
      throw _PackageRenameErrors.linuxMyApplicationNotFound;
    }

    final myAppString = myAppFile.readAsStringSync();
    final newTitleMyAppString = myAppString
        .replaceAll(
          RegExp(r'gtk_header_bar_set_title\(header_bar, "(.*)"\);'),
          'gtk_header_bar_set_title(header_bar, "$appName");',
        )
        .replaceAll(
          RegExp(r'gtk_window_set_title\(window, "(.*)"\);'),
          'gtk_window_set_title(window, "$appName");',
        );

    myAppFile.writeAsStringSync(newTitleMyAppString);

    print('Linux app title set to: `$appName` (my_application.cc)');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Linux App Name change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Linux App Name change failed!!!');
  } finally {
    if (appName != null) print(_minorTaskDoneLine);
  }
}

void _setLinuxPackageName(dynamic packageName) {
  try {
    if (packageName == null) return;
    if (packageName is! String) throw _PackageRenameErrors.invalidPackageName;

    final cmakeListsFile = File(_linuxCMakeListsFilePath);
    if (!cmakeListsFile.existsSync()) {
      throw _PackageRenameErrors.linuxCMakeListsNotFound;
    }

    final cmakeListsString = cmakeListsFile.readAsStringSync();
    final newAppIDCmakeListsString = cmakeListsString.replaceAll(
      RegExp(r'set\(APPLICATION_ID "(.*?)"\)'),
      'set(APPLICATION_ID "$packageName")',
    );

    cmakeListsFile.writeAsStringSync(newAppIDCmakeListsString);

    print('Linux application id set to: `$packageName` (CMakeLists.txt)');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Linux Application ID change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Linux Application ID change failed!!!');
  } finally {
    if (packageName != null) print(_minorTaskDoneLine);
  }
}

void _setLinuxExecutableName(dynamic exeName) {
  try {
    if (exeName == null) return;
    if (exeName is! String) throw _PackageRenameErrors.invalidExecutableName;

    final validExeNameRegExp = RegExp(_desktopBinaryNameTemplate);
    if (!validExeNameRegExp.hasMatch(exeName)) {
      throw _PackageRenameErrors.invalidExecutableNameValue;
    }

    final cmakeListsFile = File(_linuxCMakeListsFilePath);
    if (!cmakeListsFile.existsSync()) {
      throw _PackageRenameErrors.linuxCMakeListsNotFound;
    }

    final cmakeListsString = cmakeListsFile.readAsStringSync();
    final newBinaryNameCmakeListsString = cmakeListsString.replaceAll(
      RegExp(r'set\(BINARY_NAME "(.*?)"\)'),
      'set(BINARY_NAME "$exeName")',
    );

    cmakeListsFile.writeAsStringSync(newBinaryNameCmakeListsString);

    print('Linux binary name set to: `$exeName` (CMakeLists.txt)');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Linux Executable Name change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Linux Executable Name change failed!!!');
  } finally {
    if (exeName != null) print(_minorTaskDoneLine);
  }
}
