part of package_rename;

// File Names
const _packageRenameConfigFileName = 'package_rename_config.yaml';
const _pubspecFileName = 'pubspec.yaml';
const _androidManifestFileName = 'AndroidManifest.xml';

// Keys
const _configKey = 'package_rename_config';
const _appNameKey = 'app_name';

// Directory Paths
const _androidSrcDirPath = 'android/app/src';

// Directory Names
const _androidMainDirName = 'main';

// File Paths
const _androidMainManifestFilePath =
    '$_androidSrcDirPath/$_androidMainDirName/$_androidManifestFileName';

// Decorations
const _outputLength = 80;
final _minorStepDoneLineBreak = '┈' * _outputLength;
final _majorStepDoneLineBreak = '━' * _outputLength;
