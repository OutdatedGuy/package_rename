import 'package:package_rename/package_rename.dart' as package_rename;

/// Command line entry point to configure package details.
///
/// Execute following command to set package details:
/// ```bash
/// dart run package_rename
/// ```
void main(List<String> arguments) => package_rename.set(arguments);
