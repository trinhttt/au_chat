import 'dart:io';

import 'package:au_chat/common/enums/message_type_enum.dart';
import 'package:au_chat/common/enums/user_type_enum.dart';
import 'package:au_chat/models/chat_message_model.dart';
import 'package:au_chat/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common/colors.dart';

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

  Future _getImage() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        messages.insert(0,
            ChatMessage(pickedFile.path, UserType.sender, MessageType.image));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildCustomAppBar(context),
      body: _buildBodyView(),
    );
  }

  AppBar _buildCustomAppBar(BuildContext context) {
    return AppBar(
      // toolbarHeight: 60,
      elevation: 1,
      flexibleSpace: SafeArea(
        // or using PreferredSize
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
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
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildBodyView() {
    return Container(
      color: AUColors.themeColor,
      child: SafeArea(
        child: Stack(
          children: [_buildChatContentView(), _buildChatBoxView()],
        ),
      ),
    );
  }

  Widget _buildChatContentView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: AUColors.bgColor,
        padding: EdgeInsets.only(
            left: 10, right: 10, top: 10, bottom: _chatBoxHeight + 10),
        width: double.infinity,
        child: ListView.builder(
            // padding: EdgeInsets.symmetric(vertical: 10),
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              if (messages[index].messageType == MessageType.icon) {
                return _buildChatBoxIcon(messages[index]);
              } else if (messages[index].messageType == MessageType.text) {
                return _buildChatBoxMessage(messages[index]);
              } else {
                return _buildChatBoxFile(messages[index]);
              }
            }),
      ),
    );
  }

  Widget _buildChatBoxView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: AUColors.themeColor,
        padding: EdgeInsets.all(10),
        height: _chatBoxHeight,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: 40.0,
              child: IconButton(
                onPressed: () {
                  _getImage();
                },
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

  Widget _buildChatBoxMessage(message) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Align(
        alignment: _setAlignmentUserType(message.userType),
        child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: message.userType == UserType.receiver
                    ? Colors.blueGrey
                    : Colors.blue),
            child: Text(message.messageContent)),
      ),
    );
  }

  Widget _buildChatBoxIcon(message) {
    return Align(
        alignment: _setAlignmentUserType(message.userType),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            IconData(message.messageContent as int,
                fontFamily: 'MaterialIcons'),
            size: 30,
          ),
        ));
  }

  Widget _buildChatBoxFile(message) {
    return Align(
        alignment: _setAlignmentUserType(message.userType),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Image.file(
            File(message.messageContent),
            width: 120.0,
            height: 120.0,
            fit: BoxFit.fitHeight,
          ),
        ));
  }

  Alignment _setAlignmentUserType(userType) {
    return userType == UserType.receiver
        ? Alignment.topLeft
        : Alignment.topRight;
  }
}
