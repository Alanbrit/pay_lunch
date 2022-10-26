import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  String? id;
  String? name;
  String? apellidos;
  String? numero;
  String? numero2;
  String? saldo;
  String? email;
  String? password;
  String? rol;
  String? idEscuela;
  String? idGrupo;
  String? sessionToken;

  User({
    this.id,
    this.name,
    this.apellidos,
    this.numero,
    this.numero2,
    this.saldo,
    this.email,
    this.password,
    this.rol,
    this.idEscuela,
    this.idGrupo,
    this.sessionToken
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    apellidos: json["apellidos"],
    numero: json["numero"],
    numero2: json["numero_2"],
    saldo: json["saldo"].toString(),
    email: json["email"],
    password: json["password"],
    rol: json["rol"],
    idEscuela: json["id_escuela"],
    idGrupo: json["id_grupo"],
    sessionToken: json["session_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "apellidos": apellidos,
    "numero": numero,
    "numero_2": numero2,
    "saldo": saldo,
    "email": email,
    "password": password,
    "rol": rol,
    "id_escuela": idEscuela,
    "id_grupo": idGrupo,
    "session_token": sessionToken,
  };
}