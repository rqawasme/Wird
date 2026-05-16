# Wird

A focused Flutter app for reciting classical wirds and dua collections, step by step. Built for calm, considered UX over feature breadth.

## Status

v1 scaffold. Onboarding, home, player, settings, preview modal, and notifications are all wired up. Content is seeded with placeholder adhkar/wirds/collections — real classical content goes into `assets/data/`.

## Getting started

### 1. Add the native platform shells

This project is checked in as Dart-only source. The first thing to do is generate the iOS and Android shells:

```bash
flutter create . --project-name wird --platforms ios,android
```

This is non-destructive — `pubspec.yaml`, `lib/`, `assets/`, and `test/` are preserved.

### 2. Install dependencies and run code generation

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Code generation produces the `.freezed.dart` and `.g.dart` files for freezed, json_serializable, hive_generator, and riverpod_generator. Run it again after editing any annotated model or `@riverpod` provider.

### 3. Run on simulator/device

```bash
flutter run
```

First launch lands on onboarding:

1. Welcome screen
2. Pick at least one wird source (the seeded data has morning and evening)
3. Optionally pick collections (anxiety, before-sleep)
4. Enable notifications and pick times

After finishing onboarding you land on home. Tap the daily Wird card to enter the player. Counter taps advance the count; the final tap fires a medium haptic and moves to the next step. The completion screen logs the wird and routes back home.

### 4. Tests

```bash
flutter test
```

The included tests cover the streak calculator and the wird merge algorithm.

### 5. Lints

```bash
dart analyze
```

`analysis_options.yaml` enables strict mode plus the lint set from the spec (`prefer_const_constructors`, `prefer_const_literals_to_create_immutables`, `avoid_print`, `require_trailing_commas`, and others).

## Project structure

See `lib/` and the spec for the file layout. In short:

- `lib/data/` — models (freezed/Hive), repositories, Riverpod providers
- `lib/features/` — screens (onboarding, home, player, settings, preview)
- `lib/services/` — notifications, haptics
- `lib/theme/` — Material 3 themes and brand `ThemeExtension`s
- `lib/utils/` — pure helpers (date keys, streak calculator)
- `assets/data/` — bundled JSON content (see its README for the schema)
- `test/` — pure-function tests

## Authoring content

`assets/data/README.md` documents the JSON schema. Replace the placeholders with full classical content there. The app validates that every `dhikrId` referenced from a wird or collection step exists in `adhkar.json` at runtime — missing ids are skipped (and logged in debug builds).

## Out of scope for v1

- Audio recitation per step
- Prayer-time integration
- Custom user-authored wirds
- Free tasbih counter (stubbed in settings)
- Arabic font size adjustment (stubbed in settings)
- Cloud sync, accounts
- Localization (English only for now, but the scaffolding is in place for `intl`)
