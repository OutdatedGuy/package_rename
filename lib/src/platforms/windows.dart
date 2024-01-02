// ignore_for_file: avoid_print

part of '../../package_rename_plus.dart';

void _setWindowsConfigurations(dynamic windowsConfig) {
  try {
    if (windowsConfig == null) return;
    if (windowsConfig is! Map) throw _PackageRenameErrors.invalidWindowsConfig;

    final windowsConfigMap = Map<String, dynamic>.from(windowsConfig);

    _setWindowsAppName(windowsConfigMap[_appNameKey]);
    _setWindowsOrganization(windowsConfigMap[_organizationKey]);
    _setWindowsCopyrightNotice(windowsConfigMap[_copyrightKey]);
    _setWindowsExecutableName(windowsConfigMap[_executableKey]);
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Skipping Windows configuration!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Skipping Windows configuration!!!');
  } finally {
    if (windowsConfig != null) print(_majorTaskDoneLine);
  }
}

void _setWindowsAppName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    _setWindowsAppTitle(appName);
    _setWindowsProductDetails(appName);
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Windows App Name change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Windows App Name change failed!!!');
  } finally {
    if (appName != null) print(_minorTaskDoneLine);
  }
}

void _setWindowsAppTitle(String appName) {
  try {
    final mainCppFile = File(_windowsMainCppFilePath);
    if (!mainCppFile.existsSync()) {
      throw _PackageRenameErrors.windowsMainCppNotFound;
    }

    final mainCppString = mainCppFile.readAsStringSync();

    final newAppTitleMainCppString = mainCppString
        .replaceAll(
          RegExp(r'window.CreateAndShow\(L"(.*)", origin, size\)'),
          'window.CreateAndShow(L"$appName", origin, size)',
        )
        // Implemented from Flutter 3.7 onwards
        .replaceAll(
          RegExp(r'window.Create\(L"(.*)", origin, size\)'),
          'window.Create(L"$appName", origin, size)',
        );

    mainCppFile.writeAsStringSync(newAppTitleMainCppString);

    print('Windows app title set to: `$appName` (main.cpp)');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Windows App Title change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Windows App Title change failed!!!');
  }
}

void _setWindowsProductDetails(String appName) {
  try {
    final runnerFile = File(_windowsRunnerFilePath);
    if (!runnerFile.existsSync()) {
      throw _PackageRenameErrors.windowsRunnerNotFound;
    }

    final runnerString = runnerFile.readAsStringSync();
    final newProductDetailsRunnerString = runnerString
        .replaceAll(
          RegExp(r'VALUE "FileDescription", "(.*)" "\\0"'),
          'VALUE "FileDescription", "$appName" "\\0"',
        )
        .replaceAll(
          RegExp(r'VALUE "InternalName", "(.*)" "\\0"'),
          'VALUE "InternalName", "$appName" "\\0"',
        )
        .replaceAll(
          RegExp(r'VALUE "ProductName", "(.*)" "\\0"'),
          'VALUE "ProductName", "$appName" "\\0"',
        );

    runnerFile.writeAsStringSync(newProductDetailsRunnerString);
    print('Windows file description set to: `$appName` (Runner.rc)');
    print('Windows internal name set to: `$appName` (Runner.rc)');
    print('Windows product name set to: `$appName` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Windows Product Details change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Windows Product Details change failed!!!');
  }
}

void _setWindowsOrganization(dynamic organization) {
  try {
    if (organization == null) return;
    if (organization is! String) throw _PackageRenameErrors.invalidOrganization;

    final runnerFile = File(_windowsRunnerFilePath);
    if (!runnerFile.existsSync()) {
      throw _PackageRenameErrors.windowsRunnerNotFound;
    }

    final runnerString = runnerFile.readAsStringSync();
    final newOrganizationRunnerString = runnerString.replaceAll(
      RegExp(r'VALUE "CompanyName", "(.*)" "\\0"'),
      'VALUE "CompanyName", "$organization" "\\0"',
    );

    runnerFile.writeAsStringSync(newOrganizationRunnerString);

    print('Windows company name set to: `$organization` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Windows Organization change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Windows Organization change failed!!!');
  } finally {
    if (organization != null) print(_minorTaskDoneLine);
  }
}

void _setWindowsCopyrightNotice(dynamic notice) {
  try {
    if (notice == null) return;
    if (notice is! String) throw _PackageRenameErrors.invalidCopyrightNotice;

    final runnerFile = File(_windowsRunnerFilePath);
    if (!runnerFile.existsSync()) {
      throw _PackageRenameErrors.windowsRunnerNotFound;
    }

    final runnerString = runnerFile.readAsStringSync();
    final newCopyrightNoticeRunnerString = runnerString.replaceAll(
      RegExp(r'VALUE "LegalCopyright", "(.*)" "\\0"'),
      'VALUE "LegalCopyright", "$notice" "\\0"',
    );

    runnerFile.writeAsStringSync(newCopyrightNoticeRunnerString);

    print('Windows legal copyright set to: `$notice` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Windows Copyright Notice change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Windows Copyright Notice change failed!!!');
  } finally {
    if (notice != null) print(_minorTaskDoneLine);
  }
}

void _setWindowsExecutableName(dynamic exeName) {
  try {
    if (exeName == null) return;
    if (exeName is! String) throw _PackageRenameErrors.invalidExecutableName;

    final validExeNameRegExp = RegExp(_desktopBinaryNameTemplate);
    if (!validExeNameRegExp.hasMatch(exeName)) {
      throw _PackageRenameErrors.invalidExecutableNameValue;
    }

    _setWindowsCMakeListsBinaryName(exeName);
    _setWindowsOriginalFilename(exeName);
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Windows Executable Name change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Windows Executable Name change failed!!!');
  } finally {
    if (exeName != null) print(_minorTaskDoneLine);
  }
}

void _setWindowsCMakeListsBinaryName(String exeName) {
  try {
    final cmakeListsFile = File(_windowsCMakeListsFilePath);
    if (!cmakeListsFile.existsSync()) {
      throw _PackageRenameErrors.windowsCMakeListsNotFound;
    }

    final cmakeListsString = cmakeListsFile.readAsStringSync();
    final newBinaryNameCmakeListsString = cmakeListsString.replaceAll(
      RegExp(r'set\(BINARY_NAME "(.*?)"\)'),
      'set(BINARY_NAME "$exeName")',
    );

    cmakeListsFile.writeAsStringSync(newBinaryNameCmakeListsString);

    print('Windows binary name set to: `$exeName` (CMakeLists.txt)');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Windows Binary Name change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Windows Binary Name change failed!!!');
  }
}

void _setWindowsOriginalFilename(String exeName) {
  try {
    final runnerFile = File(_windowsRunnerFilePath);
    if (!runnerFile.existsSync()) {
      throw _PackageRenameErrors.windowsRunnerNotFound;
    }

    final runnerString = runnerFile.readAsStringSync();
    final newOriginalFilenameRunnerString = runnerString.replaceAll(
      RegExp(r'VALUE "OriginalFilename", "(.*?)" "\\0"'),
      'VALUE "OriginalFilename", "$exeName.exe" "\\0"',
    );

    runnerFile.writeAsStringSync(newOriginalFilenameRunnerString);

    developer
        .log('Windows original filename set to: `$exeName.exe` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    print('${e.message}ERR Code: ${e.code}');
    print('Windows Original Filename change failed!!!');
  } catch (e) {
    print(e);
    print('ERR Code: 255');
    print('Windows Original Filename change failed!!!');
  }
}
