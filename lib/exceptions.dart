part of package_rename;

class _PackageRenameException implements Exception {
  final String message;
  final int code;
  const _PackageRenameException(this.message, this.code);
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
}
