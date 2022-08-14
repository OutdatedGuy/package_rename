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
}
