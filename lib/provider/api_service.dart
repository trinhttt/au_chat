import 'dart:convert';

import 'package:au_chat/common/api_config.dart';
import 'package:http/http.dart' as http;

class APIService {
  static String token = '';
  static String email = '';
  static String id = '';
  static String userIdCurrent = '';
  static login(emailInput, password) async {
    print(emailInput);
    print(password);
    var uri = Uri.https('au-chat-server.herokuapp.com', APIConfig.baseURLRouteLogin);
    print(uri);
    final response = await http.post(uri, body: {'email': emailInput, 'password': password});
    print(response.body);
    final data = jsonDecode(response.body) as dynamic;
    token = data['data']['token'];
    email = emailInput;
    print(token);
  }

  static getUsers() async {
    var uri = Uri.https('au-chat-server.herokuapp.com', '/user/list');
    print('email $email');
    final response = await http.get(uri, headers: {
      'authorization': 'Bearer ' + token
    });
    print(response.body);
    final data = jsonDecode(response.body) as dynamic;
    final users = data['data'] as List;
    final userCurrent = users.where((element) => element['email'] == email).toList();
    userIdCurrent = userCurrent[0]['_id'];
    print('userIdCurrent $userIdCurrent');
    final userChat = users.where((element) => element['email'] != email).toList();
    print('userChat $userChat');
    return userChat;
  }
}