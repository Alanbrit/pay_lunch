import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  String? id;
  String? idUser1;
  String? idUser2;
  int? timestamp;

  //Usuario 1
  String? nameUser1;
  String? apellidosUser1;
  String? emailUser1;
  String? numeroUser1;

  //Usuario 2
  String? nameUser2;
  String? apellidosUser2;
  String? emailUser2;
  String? numeroUser2;

  String? lastMessage;
  int? unreadMessage;
  int? lastMessageTimestamp;

  Chat({
    this.id,
    this.idUser1,
    this.idUser2,
    this.timestamp,
    //Usuario 1
    this.nameUser1,
    this.apellidosUser1,
    this.emailUser1,
    this.numeroUser1,
    //Usuario 2
    this.nameUser2,
    this.apellidosUser2,
    this.emailUser2,
    this.numeroUser2,

    this.lastMessage,
    this.unreadMessage,
    this.lastMessageTimestamp,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["id"],
    idUser1: json["id_user1"],
    idUser2: json["id_user2"],
    timestamp: json["timestamp"],
    //Usuario 1
    nameUser1: json["name_user1"],
    apellidosUser1: json["apellidos_user1"],
    emailUser1: json["email_user1"],
    numeroUser1: json["numero_user1"],
    //Usuario 2
    nameUser2: json["name_user2"],
    apellidosUser2: json["apellidos_user2"],
    emailUser2: json["email_user2"],
    numeroUser2: json["numero_user2"],

    lastMessage: json["last_message"],
    unreadMessage: json["unread_message"],
      lastMessageTimestamp: json["last_message_timestamp"],
  );

  static List<Chat> fromJsonList(List<dynamic> jsonList) {
    List<Chat> toList = [];

    jsonList.forEach((item) {
      Chat chat = Chat.fromJson(item);
      toList.add(chat);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user1": idUser1,
    "id_user2": idUser2,
    "timestamp": timestamp,
    //Usuario 1
    "name_user1": nameUser1,
    "apellidos_user1": apellidosUser1,
    "email_user1": emailUser1,
    "numero_user1": numeroUser1,
    //Usuario 2
    "name_user2": nameUser2,
    "apellidos_user2": apellidosUser2,
    "email_user2": emailUser2,
    "numero_user2": numeroUser2,

    "last_message": lastMessage,
    "unread_message": unreadMessage,
    "last_message_timestamp": lastMessageTimestamp,
  };
}