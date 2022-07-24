# <center>Flutter Clean Code Starter Project</center>

Welcome to the Flutter CLEAN CODE starter project. This project is highly opinionated towards best practices and uses packages and automation tools wherever possible.
___
## 1. Project Structure


The application uses CLEAN CODE folder structure with features based structure for folders.

```
.
├── assets
│   ├── images
│   └── svgs
├── gen
│   └── tsv_files
├── integration_test
│   └── features
│       └── feature_name
├── lib
│   ├── core
│   │   ├── l10n
│   │   └── widgets
│   │       ├── atoms
│   │       ├── molecules
│   │       ├── organisms
│   │       ├── pages
│   │       └── templates
│   └── features
│       └── feature_name
│           ├── data
│           │   ├── datasources
│           │   ├── models
│           │   └── repositories
│           ├── domain
│           │   ├── entitites
│           │   ├── repositories
│           │   └── usecases
│           └── presentation
│               ├── bloc
│               └── widgets
│                   ├── atoms
│                   ├── molecules
│                   ├── organisms
│                   ├── pages
│                   └── templates
├── test
│   ├── core
│   │   └── unit_tests
│   └── features
│       └── feature_name
│           ├── unit_tests
│           └── widget_tests
└── update_android_folder_files_from_here
```
___
## 2. Project Setup

There is minimal setup needed to setup the project to your liking. However, some changes are necessary.

The main changes needed are as follows:

1. Clone the repository as is using below command.
2. Rename the project root folder.
3. Create the respective platforms needed for your application.
4. Update `pubspec.yaml` file.
5. Setup Android Project configurations (OPTIONAL).

### 2.1 Clone the Repository

Clone the repository to your local directory using below command.

```bash
git clone https://github.com/Peuconomia/flutter_starter_project.git
```

### 2.2 Rename the project root folder
Now, the project will be named as `flutter_starter_project`. Rename the folder name to your personal project name in this format `flutter_[app_name]_app`. Example: `flutter_tinder_app`, `flutter_facebook_app`, `flutter_ads_app`, etc.

For current context, after this point, consider the application folder name to be renamed to `flutter_notebook_app`.

### 2.3 Create the respective platforms needed for your application.
Flutter CLI gives us access to the `flutter create` command. Use the below command to generate the project folders automatically inside the `flutter_notebook_app` folder.

```bash
flutter create . --org come.example.something --project-name app -t app --platforms ios,android,web -i swift -a kotlin
```

Example:
```bash
ariel@peuconomia:~/workspace/templates/flutter_notebook_app$ flutter create . --org come.example.something --project-name app -t app --platforms ios,android,web -i swift -a kotlin
```

This command will create the `ios`, `android` and `web` project platforms to the `flutter_notebook_app`.

Consider the two identifiers here namely `org` and `project-name`. These two make up your project's `bundle identifier` for `iOS` and `applicationId` for `Android`.

`org`: Refers to reverse domain name. Eg. `com.peuconomia` in case of `peuconomia.com` as organization domain.
`project-name`: Refers to the application package name ub case of `flutter` and part of `bundleID` and `applicationId`.

Usage: `bundleId` = `org`.`project-name`
Example: `com.peuconomia.notebook`

**CONVENTION OVER CONFIGURATION**: Consider putting `org` as reverse domain name(excluding `www`) along with app `project-name` like `com.peuconomia.notebook` and put `project-name` as `app`. Thus, making the whole `bundleId` and `applicationId` as `com.peuconomia.notebook.app`.

The final command then becomes as below:

```bash
flutter create . --org come.peuconomia.notebook --project-name app -t app --platforms ios,android,web -i swift -a kotlin
```

> **NOTE:** Check whole configuraton options for `flutter create` using `flutter create --help` command.

### 2.4 Update `pubspec.yaml` file.

Update the `name` and `description` of the `pubspec.yaml` as needed. `name` should match the `project-name` from **2.3** above.

```yaml
name: app
description: Write your flutter project description here.
...
```
___

### 2.5 Setup Android Project configurations

This extra step is only necessary if you plan to automate the android configurations including keystore integration and `(min|target|compile)SdkVersion`  update from two files mainly `keystore.properties` and `local.properties`.

#### 2.5.1 `local.properties` file setup

Add the below lines to your `local.properties` file. If the file does not exist, run the project once and it will be created. 

Location: `./android/local.properties` in your flutter project root folder.

```properties
# Add these three lines below and update the sdk versions from here only

flutter.minSdkVersion=24
flutter.targetSdkVersion=32
flutter.compileSdkVersion=33
```

> **NOTE:** DO NOT edit anything in `local.properties` except adding the above lines. Other changes will be overwritten by FLUTTER.

#### 2.5.2 `keystore.properties` file setup

