part of package_rename;

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
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Skipping Windows configuration!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Skipping Windows configuration!!!');
  } finally {
    if (windowsConfig != null) _logger.w(_majorTaskDoneLine);
  }
}

void _setWindowsAppName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    _setWindowsAppTitle(appName);
    _setWindowsProductDetails(appName);
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Windows App Name change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Windows App Name change failed!!!');
  } finally {
    if (appName != null) _logger.wtf(_minorTaskDoneLine);
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

    _logger.i('Windows app title set to: `$appName` (main.cpp)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Windows App Title change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Windows App Title change failed!!!');
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
          RegExp(r'VALUE "FileDescription", "(.*)" "\0"'),
          'VALUE "FileDescription", "$appName" "\\0"',
        )
        .replaceAll(
          RegExp(r'VALUE "InternalName", "(.*)" "\0"'),
          'VALUE "InternalName", "$appName" "\\0"',
        )
        .replaceAll(
          RegExp(r'VALUE "ProductName", "(.*)" "\0"'),
          'VALUE "ProductName", "$appName" "\\0"',
        );

    runnerFile.writeAsStringSync(newProductDetailsRunnerString);

    _logger
      ..i('Windows file description set to: `$appName` (Runner.rc)')
      ..i('Windows internal name set to: `$appName` (Runner.rc)')
      ..i('Windows product name set to: `$appName` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Windows Product Details change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Windows Product Details change failed!!!');
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
      RegExp(r'VALUE "CompanyName", "(.*)" "\0"'),
      'VALUE "CompanyName", "$organization" "\\0"',
    );

    runnerFile.writeAsStringSync(newOrganizationRunnerString);

    _logger.i('Windows company name set to: `$organization` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Windows Organization change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Windows Organization change failed!!!');
  } finally {
    if (organization != null) _logger.wtf(_minorTaskDoneLine);
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
      RegExp(r'VALUE "LegalCopyright", "(.*)" "\0"'),
      'VALUE "LegalCopyright", "$notice" "\\0"',
    );

    runnerFile.writeAsStringSync(newCopyrightNoticeRunnerString);

    _logger.i('Windows legal copyright set to: `$notice` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Windows Copyright Notice change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Windows Copyright Notice change failed!!!');
  } finally {
    if (notice != null) _logger.wtf(_minorTaskDoneLine);
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
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Windows Executable Name change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Windows Executable Name change failed!!!');
  } finally {
    if (exeName != null) _logger.wtf(_minorTaskDoneLine);
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

    _logger.i('Windows binary name set to: `$exeName` (CMakeLists.txt)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Windows Binary Name change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Windows Binary Name change failed!!!');
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
      RegExp(r'VALUE "OriginalFilename", "(.*?)" "\0"'),
      'VALUE "OriginalFilename", "$exeName.exe" "\\0"',
    );

    runnerFile.writeAsStringSync(newOriginalFilenameRunnerString);

    _logger.i('Windows original filename set to: `$exeName.exe` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    _logger
      ..e('${e.message}ERR Code: ${e.code}')
      ..e('Windows Original Filename change failed!!!');
  } catch (e) {
    _logger
      ..w(e.toString())
      ..e('ERR Code: 255')
      ..e('Windows Original Filename change failed!!!');
  }
}
