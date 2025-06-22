import 'package:flutter/material.dart';
import 'package:note_this_point/core/app_constants.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NotchBottomBarController _controller = NotchBottomBarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text(
          AppConstants.title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
      ),

      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //page name
              Container(
                padding: const EdgeInsets.only(left: 20, top: 30),
                width: MediaQuery.of(context).size.width,
                height: 75,
                child: Text(
                  "Notes List",
                  style: TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade200,
                  ),
                ),
              ),

              //list of notes
              Container(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: List.generate(6, (index) => NoteTile()),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: AnimatedNotchBottomBar(
          circleMargin: 20,
          notchBottomBarController: _controller,
          color: Colors.grey.shade500,
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: Icon(Icons.home, size: 30, color: Colors.black),
              activeItem: Icon(Icons.home),
            ),
        
            BottomBarItem(
              inActiveItem: Icon(Icons.search, size: 30, color: Colors.black),
              activeItem: Icon(Icons.search),
            ),
        
            BottomBarItem(
              inActiveItem: Icon(Icons.content_paste_go, size: 30, color: Colors.black),
              activeItem: Icon(Icons.content_paste_go),
            ),
        
            
          ],
          onTap: (data) {},
          kIconSize: 20,
          kBottomRadius: 20,
        ),
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Note 1",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "This is my first note in this application",
            style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
