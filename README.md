# Package Rename

A Blazingly Fast way to configure your Bleeding Edge flutter project to be production ready.

[![pub package][package_svg]][package]
[![GitHub][license_svg]](LICENSE)

[![GitHub issues][issues_svg]][issues]
[![GitHub issues closed][issues_closed_svg]][issues_closed]

<hr />

Package Rename handles changing **_33 fields_** across **_17 files_** on **_6 platforms_** so you can focus on your awesome project.

For more info see [list of changed fields](CHANGED_FIELDS.md)

## Getting started

#### Add to Dependencies

```yaml
dev_dependencies:
  package_rename: ^1.5.3
```

#### Create configuration

You can create configurations by adding `package_rename_config` key in:

1. Root `pubspec.yaml` file
1. `package_rename_config.yaml` file at root of your project or a custom folder in the project

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

Execute the command as per your config location:

if config file exists in either pubspec.yaml or root path:

```bash
dart run package_rename
```

OR

if config file exists in a custom folder:

```bash
dart run package_rename --path="path/to/package_rename_config.yaml"
```

or

```bash
dart run package_rename -p "path/to/package_rename_config.yaml"
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

or

```bash
dart run package_rename -f flavour_name
```

With custom config file location:

```bash
dart run package_rename --flavour=flavour_name --path="path/to/package_rename_config.yaml"
```

## Known Issues

### iOS and macOS issues with `PRODUCT_BUNDLE_IDENTIFIER`:

The `PRODUCT_BUNDLE_IDENTIFIER`'s in **ios/Runner.xcodeproj/project.pbxproj** and **macos/Runner.xcodeproj/project.pbxproj** have different values for different targets. Like, in my case:

**DEFAULT**

- `rocks.outdatedguy.packageRenameExample`
- `rocks.outdatedguy.packageRenameExample.RunnerTests`

**EXTENSIONS**

- `rocks.outdatedguy.packageRenameExample.Share-Extension`
- `rocks.outdatedguy.packageRenameExample.NotificationServiceExtension`
- blah blah blah...

Hence, to properly change the `PRODUCT_BUNDLE_IDENTIFIER` without removing the **Extension** name, make sure all `PRODUCT_BUNDLE_IDENTIFIER`'s except the **DEFAULT** ones are enclosed in double quotes (`""`).

```diff
- PRODUCT_BUNDLE_IDENTIFIER = rocks.outdatedguy.packageRenameExample.Share-Extension;
+ PRODUCT_BUNDLE_IDENTIFIER = "rocks.outdatedguy.packageRenameExample.Share-Extension";
```

## And that's it! 🎉

Now you can deploy your production ready app to change the _WORLD!_

### If you liked the package, then please give it a [Like 👍🏼][package] and [Star ⭐][repository]

<!-- Badges URLs -->

[package_svg]: https://img.shields.io/pub/v/package_rename.svg?color=blueviolet
[license_svg]: https://img.shields.io/github/license/OutdatedGuy/package_rename.svg?color=purple
[issues_svg]: https://img.shields.io/github/issues/OutdatedGuy/package_rename.svg
[issues_closed_svg]: https://img.shields.io/github/issues-closed/OutdatedGuy/package_rename.svg?color=green

<!-- Links -->

[package]: https://pub.dev/packages/package_rename
[repository]: https://github.com/OutdatedGuy/cached_video_player_plus
[issues]: https://github.com/OutdatedGuy/package_rename/issues
[issues_closed]: https://github.com/OutdatedGuy/package_rename/issues?q=is%3Aissue+is%3Aclosed
