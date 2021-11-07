import 'dart:convert';

import 'package:au_chat/common/api_config.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  static late UserModel user;

  static login(emailInput, password) async {
    var uri =
        Uri.https('au-chat-server.herokuapp.com', APIConfig.baseURLRouteLogin);
    print(uri);
    final response =
        await http.post(uri, body: {'email': emailInput, 'password': password});
    final data = jsonDecode(response.body);
    user = UserModel.fromJson(data["data"]);
    print(user.token);
  }

  static Future<List<UserModel>> getUsers() async {
    var uri = Uri.https('au-chat-server.herokuapp.com', '/user/list');
    final response = await http
        .get(uri, headers: {'authorization': 'Bearer ' + (user.token ?? "")});

    print(response.body);
    final data = jsonDecode(response.body);
    final list = data['data'] as List;

    final users = list.map((user) {
      return UserModel.fromJson(user);
    }).toList();

    final userChat =
        users.where((element) => element.email != user.email).toList();
    print('userChat $userChat');
    return userChat;
  }
}
