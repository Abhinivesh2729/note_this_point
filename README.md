# Note This Point

A minimal, offline notes app built with Flutter.

## Features
- Create, edit, and delete notes
- Fast local storage with Hive
- Modern UI with animated bottom navigation
- State management using flutter_bloc
- Modular, maintainable code structure

## Getting Started
1. **Install dependencies:**
   ```bash
   flutter pub get
   ```
2. **Generate Hive adapters:**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```
3. **Run the app:**
   ```bash
   flutter run
   ```

## Project Structure
```
lib/
├── app/                     # App-level components
│   └── views/
│       └── main_scaffold.dart
├── core/                    # Core utilities and constants
│   └── app_constants.dart
├── features/                # Feature modules
│   ├── notes/               # Notes feature
│   │   ├── bloc/           
│   │   ├── data/
│   │   ├── models/
│   │   ├── views/
│   │   └── widgets/
│   ├── clipboard/           # Clipboard feature (legacy or optional)
│   │   └── views/
│   ├── chat/                # AI Chat (placeholder)
│   │   └── views/
├── main.dart                # Application entry point
```

- `lib/features/notes/` — Notes feature (models, bloc, repository, UI)
- `lib/features/clipboard/` — Clipboard feature (legacy or optional)
- `lib/features/chat/` — AI Chat (placeholder)
- `lib/core/` — App constants
- `lib/app/views/` — Main navigation scaffold

## Tech Stack
- Flutter 3.8+
- Hive
- flutter_bloc
- animated_notch_bottom_bar
- google_fonts

## License
MIT