Create `keystore.properties` file inside the `android` folder. Then add the below lines to your `keystore.properties` file. 

Location: `./android/keystore.properties` in your flutter project root folder.

```properties
# release keystore information
releaseStoreFile=_keystore/release.jks
releaseStorePassword=<release-pass>
releaseKeyAlias=<release-alias>
releaseKeyPassword=<release-pass>

# debug store information
debugStoreFile=_keystore/debug.jks
debugStorePassword=<debug-pass>
debugKeyAlias=<debug-alias>
debugKeyPassword=<debug-pass>
```

#### 2.5.3 Add the keystore and update `keystore.properties` file

Now, add the `debug` and `release` keystores to the `_keystore` folder and update their names to `release.jks` and `debug.jks` for release and debug keystore respectively.

Location: `./android/_keystore` in your flutter project root folder.

After that, update the following fields, namely `releaseStorePassword`, `releaseKeyAlias`,  `releaseKeyPassword`, `debugStorePassword`, `debugKeyAlias` and `debugKeyPassword`, in the `keystore.properties` file with your store information.

#### 2.5.4 Update `build.gradle` file

We need to integrate the `keystore.properties` and `local.properties` files in our android build process by updating the `android/app/build.gradle` file with our configurations.

First of all, replace the below lines with the new lines provided below.

**EXISTING CODE:**
```groovy
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new FileNotFoundException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}
```

**REPLACEMENT CODE:**
```groovy
// region - local.properties configuration
// START: local.properties configuration
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
} else {
    throw new GradleException("local.properties files is not found. Please set up the file correctly and try again.")
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

def flutterMinSdkVersion = localProperties.getProperty('flutter.minSdkVersion')
if (flutterMinSdkVersion == null) {
    flutterMinSdkVersion = '23'
}

def flutterTargetSdkVersion = localProperties.getProperty('flutter.targetSdkVersion')
if (flutterTargetSdkVersion == null) {
    flutterTargetSdkVersion = '32'
}

def flutterCompileSdkVersion = localProperties.getProperty('flutter.compileSdkVersion')
if (flutterCompileSdkVersion == null) {
    flutterCompileSdkVersion = '33'
}
// END: local.properties configuration
// endregion

// region - keystore.properties configuration
// START: keystore.properties configuration
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('keystore.properties')
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.withReader('UTF-8') { reader ->
        keystoreProperties.load(reader)
    }
} else {
    throw new GradleException("keystore.properties files is not found. Please set up the file correctly using keystore.properties.example file and try again.")
}

def releaseStoreFile = keystoreProperties.getProperty('releaseStoreFile')
def releaseStorePassword = keystoreProperties.getProperty('releaseStorePassword')
def releaseKeyAlias = keystoreProperties.getProperty('releaseKeyAlias')
def releaseKeyPassword = keystoreProperties.getProperty('releaseKeyPassword')

def debugStoreFile = keystoreProperties.getProperty('debugStoreFile')
def debugStorePassword = keystoreProperties.getProperty('debugStorePassword')
def debugKeyAlias = keystoreProperties.getProperty('debugKeyAlias')
def debugKeyPassword = keystoreProperties.getProperty('debugKeyPassword')
// END: keystore.properties configuration
// endregion
```

After adding above codes, the `keystore.properties` and `local.properties` files are both integrated to `build.gralde` file.

Now, we need to apply those changes everywhere the default config is being used.

In the `build.gradle` file, there is a `android` block that looks like below:

```groovy
...

android {


}
```

Now, inside the `android` block, add the below line or replace the existing `compileSdkVersion` with the one provided below.

```groovy
compileSdkVersion flutterCompileSdkVersion.toInteger()
```

Similarly, there is also a `defaultConfig` block that has the below codes:

```groovy
...

android {
    ...

    defaultConfig {
        ...
        minSdkVersion 21
        targetSdkVersion 32
        ...
    }


}
```

Replace the above `minSdkVersion` and `targetSdkVersion` with the below lines:

```groovy
minSdkVersion flutterMinSdkVersion.toInteger()
targetSdkVersion flutterTargetSdkVersion.toInteger()
```

Now, the file would look something like this.

```groovy
...

android {    
    ...
    compileSdkVersion flutterCompileSdkVersion.toInteger()

    defaultConfig {
        ...
        minSdkVersion flutterMinSdkVersion.toInteger()
        targetSdkVersion flutterTargetSdkVersion.toInteger()
        ...
    }


}
```

Now, we still need to add the signing configuration to the `build.gradle` file. Add the below lines inside the `android` block.

```groovy
signingConfigs {
    release {
        storeFile rootProject.file(releaseStoreFile)
        storePassword  releaseStorePassword
        keyAlias releaseKeyAlias
        keyPassword  releaseKeyPassword
    }

    debug {
        storeFile rootProject.file(debugStoreFile)
        storePassword  debugStorePassword
        keyAlias debugKeyAlias
        keyPassword  debugKeyPassword
    }
}
```

