import 'package:au_chat/common/colors.dart';
import 'package:au_chat/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: AUColors.themeColor, brightness: Brightness.dark),
      home: LoginScreen(),
    );
  }
}
