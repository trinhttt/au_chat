import 'dart:convert';

import 'package:au_chat/common/colors.dart';
import 'package:au_chat/provider/api_service.dart';
import 'package:au_chat/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:au_chat/screens/home_screen.dart';
import 'package:au_chat/common/converts/hash_convert.dart';
import 'package:au_chat/common/local_storage.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    LocalStorage local = LocalStorage();

    // Show alert
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        // title: Text("AlertDialog"),
        content: Text(
          "Email or password is not correct!",
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          cancelButton,
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
                margin: EdgeInsets.only(bottom: 30.0, top: 60.0),
                height: 130,
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
                  height: 210,
                  width: width,
                  // color: Colors.red,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          height: 50,
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: email,
                            // Set up keyboard email
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              filled: true,
                              // border: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
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
                          height: 50,
                          // color: Colors.yellow,
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: password,
                            // Set input type password
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            // End Set input type password
                            decoration: InputDecoration(
                              isCollapsed: true,
                              filled: true,
                              // border: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
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
                            height: 50,
                            width: double.infinity,
                            // color: Colors.red,
                            // margin: ,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        side: BorderSide(color: Colors.blue))),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.blue),
                              ),
                              onPressed: () async {
                                await APIService.login(email.text, password.text);
                                // await APIService.login("trinh@gmail.com", "password");

                                // var contents = await local.readLocal();
                                // // decode string to object
                                // var data = json.decode(contents!);
                                // if (email.text == data['email'] &&
                                //     generateMd5(password.text) ==
                                //         data['password']) {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => HomeScreen()),
                                //   );
                                // } else {
                                //   showAlertDialog(context);
                                // }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeScreen())
                                );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
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
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                        transitionDuration:
                        Duration.zero;
                      },
                      child: const Text('Create account!'),
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
