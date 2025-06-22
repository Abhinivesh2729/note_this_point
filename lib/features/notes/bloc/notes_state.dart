import 'package:equatable/equatable.dart';
import '../models/note_item.dart';

/// Base class for all notes states.
abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action is taken.
class NotesInitial extends NotesState {}

/// State while notes are being loaded or modified.
class NotesLoading extends NotesState {}

/// State when notes are successfully loaded.
class NotesLoaded extends NotesState {
  final List<NoteItem> notes;
  const NotesLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

/// State when an error occurs.
class NotesError extends NotesState {
  final String message;
  const NotesError(this.message);

  @override
  List<Object?> get props => [message];
}
