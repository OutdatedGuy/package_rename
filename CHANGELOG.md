## 1.3.2

- fix: system given path mis-handled on windows in [91d8b7c](https://github.com/OutdatedGuy/package_rename/commit/91d8b7c10f7aec8f9aed86e721840d56194c5bb4)

## 1.3.1

- fix(android): package id in single quotes don't change in [e136511](https://github.com/OutdatedGuy/package_rename/commit/e1365110125d4f6cf6a9aadae80dc2b14e7a6423)
- fix(macos): spaces not supported in .app name in [afc789e](https://github.com/OutdatedGuy/package_rename/commit/afc789e54f8764a24cc6ca796018661ec148e03b)

## 1.3.0

- feat: Support new windows code from Flutter 3.7 onwards. Thanks [@obemu](https://github.com/obemu) for [ac23e98](https://github.com/OutdatedGuy/package_rename/commit/ac23e98444524fe29fa49e4695f14efafc2d940c)
- feat: support flutter 3.10 template code in [6f1a4e0](https://github.com/OutdatedGuy/package_rename/commit/6f1a4e0b8673b6b5d1b6bf8f5b6d7fca6a531fa3)
- docs: updated package docs in [b5e6315](https://github.com/OutdatedGuy/package_rename/commit/b5e6315cc142a595cfc679a3a88fe420d563031e)
- chore: updated package dependencies and configurations in [b7aa13c](https://github.com/OutdatedGuy/package_rename/commit/b7aa13cadde4106e7b30e016c66ce9428b0ad280), [48abd67](https://github.com/OutdatedGuy/package_rename/commit/48abd6765ebf3ed6a499b839f714ed8f0368df9f) and [8b2505d](https://github.com/OutdatedGuy/package_rename/commit/8b2505d8ce88df5ad8b14147874f538e517a383b)
- ### feat!: added `dart run package_rename` command and _Deprecated_ `flutter pub run package_rename:set` command in [ea2f950](https://github.com/OutdatedGuy/package_rename/commit/ea2f9505a28eae80d759b42cf1a3c6e5bd03d112)

## 1.2.0

- feat: added support to choose flavour for configuration in [1be85de](https://github.com/OutdatedGuy/package_rename/commit/1be85deb2c47936b1c999b52e700dfff1d74bdf8)

## 1.1.0

- chore: migrated to Flutter 3.7 in [6ccb378](https://github.com/OutdatedGuy/package_rename/commit/6ccb378a0e721853ed8045f658af1cdf9c7ae53b)
- chore: updated dependencies to latest in [8d59c57](https://github.com/OutdatedGuy/package_rename/commit/8d59c576fae1ba41b4545e304fbf945f10d80412)
- feat: added field `override_old_package` to move existing MainActivity code to new folder structure in [d664dbc](https://github.com/OutdatedGuy/package_rename/commit/d664dbcd14c483afa897f082907ce401bf9791a4)
  - This can be used to move existing code instead of creating new default template
  - Using this field will delete the old folder structure

## 1.0.0+1

- DOCS: show closed issue count instead of pr count (readme)

## 1.0.0

- First Public Release
