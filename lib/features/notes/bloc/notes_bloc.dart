import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/notes_repository.dart';
import 'notes_event.dart';
import 'notes_state.dart';

/// BLoC for managing notes and clipboard items.
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository repository;

  NotesBloc(this.repository) : super(NotesInitial()) {
    // Load all notes
    on<LoadNotes>((event, emit) async {
      emit(NotesLoading());
      try {
        final notes = await repository.getAllNotes();
        emit(NotesLoaded(notes));
      } catch (e) {
        emit(NotesError('Failed to load notes: $e'));
      }
    });

    // Add a new note
    on<AddNote>((event, emit) async {
      emit(NotesLoading());
      try {
        await repository.addNote(event.note);
        final notes = await repository.getAllNotes();
        emit(NotesLoaded(notes));
      } catch (e) {
        emit(NotesError('Failed to add note: $e'));
      }
    });

    // Update an existing note
    on<UpdateNote>((event, emit) async {
      emit(NotesLoading());
      try {
        await repository.updateNote(event.note);
        final notes = await repository.getAllNotes();
        emit(NotesLoaded(notes));
      } catch (e) {
        emit(NotesError('Failed to update note: $e'));
      }
    });

    // Delete a note by id
    on<DeleteNote>((event, emit) async {
      emit(NotesLoading());
      try {
        await repository.deleteNote(event.id);
        final notes = await repository.getAllNotes();
        emit(NotesLoaded(notes));
      } catch (e) {
        emit(NotesError('Failed to delete note: $e'));
      }
    });
  }
}
