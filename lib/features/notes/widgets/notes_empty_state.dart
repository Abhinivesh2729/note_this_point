import 'package:flutter/material.dart';

class NotesEmptyState extends StatelessWidget {
  final VoidCallback onCreateNote;
  final Widget gradientButton;
  const NotesEmptyState({super.key, required this.onCreateNote, required this.gradientButton});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD54F).withValues(alpha: 0.2),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFFD54F).withValues(alpha: 0.2),
                    const Color(0xFFFFE082).withValues(alpha: 0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.note_add_rounded, size: 64, color: Color(0xFF5D4037)),
            ),
            const SizedBox(height: 24),
            const Text(
              'No notes yet',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to create your first note',
              style: TextStyle(fontSize: 16, color: const Color(0xFF5D4037).withValues(alpha: 0.7)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            gradientButton,
          ],
        ),
      ),
    );
  }
}
