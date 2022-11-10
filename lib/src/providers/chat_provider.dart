import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/environment/environment.dart';
import 'package:pay_lunch/src/models/response_api.dart';
import 'package:pay_lunch/src/models/user.dart';

import '../models/chat.dart';

class ChatProvider extends GetConnect {

  String url = Environment.API_URL + 'api/chats';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponsiveApi> create(Chat chat) async{
    Response response = await post(
        '$url/create',
        chat.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la información');
      return ResponsiveApi();
    }
    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta petición');
      return ResponsiveApi();
    }
    ResponsiveApi responsiveApi = ResponsiveApi.fromJson(response.body);
    return responsiveApi;
  }

  Future<List<Chat>> findById(String id_user1, String id_user2, String id_user3, String id_user4) async {
    Response response = await get(
        '$url/findById/$id_user1/$id_user2/$id_user3/$id_user4',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene los permisos requeridos');
      return [];
    }

    List<Chat> chat = Chat.fromJsonList(response.body);
    return chat;
  }

  Future<ResponsiveApi> update(Chat chat) async{
    Response response = await put(
        '$url/update',
        chat.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la información');
      return ResponsiveApi();
    }
    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta petición');
      return ResponsiveApi();
    }
    ResponsiveApi responsiveApi = ResponsiveApi.fromJson(response.body);
    return responsiveApi;
  }
}