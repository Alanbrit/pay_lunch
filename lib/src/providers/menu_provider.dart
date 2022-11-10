import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/environment/environment.dart';
import 'package:pay_lunch/src/models/response_api.dart';
import 'package:pay_lunch/src/models/user.dart';
import '../models/menu.dart';

class MenuProvider extends GetConnect{

  String url = Environment.API_URL + 'api/menus';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Menu>> findBySchool() async {
    Response response = await get(
        '$url/findBySchool/${userSession.idEscuela}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene los permisos requeridos');
      return [];
    }

    List<Menu> menu = Menu.fromJsonList(response.body);
    return menu;
  }
}