Now, for final steps, remove the whole `buildTypes` code block and add the below lines:

```groovy
buildTypes {
    release {
        minifyEnabled true
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        signingConfig signingConfigs.release
    }

    debug {
        signingConfig signingConfigs.debug
    }
}
```

Now, the final files would look something like this. 

**FINAL RESULT: Only consider the changes we made above. Other things will be according to your project configuraiton.**

```groovy
// region - local.properties configuration
// START: local.properties configuration
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
} else {
    throw new GradleException("local.properties files is not found. Please set up the file correctly and try again.")
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

def flutterMinSdkVersion = localProperties.getProperty('flutter.minSdkVersion')
if (flutterMinSdkVersion == null) {
    flutterMinSdkVersion = '23'
}

def flutterTargetSdkVersion = localProperties.getProperty('flutter.targetSdkVersion')
if (flutterTargetSdkVersion == null) {
    flutterTargetSdkVersion = '32'
}

def flutterCompileSdkVersion = localProperties.getProperty('flutter.compileSdkVersion')
if (flutterCompileSdkVersion == null) {
    flutterCompileSdkVersion = '33'
}
// END: local.properties configuration
// endregion

// region - keystore.properties configuration
// START: keystore.properties configuration
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('keystore.properties')
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.withReader('UTF-8') { reader ->
        keystoreProperties.load(reader)
    }
} else {
    throw new GradleException("keystore.properties files is not found. Please set up the file correctly using keystore.properties.example file and try again.")
}

def releaseStoreFile = keystoreProperties.getProperty('releaseStoreFile')
def releaseStorePassword = keystoreProperties.getProperty('releaseStorePassword')
def releaseKeyAlias = keystoreProperties.getProperty('releaseKeyAlias')
def releaseKeyPassword = keystoreProperties.getProperty('releaseKeyPassword')

def debugStoreFile = keystoreProperties.getProperty('debugStoreFile')
def debugStorePassword = keystoreProperties.getProperty('debugStorePassword')
def debugKeyAlias = keystoreProperties.getProperty('debugKeyAlias')
def debugKeyPassword = keystoreProperties.getProperty('debugKeyPassword')
// END: keystore.properties configuration
// endregion

apply plugin: 'com.android.application'
// START: FlutterFire Configuration
apply plugin: 'com.google.gms.google-services'
apply plugin: 'com.google.firebase.firebase-perf'
apply plugin: 'com.google.firebase.crashlytics'
// END: FlutterFire Configuration
apply plugin: 'kotlin-android'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

android {
    compileSdkVersion flutterCompileSdkVersion.toInteger()

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }

    defaultConfig {
        applicationId "come.peuconomia.notebook.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-build-configuration.
        minSdkVersion flutterMinSdkVersion.toInteger()
        targetSdkVersion flutterTargetSdkVersion.toInteger()
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    signingConfigs {
        release {
            storeFile rootProject.file(releaseStoreFile)
            storePassword  releaseStorePassword
            keyAlias releaseKeyAlias
            keyPassword  releaseKeyPassword
        }

        debug {
            storeFile rootProject.file(debugStoreFile)
            storePassword  debugStorePassword
            keyAlias debugKeyAlias
            keyPassword  debugKeyPassword
        }
    }

    buildTypes {
        release {
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
            signingConfig signingConfigs.release
        }

        debug {
            signingConfig signingConfigs.debug
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
}

```

> **NOTE: ** Add a file named `proguard-rules.pro` empty file inside `./android/app/` folder. 
> **LOCATION:** `./android/app/proguard-rules.pro` 

## 3. Run your app

To run your app, execute the below commands for each platform:

**FOR ANDROID:**
```bash
flutter run android
```

**FOR iOS:**
```bash
flutter run ios
```


## 4. Building your application

To build your application, we have below options:

### 4.1 Building Android application

**For DEBUG APK:**
```
flutter build apk --debug
```

**For RELEASE APK:**
```
flutter build apk --obfuscate --split-debug-info=./build/debug-symbols/
```

**For RELEASE BUNDLE:**
```
flutter build appbundle --obfuscate --split-debug-info=./build/debug-symbols/
```

For more information, go to this [LINK](https://docs.flutter.dev/deployment/android) for building and releasing an android application.

### 4.2 Building iOS application

**LINK:** Unfortunately, iOS build process cannot be summarized in few lines. So, please look into this [LINK](https://docs.flutter.dev/deployment/ios) for building and releasing an iOS application.

## 5. Conclusion

If you followed everything properly, your project is now setup properly. Now, you can continue to build you Flutter Application with ease.

Thank you for your time into looking in this `flutter_starter_project` template.






