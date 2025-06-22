// 🎯 Project: Minimal Offline Notes App (Flutter + Hive)
// 🛠 Architecture: Feature-based MVC + BLoC
// 📦 State Management: flutter_bloc
// 💾 Local Storage: hive
// 📚 Notes and Clipboard entries share the same data model (title is optional)
// 🧠 No complex logic, simple and clean code only
// 🧩 Use reusable widgets and keep files < 200 lines
// 📁 Constants are managed in a separate file under `core/constants.dart`
// 🎨 UI should be modern but minimal (no fancy animations except animated_notch_bottom_bar)

// ✅ Task:
// 1. Create a NoteItem data model with Hive annotations
// 2. Setup Hive and open required boxes
// 3. Implement Notes Feature with MVC + BLoC
//    - Views: HomePage, NoteTile, NoteDetailPage
//    - Controller: NotesBloc for state handling (list, add, edit, delete)
//    - Model: NoteItem
// 4. Use `animated_notch_bottom_bar` for bottom navigation with 3 tabs (Notes, Clipboard, AI Chat)
// 5. Build everything with basic widgets (ListView, TextField, Scaffold, etc.)
// 6. Add Hive-based repository with read/write methods
// 7. Add clipboard page with same structure (but title is null)
// 8. Build AI Chat screen like a dummy chat page with hardcoded messages (for now)
