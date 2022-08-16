# Symbol Meanings

- ❌ = Don't know if this should be renamed
- ✅ = This should be renamed
- ✅✅ = Renaming this is implemented

## Package Name

#### Android

- `android\app\build.gradle` > android > defaultConfig > applicationId ✅✅
- `android\app\src\debug\AndroidManifest.xml` > manifest > package ✅✅
- `android\app\src\main\AndroidManifest.xml` > manifest > package ✅✅
- `android\app\src\profile\AndroidManifest.xml` > manifest > package ✅✅

#### iOS

- `ios\Runner.xcodeproj\project.pbxproj` > PRODUCT_BUNDLE_IDENTIFIER \* 3 ✅✅

#### Linux

- `linux\CMakeLists.txt` > APPLICATION_ID ✅✅

#### macOS

- `macos\Runner\Configs\AppInfo.xcconfig` > PRODUCT_BUNDLE_IDENTIFIER ✅✅

## Organization

#### Windows

- `windows\runner\Runner.rc` > CompanyName ✅✅

## CopyRight Notice

#### macOS

- `macos\Runner\Configs\AppInfo.xcconfig` > PRODUCT_COPYRIGHT ✅✅

#### Windows

- `windows\runner\Runner.rc` > LegalCopyright ✅✅

## App Name

#### Android

- `android\app\src\main\AndroidManifest.xml` > manifest > application > android:label ✅✅

#### iOS

- `ios\Runner\Info.plist` > CFBundleDisplayName ✅✅
- `ios\Runner\Info.plist` > CFBundleName (max 15 chars, shows warning) ✅✅

#### Linux

- `linux\CMakeLists.txt` > BINARY_NAME ✅✅
- `linux\my_application.cc` > gtk_header_bar_set_title ✅✅
- `linux\my_application.cc` > gtk_window_set_title ✅✅

#### macOS

- `macos\Runner\Configs\AppInfo.xcconfig` > PRODUCT_NAME ✅✅
- `macos\Runner.xcodeproj\project.pbxproj` > 33CC10ED2044A3C60003C045 \* 4 ❌
- `macos\Runner.xcodeproj\xcshareddata\xcschemes\Runner.xcscheme` > BuildableName \* 4 ❌

#### Web

- `web\index.html` > html > head > meta:apple-mobile-web-app-title ✅✅
- `web\index.html` > html > head > title ✅✅
- `web\manifest.json` > name ✅✅
- `web\manifest.json` > short_name ✅✅

#### Windows

- `windows\CMakeLists.txt` > project ❌
- `windows\CMakeLists.txt` > BINARY_NAME ✅✅
- `windows\runner\main.cpp` > CreateAndShow ✅✅
- `windows\runner\Runner.rc` > FileDescription ✅✅
- `windows\runner\Runner.rc` > InternalName ✅✅
- `windows\runner\Runner.rc` > OriginalFilename ✅✅
- `windows\runner\Runner.rc` > ProductName ✅✅

## New

#### Android

- `android\app\src\main` > lang used > New Folder Structure > MainActivity File ✅✅
