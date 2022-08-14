library package_rename;

import 'package:logger/logger.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart' as yaml;

part 'constants.dart';
part 'exceptions.dart';
part 'messages.dart';

part 'platforms/android.dart';
part 'platforms/ios.dart';

final _logger = Logger(
  filter: ProductionFilter(),
  printer: PrettyPrinter(
    lineLength: 80,
    methodCount: 0,
    noBoxingByDefault: true,
    printEmojis: false,
  ),
);

/// Starts setting build configurations for the flutter application according
/// to given configuration.
///
/// Configuration is a map of build configurations and their values.
///
/// You can specify it in the following way:
/// 1. `package_rename_config` key in `pubspec.yaml`:
/// ```yaml
/// package_rename_config:
///   ...
/// ```
///
/// 2. `package_rename_config.yaml` file at the root of the project:
/// ```yaml
/// package_rename_config:
///   ...
/// ```
void set(List<String> args) {
  try {
    if (!_configFileExists()) throw _PackageRenameErrors.filesNotFound;

    final config = _getConfig();
    if (config == null) throw _PackageRenameErrors.configNotFound;

    _setAndroidConfigurations(config['android']);
    _setIOSConfigurations(config['ios']);

    _logger.i(_successMessage);
  } on _PackageRenameException catch (e) {
    _logger.wtf(e.message);
    exit(e.code);
  } catch (e) {
    _logger.wtf(e.toString());
    exit(255);
  } finally {
    _logger.close();
  }
}

bool _configFileExists() {
  final configFile = File(_packageRenameConfigFileName);
  final pubspecFile = File(_pubspecFileName);
  return configFile.existsSync() || pubspecFile.existsSync();
}

Map<String, dynamic>? _getConfig() {
  final yamlFile = File(_packageRenameConfigFileName).existsSync()
      ? File(_packageRenameConfigFileName)
      : File(_pubspecFileName);

  final yamlString = yamlFile.readAsStringSync();
  final parsedYaml = yaml.loadYaml(yamlString) as Map;

  if (parsedYaml[_configKey] == null) {
    return null;
  } else if (parsedYaml[_configKey] is! Map) {
    throw _PackageRenameErrors.invalidConfig;
  }

  final configMap = Map<String, dynamic>.from(
    parsedYaml[_configKey] as Map,
  );
  return configMap;
}
