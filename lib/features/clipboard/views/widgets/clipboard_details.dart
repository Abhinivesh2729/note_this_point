import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../notes/models/note_item.dart';

class ClipboardDetailPage extends StatefulWidget {
  final NoteItem item;

  const ClipboardDetailPage({super.key, required this.item});

  @override
  State<ClipboardDetailPage> createState() => _ClipboardDetailPageState();
}

class _ClipboardDetailPageState extends State<ClipboardDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM d, yyyy - h:mm a');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _glassIconButton(
          icon: Icons.arrow_back_rounded,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Clipboard Item',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          _glassPopupMenu(),
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF).withValues(alpha: 0.8), // Soft white
            const Color(0xFF8EC5FC).withValues(alpha: 0.5), // Light sky blue
            const Color(
              0xFFE0C3FC
            ).withValues(alpha: 0.3), 
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _glassCard(
                      child: Row(
                        children: [
                          Icon(Icons.access_time_rounded, color: Colors.black.withValues(alpha: 0.5)),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Created', style: TextStyle(fontSize: 12, color: Colors.black.withValues(alpha: 0.5))),
                              const SizedBox(height: 4),
                              Text(
                                dateFormat.format(widget.item.createdAt),
                                style: TextStyle(color: Colors.black.withValues(alpha: 0.5), fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _glassCard(
                      padding: const EdgeInsets.all(20),
                      child: SelectableText(
                        widget.item.content,
                        style: TextStyle(color: Colors.black.withValues(alpha: 0.5), fontSize: 16, height: 1.6),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: _glassActionButton(
                            icon: Icons.copy,
                            label: 'Copy',
                            onPressed: () => _copyToClipboard(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _glassActionButton(
                            icon: Icons.share,
                            label: 'Share',
                            onPressed: () => _shareContent(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassCard({required Widget child, EdgeInsets padding = const EdgeInsets.all(16)}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.0),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _glassActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.15),
        foregroundColor: Colors.black.withValues(alpha: 0.5),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _glassIconButton({required IconData icon, required VoidCallback onPressed}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.white.withValues(alpha: 0.15),
          margin: const EdgeInsets.all(8),
          child: IconButton(
            icon: Icon(icon, color: Colors.black),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }

  Widget _glassPopupMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.black),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 16,
      onSelected: (value) {
        switch (value) {
          case 'copy':
            _copyToClipboard(context);
            break;
          case 'share':
            _shareContent(context);
            break;
          case 'convert':
            _convertToNote(context);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'copy', child: Text('Copy')),
        const PopupMenuItem(value: 'share', child: Text('Share')),
        const PopupMenuItem(value: 'convert', child: Text('Convert to Note')),
      ],
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.item.content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _shareContent(BuildContext context) async {
    try {
      final RenderBox box = context.findRenderObject() as RenderBox;
      await Share.share(
        widget.item.content,
        subject: 'Shared from Clipboard',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to share content')),
      );
    }
  }

  void _convertToNote(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Convert to Note feature coming soon')),
    );
  }
}