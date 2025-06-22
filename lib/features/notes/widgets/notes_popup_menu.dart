import 'package:flutter/material.dart';

class NotesPopupMenu extends StatelessWidget {
  final void Function(String value) onSelected;
  final PopupMenuItem<String> Function(String, IconData, String, {bool isDelete}) buildMenuItem;

  const NotesPopupMenu({
    super.key,
    required this.onSelected,
    required this.buildMenuItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF5D4037)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        elevation: 20,
        onSelected: onSelected,
        itemBuilder: (context) => [
          buildMenuItem('search', Icons.search_rounded, 'Search Notes'),
          buildMenuItem('sort', Icons.sort_rounded, 'Sort Notes'),
          const PopupMenuDivider(),
          buildMenuItem('delete_all', Icons.delete_sweep_rounded, 'Delete All', isDelete: true),
        ],
      ),
    );
  }
}
