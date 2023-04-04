## Default Configuration

```yaml
package_rename_config:
  android:
    app_name: Package Rename Demo
    package_name: rocks.outdatedguy.packagerenamedemo
    override_old_package: com.example.example
    lang: kotlin

  ios:
    app_name: Package Rename Demo
    bundle_name: renamedemo
    package_name: rocks.outdatedguy.packagerenamedemo

  web:
    app_name: Package Rename Demo
    description: Package to change project configurations.

  linux:
    app_name: Package Rename Demo
    package_name: rocks.outdatedguy.packagerenamedemo
    exe_name: renamedemo-linux-x64

  windows:
    app_name: Package Rename Demo
    organization: OutdatedGuy
    copyright_notice: Copyright ©️ 2022 OutdatedGuy. All rights reserved.
    exe_name: renamedemo-win32

  macos:
    app_name: Package Rename Demo
    package_name: rocks.outdatedguy.packagerenamedemo
    copyright_notice: Copyright ©️ 2022 OutdatedGuy. All rights reserved.
```

## Flavour Configuration

```yaml
package_rename_config-development:
  android:
    app_name: Development Package Rename Demo
    package_name: rocks.outdatedguy.packagerenamedemo.dev
    override_old_package: com.example.example
    lang: kotlin

  ios:
    app_name: Development Package Rename Demo
    bundle_name: renamedemo
    package_name: rocks.outdatedguy.packagerenamedemo.dev

  web:
    app_name: Development Package Rename Demo
    description: Package to change project configurations.

  linux:
    app_name: Development Package Rename Demo
    package_name: rocks.outdatedguy.packagerenamedemo.dev
    exe_name: dev-renamedemo-linux-x64

  windows:
    app_name: Development Package Rename Demo
    organization: OutdatedGuy

  macos:
    app_name: Development Package Rename Demo
    package_name: rocks.outdatedguy.packagerenamedemo.dev
```

<hr>

```yaml
package_rename_config-production:
  android:
    app_name: Production Package Rename Demo
    package_name: rocks.outdatedguy.packagerenamedemo.prod
    override_old_package: com.example.example
    lang: kotlin

  ios:
    app_name: Production Package Rename Demo
    bundle_name: renamedemo
    package_name: rocks.outdatedguy.packagerenamedemo.prod

  web:
    app_name: Production Package Rename Demo
    description: Package to change project configurations.

  linux:
    app_name: Production Package Rename Demo
    package_name: rocks.outdatedguy.packagerenamedemo.prod
    exe_name: prod-renamedemo-linux-x64

  windows:
    app_name: Production Package Rename Demo
    organization: OutdatedGuy

  macos:
    app_name: Production Package Rename Demo
    package_name: rocks.outdatedguy.packagerenamedemo.prod
```
