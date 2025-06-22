import 'package:flutter/material.dart';
import '../models/note_item.dart';

class GridNoteTile extends StatefulWidget {
  final NoteItem note;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onShare;

  const GridNoteTile({
    super.key,
    required this.note,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onShare,
  });

  @override
  State<GridNoteTile> createState() => _GridNoteTileState();
}

class _GridNoteTileState extends State<GridNoteTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.note.title?.isNotEmpty == true
        ? widget.note.title!
        : 'Untitled';
    final preview = _getContentPreview(widget.note.content);
    final isEmptyNote =
        widget.note.title?.isEmpty != false && widget.note.content.isEmpty;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: InkWell(
        onTap: widget.onTap,
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) => _animationController.reverse(),
        onTapCancel: () => _animationController.reverse(),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
                width: 1.2,
              ),
            ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isEmptyNote
                          ? Colors.grey.withAlpha(153)
                          : const Color(0xFF5D4037),
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
      
                  const SizedBox(height: 12),
      
                  // Content Preview
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isEmptyNote
                          ? Colors.grey.withAlpha(13)
                          : const Color(0xFF5D4037).withAlpha(13),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isEmptyNote
                            ? Colors.grey.withAlpha(25)
                            : const Color(0xFF5D4037).withAlpha(25),
                        width: 1,
                      ),
                    ),
                    child: preview.isNotEmpty
                        ? Text(
                            preview,
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.3,
                              color: isEmptyNote
                                  ? Colors.grey.withAlpha(153)
                                  : const Color(0xFF5D4037).withAlpha(180),
                            ),
                            maxLines: 10, // You can increase or remove this
                            overflow: TextOverflow.ellipsis,
                          )
                        : Row(
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                size: 12,
                                color: Colors.grey.withAlpha(128),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Tap to start writing...',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey.withAlpha(153),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getContentPreview(String content) {
    if (content.isEmpty) return '';
    final cleaned = content.replaceAll(RegExp(r'\s+'), ' ').trim();
    const maxLength = 200; // increased for richer preview
    if (cleaned.length <= maxLength) {
      return cleaned;
    }
    return '${cleaned.substring(0, maxLength)}...';
  }
}
