part of package_rename;

class _PackageRenameException implements Exception {
  const _PackageRenameException(this.message, this.code);

  final String message;
  final int code;
}

class _PackageRenameErrors {
  static const filesNotFound = _PackageRenameException(
    _filesNotFoundMessage,
    1,
  );

  static const configNotFound = _PackageRenameException(
    _configNotFoundMessage,
    2,
  );

  static const invalidConfig = _PackageRenameException(
    _invalidConfigMessage,
    3,
  );

  static const invalidAndroidConfig = _PackageRenameException(
    _invalidAndroidConfigMessage,
    4,
  );

  static const invalidAppName = _PackageRenameException(
    _invalidAppNameMessage,
    5,
  );

  static const androidMainManifestNotFound = _PackageRenameException(
    _androidMainManifestNotFoundMessage,
    6,
  );

  static const invalidPackageName = _PackageRenameException(
    _invalidPackageNameMessage,
    7,
  );

  static const invalidIOSConfig = _PackageRenameException(
    _invalidIOSConfigMessage,
    8,
  );

  static const iosInfoPlistNotFound = _PackageRenameException(
    _iosInfoPlistNotFoundMessage,
    9,
  );

  static const invalidBundleName = _PackageRenameException(
    _invalidBundleNameMessage,
    10,
  );

  static const iosProjectFileNotFound = _PackageRenameException(
    _iosProjectFileNotFoundMessage,
    11,
  );

  static const invalidWebConfig = _PackageRenameException(
    _invalidWebConfigMessage,
    12,
  );

  static const webIndexNotFound = _PackageRenameException(
    _webIndexNotFoundMessage,
    13,
  );

  static const invalidDescription = _PackageRenameException(
    _invalidDescriptionMessage,
    14,
  );

  static const invalidLinuxConfig = _PackageRenameException(
    _invalidLinuxConfigMessage,
    15,
  );

  static const linuxCMakeListsNotFound = _PackageRenameException(
    _linuxCMakeListsNotFoundMessage,
    16,
  );

  static const linuxMyApplicationNotFound = _PackageRenameException(
    _linuxMyApplicationNotFoundMessage,
    17,
  );

  static const invalidWindowsConfig = _PackageRenameException(
    _invalidWindowsConfigMessage,
    18,
  );

  static const windowsCMakeListsNotFound = _PackageRenameException(
    _windowsCMakeListsNotFoundMessage,
    19,
  );

  static const windowsMainCppNotFound = _PackageRenameException(
    _windowsMainCppNotFoundMessage,
    20,
  );

  static const windowsRunnerNotFound = _PackageRenameException(
    _windowsRunnerNotFoundMessage,
    21,
  );

  static const invalidOrganization = _PackageRenameException(
    _invalidOrganizationMessage,
    22,
  );

  static const invalidCopyrightNotice = _PackageRenameException(
    _invalidCopyrightNoticeMessage,
    23,
  );

  static const invalidMacOSConfig = _PackageRenameException(
    _invalidMacOSConfigMessage,
    24,
  );

  static const macOSAppInfoNotFound = _PackageRenameException(
    _macOSAppInfoNotFoundMessage,
    25,
  );

  static const invalidLanguageType = _PackageRenameException(
    _invalidLanguageTypeMessage,
    26,
  );

  static const invalidAndroidLanguageValue = _PackageRenameException(
    _invalidAndroidLangValueMessage,
    27,
  );

  static const invalidExecutableName = _PackageRenameException(
    _invalidExecutableNameMessage,
    28,
  );

  static const invalidExecutableNameValue = _PackageRenameException(
    _invalidExecutableNameValueMessage,
    29,
  );

  static const androidOldDirectoryNotFound = _PackageRenameException(
    _androidOldDirectoryNotFoundMessage,
    30,
  );

  static _PackageRenameException flavourNotFound(String flavor) {
    final flavorNotFoundMessage = _configNotFoundMessage
        .replaceFirst('package_rename_config', 'package_rename_config-$flavor')
        .replaceRange(1, 1, '═' * (flavor.length + 1))
        .replaceRange(
          _configNotFoundMessage.length - 2,
          _configNotFoundMessage.length - 2,
          '═' * (flavor.length + 1),
        );

    return _PackageRenameException(flavorNotFoundMessage, 31);
  }

  static const macOSRunnerXCSchemeNotFound = _PackageRenameException(
    _macOSRunnerXCSchemeNotFoundMessage,
    32,
  );

  static const macOSProjectFileNotFound = _PackageRenameException(
    _macOSProjectFileNotFoundMessage,
    33,
  );
}
