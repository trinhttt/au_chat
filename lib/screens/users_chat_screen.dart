import 'package:au_chat/common/colors.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/provider/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'detail_chat_screen.dart';

class UsersChatScreen extends StatefulWidget {
  @override
  UsersChatScreenState createState() => UsersChatScreenState();
}

class UsersChatScreenState extends State<UsersChatScreen> {
   List<dynamic> entries = [];

  @override
  void initState() {
    super.initState();
    print('UsersChatScreenState');
    APIService.getUsers().then((users) {
      print('data $users');
      setState(() {
        entries = users;
        print("entries ${entries}");
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 114,
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
                    height: 46,
                    // color: Colors.yellow,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        filled: true,
                        // border: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        hintText: 'Search ...',
                        hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white
                        ),
                        // disabledBorder: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: AUColors.bgColor,
          width: double.infinity,
          height: height - 120,
          child: ListUserChat(entries),
        ));
  }
}



class ListUserChat extends StatelessWidget {
  final List<dynamic> users;

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
  final dynamic user;

  const UserChart(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailChatScreen(), settings: RouteSettings(arguments: user)),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 24,
            backgroundImage: NetworkImage(this.user.avatar ?? "https://www.w3schools.com/howto/img_avatar.png"),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    this.user.name,
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
                    this.user.lastMessage ?? "",
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
