import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/response_api.dart';
import 'package:pay_lunch/src/models/user.dart';
import 'package:pay_lunch/src/pages/user/profile/info/user_profile_info_controller.dart';
import 'package:pay_lunch/src/pages/user/stripe/payment/user_stripe_payment.dart';
import 'package:pay_lunch/src/providers/user_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../models/user.dart';
class UserPagoController extends GetxController{
  User user = User.fromJson(GetStorage().read('user'));
  UserProvider userProvider = UserProvider();
  UserProfileInfoController userProfileInfoController = Get.find();
  UserStripePayment stripePayment = UserStripePayment();

  TextEditingController numberController = TextEditingController();


  void updateInfo(BuildContext context) async {

    String saldo = numberController.text;
    if (isValidForm(saldo)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max:100, msg: 'Actualizando datos...');
      User myUser = User(
        id: user.id,
        saldo: saldo,
        sessionToken: user.sessionToken,
      );
      ResponsiveApi responsiveApi = await userProvider.updatePay(myUser);
      print('Response Api Update: ${responsiveApi.data}');
      //Get.snackbar('Proceso terminado', responsiveApi.message ?? '');
      progressDialog.close();
      if (responsiveApi.success == true) {
        GetStorage().write('user', responsiveApi.data);
        userProfileInfoController.user.value = User.fromJson(GetStorage().read('user') ?? {});
        stripePayment.makePayment(context, saldo);
      }
      else {
        Get.snackbar('Registro fallido', responsiveApi.message ?? '');
      }
    }
  }
  bool isValidForm(
      String saldo,
      ) {
    if(saldo.isEmpty) {
      Get.snackbar('Formulario invalido', 'Debes ingresar tu nombre');
      return false;
    }
    return true;
  }
}