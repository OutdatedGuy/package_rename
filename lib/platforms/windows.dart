part of package_rename;

void _setWindowsConfigurations(dynamic windowsConfig) {
  try {
    if (windowsConfig == null) return;
    if (windowsConfig is! Map) throw _PackageRenameErrors.invalidWindowsConfig;

    final windowsConfigMap = Map<String, dynamic>.from(windowsConfig);

    _setWindowsAppName(windowsConfigMap[_appNameKey]);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Skipping Windows configuration!!!');
  } finally {
    if (windowsConfig != null) _logger.i(_majorStepDoneLineBreak);
  }
}

void _setWindowsAppName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    _setWindowsCMakeListsAppName(appName);
    _setWindowsAppTitle(appName);
    _setWindowsProductDetails(appName);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows App Name change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows App Name change failed!!!');
  } finally {
    if (appName != null) _logger.i(_minorStepDoneLineBreak);
  }
}

void _setWindowsCMakeListsAppName(String appName) {
  try {
    final cmakeListsFile = File(_windowsCMakeListsFilePath);
    if (!cmakeListsFile.existsSync()) {
      throw _PackageRenameErrors.windowsCMakeListsNotFound;
    }

    final cmakeListsString = cmakeListsFile.readAsStringSync();
    final newBinaryNameCmakeListsString = cmakeListsString.replaceAll(
      RegExp(r'set\(BINARY_NAME "(.*?)"\)'),
      'set(BINARY_NAME "$appName")',
    );

    cmakeListsFile.writeAsStringSync(newBinaryNameCmakeListsString);

    _logger.i('Windows binary name set to: `$appName` (CMakeLists.txt)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows Binary Name change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows Binary Name change failed!!!');
  }
}

void _setWindowsAppTitle(String appName) {
  try {
    final mainCppFile = File(_windowsMainCppFilePath);
    if (!mainCppFile.existsSync()) {
      throw _PackageRenameErrors.windowsMainCppNotFound;
    }

    final mainCppString = mainCppFile.readAsStringSync();
    final newAppTitleMainCppString = mainCppString.replaceAll(
      RegExp(r'window.CreateAndShow\(L"(.*?)"'),
      'window.CreateAndShow(L"$appName"',
    );

    mainCppFile.writeAsStringSync(newAppTitleMainCppString);

    _logger.i('Windows app title set to: `$appName` (main.cpp)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows App Title change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows App Title change failed!!!');
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
          RegExp(r'VALUE "FileDescription", "(.*?)"'),
          'VALUE "FileDescription", "$appName"',
        )
        .replaceAll(
          RegExp(r'VALUE "InternalName", "(.*?)"'),
          'VALUE "InternalName", "$appName"',
        )
        .replaceAll(
          RegExp(r'VALUE "OriginalFilename", "(.*?).exe"'),
          'VALUE "OriginalFilename", "$appName.exe"',
        )
        .replaceAll(
          RegExp(r'VALUE "ProductName", "(.*?)"'),
          'VALUE "ProductName", "$appName"',
        );

    runnerFile.writeAsStringSync(newProductDetailsRunnerString);

    _logger.i('Windows file description set to: `$appName` (Runner.rc)');
    _logger.i('Windows internal name set to: `$appName` (Runner.rc)');
    _logger.i('Windows original filename set to: `$appName.exe` (Runner.rc)');
    _logger.i('Windows product name set to: `$appName` (Runner.rc)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Windows Product Details change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Windows Product Details change failed!!!');
  }
}
