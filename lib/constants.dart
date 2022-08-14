part of package_rename;

// ! File Names
// ? Root
const _packageRenameConfigFileName = 'package_rename_config.yaml';
const _pubspecFileName = 'pubspec.yaml';

// ? Android
const _androidManifestFileName = 'AndroidManifest.xml';
const _buildGradleFileName = 'build.gradle';

// ? iOS
const _infoPlistFileName = 'Info.plist';
const _projectFileName = 'project.pbxproj';

// ! Keys
const _configKey = 'package_rename_config';
const _appNameKey = 'app_name';
const _packageNameKey = 'package_name';
const _bundleNameKey = 'bundle_name';

// ! Directory Paths
// ? Android
const _androidAppDirPath = 'android/app';
const _androidSrcDirPath = '$_androidAppDirPath/src';

// ? iOS
const _iosDirPath = 'ios';
const _iosRunnerDirPath = '$_iosDirPath/Runner';
const _iosProjectDirPath = '$_iosDirPath/Runner.xcodeproj';

// ! Directory Names
// ? Android
const _androidMainDirName = 'main';
const _androidDebugDirName = 'debug';
const _androidProfileDirName = 'profile';

// ! File Paths
// ? Android
const _androidMainManifestFilePath =
    '$_androidSrcDirPath/$_androidMainDirName/$_androidManifestFileName';
const _androidDebugManifestFilePath =
    '$_androidSrcDirPath/$_androidDebugDirName/$_androidManifestFileName';
const _androidProfileManifestFilePath =
    '$_androidSrcDirPath/$_androidProfileDirName/$_androidManifestFileName';
const _androidAppLevelBuildGradleFilePath =
    '$_androidAppDirPath/$_buildGradleFileName';

// ? iOS
const _iosInfoPlistFilePath = '$_iosRunnerDirPath/$_infoPlistFileName';
const _iosProjectFilePath = '$_iosProjectDirPath/$_projectFileName';

// ! Decorations
const _outputLength = 80;
final _minorStepDoneLineBreak = '┈' * _outputLength;
final _majorStepDoneLineBreak = '━' * _outputLength;
