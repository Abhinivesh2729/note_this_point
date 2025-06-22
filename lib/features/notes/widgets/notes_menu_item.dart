import 'package:flutter/material.dart';

PopupMenuItem<String> buildNotesMenuItem(String value, IconData icon, String text, {bool isDelete = false}) {
  return PopupMenuItem(
    value: value,
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDelete
                ? Colors.red.withValues(alpha: 0.1)
                : const Color(0xFFFFD54F).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: isDelete ? Colors.red : const Color(0xFF5D4037),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            color: isDelete ? Colors.red : const Color(0xFF5D4037),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
