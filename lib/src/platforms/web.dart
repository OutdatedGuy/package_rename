part of '../../package_rename_plus.dart';

void _setWebConfigurations(dynamic webConfig) {
  try {
    if (webConfig == null) return;
    if (webConfig is! Map) throw _PackageRenameErrors.invalidWebConfig;

    final webConfigMap = Map<String, dynamic>.from(webConfig);

    _setWebTitle(webConfigMap[_appNameKey]);
    _setPWAAppName(webConfigMap[_appNameKey]);
    _setWebDescription(webConfigMap[_descriptionKey]);
    _setPWADescription(webConfigMap[_descriptionKey]);
  } on _PackageRenameException catch (e) {
    developer.log('${e.message}ERR Code: ${e.code}');
    developer.log('Skipping Web configuration!!!');
  } catch (e) {
    developer.log(e.toString());
    developer.log('ERR Code: 255');
    developer.log('Skipping Web configuration!!!');
  } finally {
    if (webConfig != null) developer.log(_majorTaskDoneLine);
  }
}

void _setWebTitle(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    final webIndexFile = File(_webIndexFilePath);
    if (!webIndexFile.existsSync()) {
      throw _PackageRenameErrors.webIndexNotFound;
    }

    final webIndexString = webIndexFile.readAsStringSync();
    final webIndexDocument = html.parse(webIndexString);
    webIndexDocument.querySelector('title')?.text = appName;
    webIndexDocument
        .querySelector('meta[name="apple-mobile-web-app-title"]')
        ?.attributes['content'] = appName;

    webIndexFile.writeAsStringSync('${webIndexDocument.outerHtml}\n');

    developer.log('Web title set to: `$appName` (index.html)');
  } on _PackageRenameException catch (e) {
    developer.log('${e.message}ERR Code: ${e.code}');
    developer.log('Web Title change failed!!!');
  } catch (e) {
    developer.log(e.toString());
    developer.log('ERR Code: 255');
    developer.log('Web Title change failed!!!');
  } finally {
    if (appName != null) developer.log(_minorTaskDoneLine);
  }
}

void _setPWAAppName(dynamic appName) {
  try {
    if (appName == null) return;
    if (appName is! String) throw _PackageRenameErrors.invalidAppName;

    final webManifestFile = File(_webManifestFilePath);
    if (!webManifestFile.existsSync()) {
      developer.log('Web manifest.json not found!!!');
      return;
    }

    final webManifestString = webManifestFile.readAsStringSync();
    final webManifestJson = json.decode(
      webManifestString,
    ) as Map<String, dynamic>;

    webManifestJson['name'] = appName;
    webManifestJson['short_name'] = appName;

    const encoder = JsonEncoder.withIndent('    ');
    webManifestFile.writeAsStringSync('${encoder.convert(webManifestJson)}\n');

    developer.log('PWA name set to: `$appName` (manifest.json)');
  } on _PackageRenameException catch (e) {
    developer.log('${e.message}ERR Code: ${e.code}');
    developer.log('PWA Name change failed!!!');
  } catch (e) {
    developer.log(e.toString());
    developer.log('ERR Code: 255');
    developer.log('PWA Name change failed!!!');
  } finally {
    if (appName != null) developer.log(_minorTaskDoneLine);
  }
}

void _setWebDescription(dynamic description) {
  try {
    if (description == null) return;
    if (description is! String) throw _PackageRenameErrors.invalidDescription;

    final webIndexFile = File(_webIndexFilePath);
    if (!webIndexFile.existsSync()) {
      throw _PackageRenameErrors.webIndexNotFound;
    }

    final webIndexString = webIndexFile.readAsStringSync();
    final webIndexDocument = html.parse(webIndexString);
    webIndexDocument
        .querySelector('meta[name="description"]')
        ?.attributes['content'] = description;

    webIndexFile.writeAsStringSync('${webIndexDocument.outerHtml}\n');

    developer.log('Web description set to: `$description` (index.html)');
  } on _PackageRenameException catch (e) {
    developer.log('${e.message}ERR Code: ${e.code}');
    developer.log('Web Description change failed!!!');
  } catch (e) {
    developer.log(e.toString());
    developer.log('ERR Code: 255');
    developer.log('Web Description change failed!!!');
  } finally {
    if (description != null) developer.log(_minorTaskDoneLine);
  }
}

void _setPWADescription(dynamic description) {
  try {
    if (description == null) return;
    if (description is! String) throw _PackageRenameErrors.invalidDescription;

    final webManifestFile = File(_webManifestFilePath);
    if (!webManifestFile.existsSync()) {
      developer.log('Web manifest.json not found!!!');
      return;
    }

    final webManifestString = webManifestFile.readAsStringSync();
    final webManifestJson = json.decode(
      webManifestString,
    ) as Map<String, dynamic>;

    webManifestJson['description'] = description;

    const encoder = JsonEncoder.withIndent('    ');
    webManifestFile.writeAsStringSync('${encoder.convert(webManifestJson)}\n');

    developer.log('PWA description set to: `$description` (manifest.json)');
  } on _PackageRenameException catch (e) {
    developer.log('${e.message}ERR Code: ${e.code}');
    developer.log('PWA Description change failed!!!');
  } catch (e) {
    developer.log(e.toString());
    developer.log('ERR Code: 255');
    developer.log('PWA Description change failed!!!');
  } finally {
    if (description != null) developer.log(_minorTaskDoneLine);
  }
}
