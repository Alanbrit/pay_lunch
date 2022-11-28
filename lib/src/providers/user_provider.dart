import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/environment/environment.dart';
import 'package:pay_lunch/src/models/response_api.dart';
import 'package:pay_lunch/src/models/user.dart';

class UserProvider extends GetConnect {

  String url = Environment.API_URL + 'api/users';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponsiveApi> login(String email, String password) async {
    Response response = await post(
      '$url/login',
      {
        'email': email,
        'password': password
      },
      headers: {
        'Content-Type': 'application/json'
      }
    );
    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la petición');
      return ResponsiveApi();
    }
    ResponsiveApi responsiveApi = ResponsiveApi.fromJson(response.body);
    return responsiveApi;
  }

  Future<ResponsiveApi> update(User user) async{
    Response response = await put(
        '$url/update',
        user.toJson(),
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

  Future<ResponsiveApi> updatePay(User user) async{
    Response response = await put(
        '$url/updatePay',
        user.toJson(),
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

  Future<List<User>> findBySchool(String id_escuela) async {
    Response response = await get(
        '$url/findBySchool/$id_escuela',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene los permisos requeridos');
      return [];
    }

    List<User> user = User.fromJsonList(response.body);
    return user;
  }

  Future<List<User>> findBySchool1(String id_escuela) async {
    Response response = await get(
        '$url/findBySchool1/$id_escuela',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene los permisos requeridos');
      return [];
    }

    List<User> user = User.fromJsonList(response.body);
    return user;
  }
}