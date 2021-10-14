import 'package:au_chat/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'detail_chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeSreen(),
    );
  }
}