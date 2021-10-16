import 'package:au_chat/common/colors.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'detail_chat_screen.dart';

class UsersChatScreen extends StatelessWidget {
  final List<UserModel> entries = <UserModel>[
    UserModel(
        0,
        'usernameusername0000000000000000000000000000000000',
        'https://www.w3schools.com/howto/img_avatar.png',
        'online',
        '2021-10-10T00:00:00Z',
        'lastMessage lastMessagelastMessage lastMessagelastMessagelastMessagelastMessage',
        false),
    UserModel(1, 'username1', 'https://www.w3schools.com/howto/img_avatar2.png',
        'offline', '2021-10-10T00:00:00Z', 'Haha ', false),
    UserModel(2, 'username2', 'https://www.w3schools.com/howto/img_avatar.png',
        'away', '2021-10-10T00:00:00Z', 'Hello', true),
    UserModel(3, 'username3', 'https://www.w3schools.com/howto/img_avatar2.png',
        'away', '2021-10-10T00:00:00Z', 'See you later', true),
    UserModel(4, 'username4', 'https://www.w3schools.com/howto/img_avatar2.png',
        'online', '2021-10-10T00:00:00Z', 'Yes, i do.', true),
    UserModel(5, 'username5', 'https://www.w3schools.com/howto/img_avatar.png',
        'online', '2021-10-10T00:00:00Z', 'Can you help me?', true),
    UserModel(6, 'username6', 'https://www.w3schools.com/howto/img_avatar2.png',
        'away', '2021-10-10T00:00:00Z', '20 years old', true),
    UserModel(7, 'username7', 'https://www.w3schools.com/howto/img_avatar2.png',
        'online', '2021-10-10T00:00:00Z', 'So cute!', true),
    UserModel(8, 'username8', 'https://www.w3schools.com/howto/img_avatar2.png',
        'away', '2021-10-09T00:00:00Z', 'Happy', true),
    UserModel(9, 'username9', 'https://www.w3schools.com/howto/img_avatar.png',
        'offline', '2021-10-10T00:00:00Z', 'Happy new year!', true),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 120,
          flexibleSpace: SafeArea(
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        // padding: EdgeInsets.only(top: 10),
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        height: 60,
                        width: width - 140,
                        // color: Colors.blue,
                        child: Text(
                          'Conversations',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        // alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(top: 10, right: 10),
                        height: 40,
                        width: 130,
                        // color: Colors.orange,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Container(
                              height: 40,
                              // width: 60,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                  ),
                                  Text(
                                    'Add New',
                                  ),
                                ],
                              )),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: Colors.blue,
                            minimumSize: Size(88, 36),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    // alignment: Alignment.center,
                    height: 50,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.grey[700],
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        size: 28,
                      ),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search ...',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        // body: SingleChildScrollView(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Container(
        //         padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
        //         height: height - 120,
        //         color: Colors.grey[200],
        //         child: ListUserChat(entries),
        //       ),
        //     ],
        //   ),
        // ),
        body: Container(
          color: AUColors.bgColor,
          width: double.infinity,
          height: height - 120,
          child: ListUserChat(entries),
        ));
  }
}

class ListUserChat extends StatelessWidget {
  final List<UserModel> users;

  const ListUserChat(this.users, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: this.users.length,
        itemBuilder: (BuildContext context, int index) {
          return UserChart(this.users[index]);
        });
  }
}

class UserChart extends StatelessWidget {
  final UserModel user;

  const UserChart(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailChatScreen()),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 24,
            backgroundImage: NetworkImage(this.user.avatar),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    this.user.username,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      // color: Colors.white
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  child: Text(
                    this.user.lastMessage,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: this.user.isSeen == true
                            ? FontWeight.bold
                            : FontWeight.normal),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          )),
          Container(
            // color: Colors.blue,
            width: 80,
            child: Text(
              Jiffy(this.user.lastSeen).format("MMM do"),
              style: TextStyle(
                  fontWeight: this.user.isSeen == true
                      ? FontWeight.bold
                      : FontWeight.normal),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
