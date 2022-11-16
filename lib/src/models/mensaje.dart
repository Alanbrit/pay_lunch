import 'dart:convert';

Mensaje mensajeFromJson(String str) => Mensaje.fromJson(json.decode(str));

String mensajeToJson(Mensaje data) => json.encode(data.toJson());

class Mensaje {
  String? id;
  String? contenido;
  String? idEmisor;
  String? idReceptor;
  String? idChat;
  String? status;
  int? timestamp;

  Mensaje({
    this.id,
    this.contenido,
    this.idEmisor,
    this.idReceptor,
    this.idChat,
    this.status,
    this.timestamp,
  });


  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
    id: json["id"],
    contenido: json["contenido"],
    idEmisor: json["id_emisor"],
    idReceptor: json["id_receptor"],
    idChat: json["id_chat"],
    status: json["status"],
    timestamp: json["timestamp"],
  );

  static List<Mensaje> fromJsonList(List<dynamic> jsonList) {
    List<Mensaje> toList = [];

    jsonList.forEach((item) {
      Mensaje mensaje = Mensaje.fromJson(item);
      toList.add(mensaje);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "contenido": contenido,
    "id_emisor": idEmisor,
    "id_receptor": idReceptor,
    "id_chat": idChat,
    "status": status,
    "timestamp": timestamp,
  };
}