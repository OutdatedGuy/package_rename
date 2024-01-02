// Binaries
import 'package_rename_plus.dart' as package_rename_plus;

/// Command line entry point to configure package details.
///
/// Execute following command to set package details:
/// ```bash
/// flutter pub run package_rename_plus:set
/// ```
void main(List<String> arguments) {
  // ignore: avoid_print
  print(
    'This command is deprecated and replaced with'
    ' "dart run package_rename_plus"',
  );
  package_rename_plus.main(arguments);
}
