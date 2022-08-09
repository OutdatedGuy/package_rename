part of package_rename;

class _InvalidConfigException implements Exception {
  final String message;
  final int code;
  _InvalidConfigException(this.message, this.code);
}
