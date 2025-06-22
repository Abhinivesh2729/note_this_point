import 'package:hive/hive.dart';

part 'note_item.g.dart';

/// Hive Type ID for NoteItem. Change only if you know what you're doing.
@HiveType(typeId: 0)
class NoteItem extends HiveObject {
  /// Unique identifier for the note or clipboard entry
  @HiveField(0)
  final String id;

  /// Title of the note. Null for clipboard entries.
  @HiveField(1)
  final String? title;

  /// Main content of the note or clipboard entry
  @HiveField(2)
  final String content;

  /// Creation timestamp
  @HiveField(3)
  final DateTime createdAt;

  /// Last updated timestamp
  @HiveField(4)
  final DateTime updatedAt;

  NoteItem({
    required this.id,
    this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
}
