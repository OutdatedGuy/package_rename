/// A *blazingly fast* way to configure your project to be production ready.
///
/// You can customize configurations it in the following way:
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
// ignore_for_file: avoid_print

library package_rename;

import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:args/args.dart';
import 'package:html/parser.dart' as html;
import 'package:yaml/yaml.dart' as yaml;

part 'src/constants.dart';
part 'src/exceptions.dart';
part 'src/messages.dart';
part 'src/platforms/android.dart';
part 'src/platforms/ios.dart';
part 'src/platforms/linux.dart';
part 'src/platforms/macos.dart';
part 'src/platforms/web.dart';
part 'src/platforms/windows.dart';

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
    print(_majorTaskDoneLine);

    if (!_configFileExists()) throw _PackageRenameErrors.filesNotFound;

    // Create args parser to get flavour flag and its value
    final parser = ArgParser()
      ..addOption(
        'path',
        abbr: 'p',
        help: 'The path for the config file',
      )
      ..addOption(
        'flavour',
        abbr: 'f',
        help: 'The flavour of the configuration to be used.',
        aliases: ['flavor'],
      )
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Prints out available command usages',
      );
    final results = parser.parse(args);

    if (results.wasParsed('help')) {
      print(_packageRenameCommands);
      print(parser.usage);
      exit(0);
    }
    final flavour = results['flavour'] as String?;
    final path = results['path'] as String?;

    final config = _getConfig(flavour: flavour, configFile: path);

    _setAndroidConfigurations(config['android']);
    _setIOSConfigurations(config['ios']);
    _setLinuxConfigurations(config['linux']);
    _setMacOSConfigurations(config['macos']);
    _setWebConfigurations(config['web']);
    _setWindowsConfigurations(config['windows']);

    print(_successMessage);
  } on _PackageRenameException catch (e) {
    print(e.message);
    exit(e.code);
  } catch (e) {
    print(e);
    exit(255);
  }
}

bool _configFileExists() {
  final configFile = File(_packageRenameConfigFileName);
  final pubspecFile = File(_pubspecFileName);
  return configFile.existsSync() || pubspecFile.existsSync();
}

Map<String, dynamic> _getConfig({
  required String? flavour,
  String? configFile,
}) {
  File yamlFile;

  if (configFile != null) {
    if (File(configFile).existsSync()) {
      _checkConfigContent(configFile);
      yamlFile = File(configFile);
    } else {
      throw _PackageRenameErrors.filesNotFound;
    }
  } else if (File(_packageRenameConfigFileName).existsSync()) {
    _checkConfigContent(_packageRenameConfigFileName);
    yamlFile = File(_packageRenameConfigFileName);
  } else {
    yamlFile = File(_pubspecFileName);
  }

  final yamlString = yamlFile.readAsStringSync();
  final parsedYaml = yaml.loadYaml(yamlString) as Map;

  final rawConfig =
      parsedYaml[_configKey + (flavour != null ? '-$flavour' : '')];
  if (rawConfig == null) {
    throw flavour == null
        ? _PackageRenameErrors.configNotFound
        : _PackageRenameErrors.flavourNotFound(flavour);
  } else if (rawConfig is! Map) {
    throw _PackageRenameErrors.invalidConfig;
  }

  return Map<String, dynamic>.from(rawConfig);
}

void _checkConfigContent(String yamlFile) {
  final fileContent = File(yamlFile).readAsStringSync();

  if (fileContent.isEmpty) {
    throw _PackageRenameErrors.filesNotFound;
  }

  if (yaml.loadYaml(fileContent) == null) {
    throw _PackageRenameErrors.configNotFound;
  }
}
