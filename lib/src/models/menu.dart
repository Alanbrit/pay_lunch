import 'dart:convert';

Menu menuFromJson(String str) => Menu.fromJson(json.decode(str));

String menuToJson(Menu data) => json.encode(data.toJson());

class Menu {
  String? id;
  String? dia;
  String? guisado;
  String? sopaGuarnicion;
  String? agua;
  String? postre;
  String? idEscuela;
  String? createdAt;
  String? updatedAt;

  Menu({
    this.id,
    this.dia,
    this.guisado,
    this.sopaGuarnicion,
    this.agua,
    this.postre,
    this.idEscuela,
    this.createdAt,
    this.updatedAt,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    id: json["id"],
    dia: json["dia"],
    guisado: json["guisado"],
    sopaGuarnicion: json["sopa_guarnicion"],
    agua: json["agua"],
    postre: json["postre"],
    idEscuela: json["id_escuela"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  static List<Menu> fromJsonList(List<dynamic> jsonList) {
    List<Menu> toList = [];

    jsonList.forEach((item) {
      Menu menu = Menu.fromJson(item);
      toList.add(menu);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "dia": dia,
    "guisado": guisado,
    "sopa_guarnicion": sopaGuarnicion,
    "agua": agua,
    "postre": postre,
    "id_escuela": idEscuela,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
