import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/response_api.dart';
import 'package:pay_lunch/src/providers/user_provider.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserProvider userProvider = UserProvider();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    
    print('Email ${email}');
    print('Password ${password}');

    if(isValidForm(email, password)){
      ResponsiveApi responsiveApi = await userProvider.login(email, password);
      print('Responsive Api: ${responsiveApi.toJson()}');
      if(responsiveApi.success == true) {
        GetStorage().write('user', responsiveApi.data);
        goToHomePage();
      }
      else{
        Get.snackbar('Login fallido', responsiveApi.message ?? '');
      }
    }
  }

  void goToHomePage(){
    Get.offNamedUntil('/home', (route) => false);
  }

  bool isValidForm(String email, String password){
    if(email.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el usuario');
      return false;
    }
    if(password.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar la contraseña');
      return false;
    }
    return true;
  }

  void singOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}