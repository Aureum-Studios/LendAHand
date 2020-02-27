[![MADE WITH](https://img.shields.io/static/v1.svg?labelColor=lightgray&color=gray&label=MADE%20WITH&message=FLUTTER&logo=flutter&logoColor=blue&style=for-the-badge&cacheSeconds=33600)](https://flutter.dev/)

[![Codemagic build status](https://api.codemagic.io/apps/5dc997411de6024542cbccf2/5dc997411de6024542cbccf1/status_badge.svg)](https://codemagic.io/apps/5dc997411de6024542cbccf2/5dc997411de6024542cbccf1/latest_build)

# Lend A Hand

###### Description needs to be added

## Developer Standards

* When using string make sure to go through `AppLocalizations` to support internationalization.
* Commit code using Dart formatting from IntelliJ | Android Studio.
* Add necessary print statements, this will be replaced by logs in the future.
* Keep activities/screens under `pages`, (almost) every other widget goes under `component`
* Detach application logic from UI.

## Using Firebase

After accessing the [Firebase Console](https://console.firebase.google.com/u/0/) you will see that we already have
a few things setup:

- Authentication
- Analytics
- Crashlytics

To validate, just go through each tab. Furthermore the [`pubspec.yml`](./pubspec.yaml) shows it.

#### Adding New Firebase Features

To add new firebase features, you must likely will need to modify:

- Project level (Android) [`build.gradle`](./android/build.gradle)
- App level (Android) [`build.gradle`](./android/app/build.gradle)
- Podfile (iOS) [`Podfile`](./ios/Podfile)

**NOTE:** You don't need Xcode for this, just CocoaPods.

These additions require a hot restart, and perhaps running `pod install` or `gradle build` on command line, 
although Flutter `main.dart` run should trigger all this.

## Useful Resources
* [Firebase Console](https://console.firebase.google.com/u/0/)
* [Google Play Console](https://play.google.com/apps/publish/?account=8413851140364268209#AppListPlace)
* [Codemagic](https://codemagic.io/apps/5dc997411de6024542cbccf2/5dc997411de6024542cbccf1/latest_build)