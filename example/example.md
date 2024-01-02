## Default Configuration

```yaml
package_rename_config:
  android:
    app_name: Package Rename Demo
    package_name: com.solusibejo.new
    override_old_package: com.example.example
    lang: kotlin

  ios:
    app_name: Package Rename Demo
    bundle_name: renamedemo
    override_old_package: com.example.example
    package_name: com.solusibejo.new

  web:
    app_name: Package Rename Demo
    description: Package to change project configurations.

  linux:
    app_name: Package Rename Demo
    package_name: com.solusibejo.new
    exe_name: renamedemo-linux-x64

  windows:
    app_name: Package Rename Demo
    organization: SolusiBejo
    copyright_notice: Copyright ©️ 2024 SolusiBejo. All rights reserved.
    exe_name: renamedemo-win32

  macos:
    app_name: Package Rename Demo
    package_name: com.solusibejo.new
    copyright_notice: Copyright ©️ 2024 SolusiBejo. All rights reserved.
```

## Flavour Configuration

```yaml
package_rename_config-development:
  android:
    app_name: Development Package Rename Demo
    package_name: com.solusibejo.new.dev
    override_old_package: com.example.example
    lang: kotlin

  ios:
    app_name: Development Package Rename Demo
    bundle_name: renamedemo
    override_old_package: com.example.example
    package_name: com.solusibejo.new.dev

  web:
    app_name: Development Package Rename Demo
    description: Package to change project configurations.

  linux:
    app_name: Development Package Rename Demo
    package_name: com.solusibejo.new.dev
    exe_name: dev-renamedemo-linux-x64

  windows:
    app_name: Development Package Rename Demo
    organization: SolusiBejo

  macos:
    app_name: Development Package Rename Demo
    package_name: com.solusibejo.new.dev
```

<hr>

```yaml
package_rename_config-production:
  android:
    app_name: Production Package Rename Demo
    package_name: com.solusibejo.new.prod
    override_old_package: com.example.example
    lang: kotlin

  ios:
    app_name: Production Package Rename Demo
    bundle_name: renamedemo
    override_old_package: com.example.example
    package_name: com.solusibejo.new.prod

  web:
    app_name: Production Package Rename Demo
    description: Package to change project configurations.

  linux:
    app_name: Production Package Rename Demo
    package_name: com.solusibejo.new.prod
    exe_name: prod-renamedemo-linux-x64

  windows:
    app_name: Production Package Rename Demo
    organization: SolusiBejo

  macos:
    app_name: Production Package Rename Demo
    package_name: com.solusibejo.new.prod
```
