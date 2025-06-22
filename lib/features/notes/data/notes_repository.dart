import 'package:hive/hive.dart';
import '../models/note_item.dart';

/// Repository for managing NoteItem data using Hive.
/// Handles basic CRUD operations for notes and clipboard entries.
class NotesRepository {
  static const String boxName = 'note_items_box';

  /// Opens the Hive box for NoteItem objects.
  Future<Box<NoteItem>> _openBox() async {
    return await Hive.openBox<NoteItem>(boxName);
  }

  /// Retrieves all NoteItem objects from the box.
  Future<List<NoteItem>> getAllNotes() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// Adds a new NoteItem to the box.
  Future<void> addNote(NoteItem note) async {
    final box = await _openBox();
    await box.put(note.id, note);
  }

  /// Updates an existing NoteItem in the box.
  Future<void> updateNote(NoteItem note) async {
    final box = await _openBox();
    await box.put(note.id, note);
  }

  /// Deletes a NoteItem from the box by its id.
  Future<void> deleteNote(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }
}
