import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum UserType { receiver, sender }
enum MessageType { text, icon }

class ChatMessage {
  dynamic messageContent;
  UserType userType;
  MessageType messageType;

  ChatMessage(this.messageContent,
      [this.userType = UserType.sender, this.messageType = MessageType.text]);
}

class DetailChatScreen extends StatefulWidget {
  @override
  DetailChatScreenState createState() => DetailChatScreenState();
}

class DetailChatScreenState extends State<DetailChatScreen> {
  final double _chatBoxHeight = 60;
  var _hasText = false;
  final TextEditingController textEditingController = TextEditingController();
  List<ChatMessage> messages = [
    ChatMessage(57947, UserType.sender, MessageType.icon),
    ChatMessage("aaaaaaaaaaaaaaaaaaaaaaaaa", UserType.receiver),
    ChatMessage("aaaaaaaaaaaaaaaaaaaaaaaaa", UserType.receiver),
    ChatMessage("bbbbbbbbbbbbbbbbbbbbbbbbb", UserType.sender),
    ChatMessage("bbbbbbbbbbbbbbbbbbbbbbbbb", UserType.sender),
    ChatMessage("aaaaaaaaaaaaaaaaaaaaaaaaa", UserType.receiver),
    ChatMessage("aaaaaaaaaaaaaaaaaaaaaaaaa", UserType.receiver),
    ChatMessage("bbbbbbbbbbbbbbbbbbbbbbbbb", UserType.sender),
    ChatMessage("bbbbbbbbbbbbbbbbbbbbbbbbb", UserType.sender),
    ChatMessage("aaaaaaaaaaaaaaaaaaaaaaaaa", UserType.receiver),
    ChatMessage("aaaaaaaaaaaaaaaaaaaaaaaaa", UserType.receiver),
    ChatMessage("bbbbbbbbbbbbbbbbbbbbbbbbb", UserType.sender),
    ChatMessage("bbbbbbbbbbbbbbbbbbbbbbbbb", UserType.sender),
  ];

  void _sendMessage() {
    setState(() {
      if (textEditingController.text.isEmpty) {
        messages.insert(
            0, ChatMessage(57947, UserType.sender, MessageType.icon));
      } else {
        messages.insert(0, ChatMessage(textEditingController.text));
      }
      textEditingController.clear();
      _hasText = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _buildCustomAppBar(context),
        body: _buildBodyView());
  }

  AppBar _buildCustomAppBar(BuildContext context) {
    return AppBar(
      // toolbarHeight: 60,
      elevation: 1,
      flexibleSpace: SafeArea(
        // or using PreferredSize
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          color: Colors.black,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.blue, size: 25),
              ),
              SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://previews.123rf.com/images/amosyagina/amosyagina1805/amosyagina180500032/102632429-cute-avatar-icon-with-girl.jpg"),
                maxRadius: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Alita",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Online",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  print("Tapped search");
                },
                icon: Icon(Icons.search, color: Colors.blue, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBodyView() {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [_buildChatContentView(), _buildChatBoxView()],
          ),
        ),
      ),
    );
  }

  Widget _buildChatContentView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(
            left: 10, right: 10, top: 10, bottom: _chatBoxHeight + 10),
        width: double.infinity,
        color: Colors.black,
        child: ListView.builder(
            // padding: EdgeInsets.symmetric(vertical: 10),
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return messages[index].messageType == MessageType.icon
                  ? Align(
                      alignment: messages[index].userType == UserType.receiver
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Icon(
                        IconData(messages[index].messageContent as int,
                            fontFamily: 'MaterialIcons'),
                        size: 30,
                      ))
                  : Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Align(
                        alignment: messages[index].userType == UserType.receiver
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: messages[index].userType ==
                                        UserType.receiver
                                    ? Colors.blueGrey
                                    : Colors.blue),
                            child: Text(messages[index].messageContent)),
                      ),
                      // child:           if (messages[index].messageType == MessageType.receiver)
                    );
            }),
      ),
    );
  }

  Widget _buildChatBoxView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(10),
        height: _chatBoxHeight,
        width: double.infinity,
        color: Colors.black,
        child: Row(
          children: [
            SizedBox(
              width: 40.0,
              child: IconButton(
                // padding: EdgeInsets.all(3.0),
                onPressed: () {},
                icon: Icon(
                  Icons.add_photo_alternate,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              width: 40.0,
              child: IconButton(
                // padding: EdgeInsets.all(3.0),
                onPressed: () {},
                icon: Icon(
                  Icons.add_reaction,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: textEditingController,
                onChanged: (value) {
                  //empty-> 1 & 1->empty
                  // if (value.length < 2) {
                  setState(() {
                    _hasText = value.isEmpty ? false : true;
                  });
                  // }
                },
                decoration: InputDecoration(
                    hintText: "Write message...",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 40.0,
              child: IconButton(
                onPressed: () {
                  _sendMessage();
                },
                icon: Icon(
                  (_hasText ? Icons.send : Icons.favorite),
                  color: Colors.blue,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
