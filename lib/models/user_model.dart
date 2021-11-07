class UserModel {
  String id;
  String name;
  String email;
  String? token;
  String? avatar;
  String? status;
  String? lastSeen;
  String? lastMessage;
  bool? isSeen;
  String? socketId;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      this.token,
      this.avatar,
      this.status,
      this.lastSeen,
      this.lastMessage,
      this.isSeen,
      this.socketId});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    final name = data["name"];
    final email = data["email"];
    final id = data["id"] ?? data["_id"];
    final token = data["token"];
    final avatar = data["avatar"];
    final status = data["status"];
    final lastSeen = data["lastSeen"];
    final lastMessage = data["lastMessage"];
    final isSeen = data["isSeen"];
    final socketId = data["socketId"];
    return UserModel(
        name: name,
        email: email,
        id: id,
        token: token,
        avatar: avatar,
        status: status,
        lastSeen: lastSeen,
        lastMessage: lastMessage,
        isSeen: isSeen,
        socketId: socketId);
  }
}
