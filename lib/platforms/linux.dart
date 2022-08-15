part of package_rename;

void _setLinuxConfigurations(dynamic linuxConfig) {
  try {
    if (linuxConfig == null) return;
    if (linuxConfig is! Map) throw _PackageRenameErrors.invalidLinuxConfig;

    final linuxConfigMap = Map<String, dynamic>.from(linuxConfig);

    _setLinuxAppName(linuxConfigMap[_appNameKey]);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Skipping Linux configuration!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Skipping Linux configuration!!!');
  } finally {
    if (linuxConfig != null) _logger.i(_majorStepDoneLineBreak);
  }
}

void _setLinuxAppName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    _setCMakeListsAppName(appName);
    _setMyApplicationTitle(appName);
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Linux App Name change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Linux App Name change failed!!!');
  } finally {
    if (appName != null) _logger.i(_minorStepDoneLineBreak);
  }
}

void _setCMakeListsAppName(String appName) {
  try {
    final cmakeListsFile = File(_linuxCMakeListsFilePath);
    if (!cmakeListsFile.existsSync()) {
      throw _PackageRenameErrors.linuxCMakeListsNotFound;
    }

    final cmakeListsString = cmakeListsFile.readAsStringSync();
    final newBinaryNameCmakeListsString = cmakeListsString.replaceAll(
      RegExp(r'set\(BINARY_NAME\s+"(.*?)"\)'),
      'set(BINARY_NAME "$appName")',
    );

    cmakeListsFile.writeAsStringSync(newBinaryNameCmakeListsString);

    _logger.i('Linux binary name set to: `$appName` (CMakeLists.txt)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Linux Binary Name change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Linux Binary Name change failed!!!');
  }
}

void _setMyApplicationTitle(String appName) {
  try {
    final myAppFile = File(_linuxMyApplicationFilePath);
    if (!myAppFile.existsSync()) {
      throw _PackageRenameErrors.linuxMyApplicationNotFound;
    }

    final myAppString = myAppFile.readAsStringSync();
    final newTitleMyAppString = myAppString
        .replaceAll(
          RegExp(r'gtk_header_bar_set_title\(header_bar, "(.*?)"\)'),
          'gtk_header_bar_set_title(header_bar, "$appName")',
        )
        .replaceAll(
          RegExp(r'gtk_window_set_title\(window, "(.*?)"\)'),
          'gtk_window_set_title(window, "$appName")',
        );

    myAppFile.writeAsStringSync(newTitleMyAppString);

    _logger.i('Linux app title set to: `$appName` (my_application.cc)');
  } on _PackageRenameException catch (e) {
    _logger.e('${e.message}ERR Code: ${e.code}');
    _logger.e('Linux App Title change failed!!!');
  } catch (e) {
    _logger.w(e.toString());
    _logger.e('ERR Code: 255');
    _logger.e('Linux App Title change failed!!!');
  }
}
