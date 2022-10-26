import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/response_api.dart';
import 'package:pay_lunch/src/models/user.dart';
import 'package:pay_lunch/src/pages/user/profile/info/user_profile_info_controller.dart';
import 'package:pay_lunch/src/providers/user_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class UserProfileUpdateController extends GetxController{
  User user = User.fromJson(GetStorage().read('user'));
  UserProvider userProvider = UserProvider();
  UserProfileInfoController userProfileInfoController = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController numero2Controller = TextEditingController();
  TextEditingController saldoController = TextEditingController();

  UserProfileUpdateController() {
    nameController.text = user.name ?? '';
    apellidosController.text = user.apellidos ?? '';
    numeroController.text = user.numero ?? '';
    numero2Controller.text = user.numero2 ?? '';
  }

  void updateInfo(BuildContext context) async {
    String name = nameController.text;
    String apellidos = apellidosController.text;
    String numero = numeroController.text;
    String numero2 = numero2Controller.text;

    if (isValidForm(name, apellidos, numero, numero2)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max:100, msg: 'Actualizando datos...');

      User myUser = User(
        id: user.id,
        name: name,
        apellidos: apellidos,
        numero: numero,
        numero2: numero2,
        sessionToken: user.sessionToken,
      );
      ResponsiveApi responsiveApi = await userProvider.update(myUser);
      print('Response Api Update: ${responsiveApi.data}');
      Get.snackbar('Proceso terminado', responsiveApi.message ?? '');
      progressDialog.close();
      if (responsiveApi.success == true) {
        GetStorage().write('user', responsiveApi.data);
        userProfileInfoController.user.value = User.fromJson(GetStorage().read('user') ?? {});
      }
      else {
        Get.snackbar('Registro fallido', responsiveApi.message ?? '');
      }
    }
  }

  bool isValidForm(
      String name,
      String apellidos,
      String numero,
      String numero2
      ) {
    if(name.isEmpty) {
      Get.snackbar('Formulario invalido', 'Debes ingresar tu nombre');
      return false;
    }
    if(apellidos.isEmpty) {
      Get.snackbar('Formulario invalido', 'Debes ingresar tus apellidos');
      return false;
    }
    if(numero.isEmpty) {
      Get.snackbar('Formulario invalido', 'Debes ingresar tu numero');
      return false;
    }
    if(numero2.isEmpty) {
      Get.snackbar('Formulario invalido', 'Debes ingresar tu numero');
      return false;
    }
    return true;
  }
}