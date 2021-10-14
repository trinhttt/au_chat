import 'package:au_chat/screens/profile.dart';
import 'package:au_chat/screens/users_chat_screen.dart';
import 'package:flutter/material.dart';

import '../detail_chat_screen.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({Key? key}) : super(key: key);

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [
    UsersChatScreen(),
    DetailChatScreen(),
    ProfileScreen(),
  ];

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          // Disable swiping tabs in PageView flutter
          physics: NeverScrollableScrollPhysics(),
          children: tabPages,
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_work),
                label: 'Channels',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box),
                label: 'Profile',
              ),
            ],
            currentIndex: _pageIndex,
            selectedItemColor: Colors.indigo[900],
            onTap: onTabTapped,
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
