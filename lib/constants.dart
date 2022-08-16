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

// ? Web
const _indexHtmlFileName = 'index.html';
const _manifestJsonFileName = 'manifest.json';

// ? Linux
const _myApplicationFileName = 'my_application.cc';

// ? Windows
const _mainCppFileName = 'main.cpp';
const _runnerFileName = 'Runner.rc';

// ? Linux & Windows
const _cMakeListsFileName = 'CMakeLists.txt';

// ? MacOS
const _appInfoFileName = 'AppInfo.xcconfig';

// ! Keys
const _configKey = 'package_rename_config';
const _appNameKey = 'app_name';
const _packageNameKey = 'package_name';
const _bundleNameKey = 'bundle_name';
const _descriptionKey = 'description';
const _organizationKey = 'organization';
const _copyrightKey = 'copyright_notice';

// ! Directory Paths
// ? Android
const _androidAppDirPath = 'android/app';
const _androidSrcDirPath = '$_androidAppDirPath/src';

// ? iOS
const _iosDirPath = 'ios';
const _iosRunnerDirPath = '$_iosDirPath/Runner';
const _iosProjectDirPath = '$_iosDirPath/Runner.xcodeproj';

// ? Web
const _webDirPath = 'web';

// ? Linux
const _linuxDirPath = 'linux';

// ? Windows
const _windowsDirPath = 'windows';
const _windowsRunnerDirPath = '$_windowsDirPath/runner';

// ? MacOS
const _macOSDirPath = 'macos';
const _macOSConfigDirPath = '$_macOSDirPath/Runner/Configs';

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

// ? Web
const _webIndexFilePath = '$_webDirPath/$_indexHtmlFileName';
const _webManifestFilePath = '$_webDirPath/$_manifestJsonFileName';

// ? Linux
const _linuxCMakeListsFilePath = '$_linuxDirPath/$_cMakeListsFileName';
const _linuxMyApplicationFilePath = '$_linuxDirPath/$_myApplicationFileName';

// ? Windows
const _windowsCMakeListsFilePath = '$_windowsDirPath/$_cMakeListsFileName';
const _windowsMainCppFilePath = '$_windowsRunnerDirPath/$_mainCppFileName';
const _windowsRunnerFilePath = '$_windowsRunnerDirPath/$_runnerFileName';

// ? MacOS
const _macOSAppInfoFilePath = '$_macOSConfigDirPath/$_appInfoFileName';

// ! Decorations
const _outputLength = 100;
final _minorStepDoneLineBreak = '┈' * _outputLength;
final _majorStepDoneLineBreak = '━' * _outputLength;
