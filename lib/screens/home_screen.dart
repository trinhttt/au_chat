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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   toolbarHeight: 120,
      //   flexibleSpace: SafeArea(
      //     child: Container(
      //       color: Colors.black87,
      //       child: Column(
      //         children: [
      //           Row(
      //             children: [
      //               Container(
      //                 // padding: EdgeInsets.only(top: 10),
      //                 margin: EdgeInsets.only(left: 10),
      //                 alignment: Alignment.centerLeft,
      //                 height: 60,
      //                 width: width - 140,
      //                 // color: Colors.blue,
      //                 child: Text(
      //                   'Conversations',
      //                   style: TextStyle(
      //                       fontSize: 32,
      //                       fontWeight: FontWeight.bold,
      //                       color: Colors.white),
      //                 ),
      //               ),
      //               Container(
      //                 // alignment: Alignment.centerRight,
      //                 padding: EdgeInsets.only(top: 10, right: 10),
      //                 height: 40,
      //                 width: 130,
      //                 // color: Colors.orange,
      //                 child: ElevatedButton(
      //                   onPressed: () {},
      //                   child: Container(
      //                       height: 40,
      //                       // width: 60,
      //                       child: Row(
      //                         children: [
      //                           Icon(
      //                             Icons.add,
      //                             color: Colors.white,
      //                           ),
      //                           Text(
      //                             'Add New',
      //                           ),
      //                         ],
      //                       )),
      //                   style: ElevatedButton.styleFrom(
      //                     onPrimary: Colors.white,
      //                     primary: Colors.indigo[900],
      //                     minimumSize: Size(88, 36),
      //                     padding: EdgeInsets.symmetric(horizontal: 16),
      //                     shape: const RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.all(Radius.circular(30)),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Container(
      //             margin: EdgeInsets.only(left: 10, right: 10),
      //             // alignment: Alignment.center,
      //             height: 50,
      //             width: width,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.all(Radius.circular(25)),
      //               color: Colors.grey[200],
      //             ),
      //             child: ListTile(
      //               leading: Icon(
      //                 Icons.search,
      //                 color: Colors.indigo[900],
      //                 size: 28,
      //               ),
      //               title: TextField(
      //                 decoration: InputDecoration(
      //                   hintText: 'Search ...',
      //                   hintStyle: TextStyle(
      //                     color: Colors.indigo[900],
      //                     fontSize: 18,
      //                     fontStyle: FontStyle.italic,
      //                   ),
      //                   border: InputBorder.none,
      //                 ),
      //                 style: TextStyle(
      //                   color: Colors.indigo[900],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: PageView(
          // Disable swiping tabs in PageView flutter
          physics: NeverScrollableScrollPhysics(),
          children: tabPages,
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
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
      ),
    );
  }
}
