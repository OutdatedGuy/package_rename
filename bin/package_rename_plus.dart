import 'package:package_rename_plus/package_rename_plus.dart'
    as package_rename_plus;

/// Command line entry point to configure package details.
///
/// Execute following command to set package details:
/// ```bash
/// dart run package_rename_plus
/// ```
void main(List<String> arguments) => package_rename_plus.set(arguments);
