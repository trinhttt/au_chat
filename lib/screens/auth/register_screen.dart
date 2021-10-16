import 'dart:convert';

import 'package:au_chat/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:au_chat/screens/auth/login_screen.dart';
import 'package:au_chat/common/converts/hash_convert.dart';
import 'package:au_chat/common/local_storage.dart';

import '../home_screen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    LocalStorage local = LocalStorage();
    final name = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();

    saveLocalData(name, email, password) async {
      var test = {
        'name': name,
        'email': email,
        'password': generateMd5(password),
      };
      // Encode object to string to save
      var data = json.encode(test);
      // Save local string
      await local.writeLocal(data);
    }

    // Show alert
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: Text("Go to Login"),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, _, __) => LoginScreen(),
              transitionDuration: Duration.zero,
            ),
          );
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        // title: Text("AlertDialog"),
        content: Text(
          "Create account success!",
          style: TextStyle(color: Colors.green),
        ),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      // fix When the keyboard appears, the Flutter widgets resize.
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AUColors.themeColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30.0, top: 30.0),
                height: 100,
                width: double.infinity,
                // child: Image(image: AssetImage('assets/images/logo.png'), fit: BoxFit.cover,),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 5.0, right: 5.0),
                  height: 340,
                  width: width,
                  // color: Colors.red,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Colors.white,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey,
                    //     // offset: Offset(0, 10),
                    //     blurRadius: 10,
                    //     spreadRadius: 0.5,
                    //   ),
                    // ],
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          height: 60,
                          // color: Colors.red,
                          // margin: ,
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                              filled: true,
                              // border: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              // fillColor: Color(0xFFE8E8E8),
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person, color: Colors.white),
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                color: Colors.white
                              ),
                              // disabledBorder: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 60,
                          // color: Colors.yellow,
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextField(
                            controller: email,
                            // Set up keyboard email
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              // border: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              // fillColor: Color(0xFFE8E8E8),
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email, color: Colors.white),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Colors.white
                              ),
                              // disabledBorder: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 60,
                          // color: Colors.yellow,
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextField(
                            controller: password,
                            // Set input type password
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            // End Set input type password
                            decoration: InputDecoration(
                              filled: true,
                              // border: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              // fillColor: Color(0xFFE8E8E8),
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.password, color: Colors.white),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.white
                              ),
                              // disabledBorder: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                            height: 60,
                            width: double.infinity,
                            // color: Colors.red,
                            // margin: ,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        side: BorderSide(color: Colors.black))),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
                              ),
                              onPressed: () async {
                                if (name.text.length > 0 &&
                                    email.text.length > 0 &&
                                    password.text.length > 0) {
                                  await saveLocalData(
                                      name.text, email.text, password.text);
                                  var contents = await local.readLocal();
                                  print('read local: $contents');
                                  showAlertDialog(context);
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => LoginScreen(),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: const Text('Sign in!!'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
