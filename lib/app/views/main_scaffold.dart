import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_this_point/app/colors/app_colors.dart';
import '../../features/notes/views/notes_page.dart';
import '../../features/clipboard/views/clipboard_page.dart';
import '../../features/chat/views/chat_page.dart';
// import '../../core/constants.dart'; // Uncomment if you use any constants

/// Main navigation scaffold with AnimatedNotchBottomBar
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  // Controller for the notch bottom bar
  final NotchBottomBarController _notchController = NotchBottomBarController(
    index: 0,
  );

  // Controller for the page view
  final PageController _pageController = PageController();

  // Current page index
  // ignore: unused_field
  int _currentIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    const NotesPage(),
    const ClipboardPage(),
    ChatPage(),
  ];

  @override
  void dispose() {
    _notchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true, // Prevent keyboard overflow
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Disable swipe
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          
        ],
      ),
      // Prevents bottom sheet from interfering with the bottom bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: AnimatedNotchBottomBar(
            notchBottomBarController: _notchController,
            bottomBarItems: [
              BottomBarItem(
                inActiveItem: const Icon(
                  Icons.note_outlined,
                  color: Colors.grey,
                ),
                activeItem: const Icon(Icons.note, color: AppColors.primary),
                itemLabel: 'Notes',
              ),
              BottomBarItem(
                inActiveItem: const Icon(
                  Icons.content_paste_outlined,
                  color: Colors.grey,
                ),
                activeItem: const Icon(
                  Icons.content_paste,
                  color: AppColors.primary,
                ),
                itemLabel: 'Clipboard',
              ),
              BottomBarItem(
                inActiveItem: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.grey,
                ),
                activeItem: const Icon(
                  Icons.chat_bubble,
                  color:  AppColors.primary,
                ),
                itemLabel: 'AI Chat',
              ),
            ],
            onTap: (index) {
              _notchController.jumpTo(index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              setState(() {
                _currentIndex = index;
              });
            },
            color: Colors.white,
            elevation: 5,
            showLabel: true,
            itemLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.black87,
            ),
            durationInMilliSeconds: 300,
            notchColor: Colors.white, // Notch color (Blue shade)
            bottomBarHeight: 30.0,
            showShadow: true,
            kIconSize: 24,
            kBottomRadius: 15,
          ),
        ),
      ),
    );
  }
}

class Erode extends StatelessWidget {
  const Erode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, bottom: 150),
      alignment: Alignment.bottomLeft,
      child: Text(
        'Made with ❤️\nin Erode',
        style: GoogleFonts.poppins(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
      ),
    ),
    );
  }
}