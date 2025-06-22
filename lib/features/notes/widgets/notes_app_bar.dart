import 'package:flutter/material.dart';

class NotesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isGridView;
  final VoidCallback onToggleView;
  final Widget popupMenu;

  const NotesAppBar({
    super.key,
    required this.isGridView,
    required this.onToggleView,
    required this.popupMenu,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'My Notes',
        style: TextStyle(
          color: Color(0xFF5D4037),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD54F).withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD54F).withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(isGridView ? Icons.list_rounded : Icons.grid_view_rounded, color: const Color(0xFF5D4037)),
            onPressed: onToggleView,
            tooltip: isGridView ? 'List View' : 'Grid View',
          ),
        ),
        popupMenu,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
