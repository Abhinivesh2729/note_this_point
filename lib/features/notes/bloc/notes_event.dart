import 'package:equatable/equatable.dart';
import '../models/note_item.dart';

/// Base class for all notes events.
abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all notes and clipboard items.
class LoadNotes extends NotesEvent {}

/// Event to add a new note or clipboard item.
class AddNote extends NotesEvent {
  final NoteItem note;
  const AddNote(this.note);

  @override
  List<Object?> get props => [note];
}

/// Event to update an existing note or clipboard item.
class UpdateNote extends NotesEvent {
  final NoteItem note;
  const UpdateNote(this.note);

  @override
  List<Object?> get props => [note];
}

/// Event to delete a note or clipboard item by id.
class DeleteNote extends NotesEvent {
  final String id;
  const DeleteNote(this.id);

  @override
  List<Object?> get props => [id];
}
