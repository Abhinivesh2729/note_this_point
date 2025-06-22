import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_this_point/features/notes/models/note_item.dart';
import 'clipboard_event.dart';
import 'clipboard_state.dart';

class ClipboardBloc extends Bloc<ClipboardEvent, ClipboardState> {
  final Box<NoteItem> _clipboardBox;
  Timer? _clipboardTimer;
  String? _lastClipboardContent;

  ClipboardBloc({required Box<NoteItem> clipboardBox})
      : _clipboardBox = clipboardBox,
        super(ClipboardInitial()) {
    on<LoadClipboardHistory>(_onLoadClipboardHistory);
    on<AddClipboardItem>(_onAddClipboardItem);
    on<DeleteClipboardItem>(_onDeleteClipboardItem);
    on<ClearClipboardHistory>(_onClearClipboardHistory);
    on<MonitorClipboard>(_onMonitorClipboard);
    on<StopMonitoringClipboard>(_onStopMonitoringClipboard);
  }

  Future<void> _onLoadClipboardHistory(
    LoadClipboardHistory event,
    Emitter<ClipboardState> emit,
  ) async {
    emit(ClipboardLoading());
    try {
      final items = _clipboardBox.values.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      emit(ClipboardLoaded(
        clipboardItems: items,
        isMonitoring: _clipboardTimer != null,
      ));
    } catch (e) {
      emit(ClipboardError(message: 'Failed to load clipboard history'));
    }
  }

  Future<void> _onAddClipboardItem(
    AddClipboardItem event,
    Emitter<ClipboardState> emit,
  ) async {
    try {
      // Check if content already exists
      final existingItems = _clipboardBox.values
          .where((item) => item.content == event.content)
          .toList();
      
      if (existingItems.isEmpty) {
        final now = DateTime.now();
        final newItem = NoteItem(
          id: now.millisecondsSinceEpoch.toString(),
          title: null, // Clipboard items don't have titles
          content: event.content,
          createdAt: now,
          updatedAt: now,
        );
        
        await _clipboardBox.put(newItem.id, newItem);
      }
      
      add(LoadClipboardHistory());
    } catch (e) {
      emit(ClipboardError(message: 'Failed to add clipboard item'));
    }
  }

  Future<void> _onDeleteClipboardItem(
    DeleteClipboardItem event,
    Emitter<ClipboardState> emit,
  ) async {
    try {
      await _clipboardBox.delete(event.id);
      add(LoadClipboardHistory());
    } catch (e) {
      emit(ClipboardError(message: 'Failed to delete clipboard item'));
    }
  }

  Future<void> _onClearClipboardHistory(
    ClearClipboardHistory event,
    Emitter<ClipboardState> emit,
  ) async {
    try {
      await _clipboardBox.clear();
      add(LoadClipboardHistory());
    } catch (e) {
      emit(ClipboardError(message: 'Failed to clear clipboard history'));
    }
  }

  Future<void> _onMonitorClipboard(
    MonitorClipboard event,
    Emitter<ClipboardState> emit,
  ) async {
    if (_clipboardTimer != null) return;

    _clipboardTimer = Timer.periodic(
      const Duration(seconds: 2),
      (_) async {
        try {
          final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
          final content = clipboardData?.text;
          
          if (content != null && 
              content.isNotEmpty && 
              content != _lastClipboardContent) {
            _lastClipboardContent = content;
            add(AddClipboardItem(content: content));
          }
        } catch (e) {
          // Silently fail - clipboard access might not be available
        }
      },
    );

    if (state is ClipboardLoaded) {
      emit((state as ClipboardLoaded).copyWith(isMonitoring: true));
    }
  }

  Future<void> _onStopMonitoringClipboard(
    StopMonitoringClipboard event,
    Emitter<ClipboardState> emit,
  ) async {
    _clipboardTimer?.cancel();
    _clipboardTimer = null;
    
    if (state is ClipboardLoaded) {
      emit((state as ClipboardLoaded).copyWith(isMonitoring: false));
    }
  }

  @override
  Future<void> close() {
    _clipboardTimer?.cancel();
    return super.close();
  }
}