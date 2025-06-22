import 'package:equatable/equatable.dart';

abstract class ClipboardEvent extends Equatable {
  const ClipboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadClipboardHistory extends ClipboardEvent {}

class AddClipboardItem extends ClipboardEvent {
  final String content;

  const AddClipboardItem({required this.content});

  @override
  List<Object?> get props => [content];
}

class DeleteClipboardItem extends ClipboardEvent {
  final String id;

  const DeleteClipboardItem({required this.id});

  @override
  List<Object?> get props => [id];
}

class ClearClipboardHistory extends ClipboardEvent {}

class MonitorClipboard extends ClipboardEvent {}

class StopMonitoringClipboard extends ClipboardEvent {}