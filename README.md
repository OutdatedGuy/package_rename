# Package Rename

A Blazingly Fast way to configure your Bleeding Edge flutter project to be production ready.

[![pub package][package_svg]](https://pub.dev/packages/package_rename)
[![GitHub][license_svg]](LICENSE)
[![style: very good analysis][lints_svg]](https://pub.dev/packages/very_good_analysis)

[![GitHub issues][issues_svg]](https://github.com/OutdatedGuy/package_rename/issues)
[![GitHub issues closed][issues_closed_svg]](https://github.com/OutdatedGuy/package_rename/issues?q=is%3Aissue+is%3Aclosed)

<hr />

Package Rename handles changing **_33 fields_** across **_17 files_** on **_6 platforms_** so you can focus on your awesome project.

For more info see [list of changed fields](CHANGED_FIELDS.md)

## Getting started

#### Add to Dependencies

```yaml
dev_dependencies:
  package_rename: ^1.3.2
```

#### Create configuration

You can create configurations by adding `package_rename_config` key in:

1. Root `pubspec.yaml` file
1. `package_rename_config.yaml` file at root of your project

## Usage

#### Adding Platform Specific Configurations

```yaml
package_rename_config:
  android:
    app_name: # (String) The display name of the android app
    package_name: # (String) The package name of the android app
    override_old_package: # (Optional) (String) Use this to delete the old folder structure of MainActivity or to use the existing code with the new package name
    lang: # (Optional) (String) The android development language {kotlin(default) or java}

  ios:
    app_name: # (String) The display name of the ios app
    bundle_name: # (String) The bundle name of the ios app
    package_name: # (String) The product bundle identifier of the ios app

  linux:
    app_name: # (String) The window title of the linux app
    package_name: # (String) The application id of the linux app
    exe_name: # (String) The executable name (binary name) of the linux app

  macos:
    app_name: # (String) The product name of the macos app
    package_name: # (String) The product bundle identifier of the macos app
    copyright_notice: # (String) The product copyright of the macos app

  web:
    app_name: # (String) The title and display name of the web app and PWA
    description: # (String) The description of the web app and PWA

  windows:
    app_name: # (String) The window title & software name of the windows app
    organization: # (String) The organization name (company name) of the windows app
    copyright_notice: # (String) The legal copyright of the windows app
    exe_name: # (String) The executable name (binary name) of the windows app
```

> For full example click [here](example/example.md#default-configuration)

#### Running Package Rename

Execute the follow command at the root of your project:

```bash
dart run package_rename
```

## Flavour Support

Package Rename supports flavours. You can add flavour specific configurations by adding `flavour_name` in configuration key.

```yaml
package_rename_config-flavour_name:
  # ...
```

> For full example click [here](example/example.md#flavour-configuration)

And then run the following command:

```bash
dart run package_rename --flavour=flavour_name
```

## And that's it! 🎉

Now you can deploy your production ready app to change the _WORLD!_

<!-- Badges URLs -->

[package_svg]: https://img.shields.io/pub/v/package_rename.svg?color=blueviolet
[license_svg]: https://img.shields.io/github/license/OutdatedGuy/package_rename.svg?color=purple
[lints_svg]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[issues_svg]: https://img.shields.io/github/issues/OutdatedGuy/package_rename.svg
[issues_closed_svg]: https://img.shields.io/github/issues-closed/OutdatedGuy/package_rename.svg?color=green
