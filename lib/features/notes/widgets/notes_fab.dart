import 'package:flutter/material.dart';

class NotesFAB extends StatelessWidget {
  final VoidCallback onPressed;
  const NotesFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFD54F), Color(0xFFFFB300)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD54F).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        tooltip: 'Add Note',
        child: const Icon(Icons.add_rounded, color: Color(0xFF5D4037), size: 28),
      ),
    );
  }
}
