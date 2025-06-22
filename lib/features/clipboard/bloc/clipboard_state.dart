import 'package:equatable/equatable.dart';
import 'package:note_this_point/features/notes/models/note_item.dart';


abstract class ClipboardState extends Equatable {
  const ClipboardState();

  @override
  List<Object?> get props => [];
}

class ClipboardInitial extends ClipboardState {}

class ClipboardLoading extends ClipboardState {}

class ClipboardLoaded extends ClipboardState {
  final List<NoteItem> clipboardItems;
  final bool isMonitoring;

  const ClipboardLoaded({
    required this.clipboardItems,
    this.isMonitoring = false,
  });

  @override
  List<Object?> get props => [clipboardItems, isMonitoring];

  ClipboardLoaded copyWith({
    List<NoteItem>? clipboardItems,
    bool? isMonitoring,
  }) {
    return ClipboardLoaded(
      clipboardItems: clipboardItems ?? this.clipboardItems,
      isMonitoring: isMonitoring ?? this.isMonitoring,
    );
  }
}

class ClipboardError extends ClipboardState {
  final String message;

  const ClipboardError({required this.message});

  @override
  List<Object?> get props => [message];
}