# users_api

```
flutter create users_api
cd users_api
flutter pub add http provider
flutter pub add --dev flutter_lints   # if not already present
```
Copy `lib/`, `analysis_options.yaml`, `NOTES.md` over the generated project, then:

```
flutter run
flutter analyze
dart format .
grep -rn "package:http" lib/      # exactly api_client.dart and user_repository.dart
```
