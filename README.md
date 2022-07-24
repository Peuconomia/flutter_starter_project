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

###2.1 Clone the Repository

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

**NOTE:** Check whole configuraton options for `flutter create` using `flutter create --help` command.

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

*NOTE:* DO NOT edit anything in `local.properties` except adding the above lines. Other changes will be overwritten by FLUTTER.

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




