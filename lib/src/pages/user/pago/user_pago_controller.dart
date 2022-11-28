import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/response_api.dart';
import 'package:pay_lunch/src/models/user.dart';
import 'package:pay_lunch/src/pages/user/profile/info/user_profile_info_controller.dart';
import 'package:pay_lunch/src/pages/user/stripe/payment/user_stripe_payment.dart';
import 'package:pay_lunch/src/providers/user_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../models/user.dart';
class UserPagoController extends GetxController{
  User user = User.fromJson(GetStorage().read('user'));
  UserProvider userProvider = UserProvider();
  UserProfileInfoController userProfileInfoController = Get.find();
  UserStripePayment stripePayment = UserStripePayment();
  Map<String, dynamic>? paymentIntentData;

  TextEditingController numberController = TextEditingController();

  void updateInfo(BuildContext context) async {
    String saldo = numberController.text;
    makePayment(context, saldo);
  }
  void updatePay(BuildContext context) async {
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
  Future<void> makePayment(BuildContext context, String saldo) async {
    try{
      paymentIntentData = await createPaymentIntent(saldo, 'MXN');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'PayLunch'
          )
      ).then((value) {
      });
      showPaymentSheet(context);
    }catch(err){
      print('Error: $err');
    }
  }

  showPaymentSheet(BuildContext context) async {
    try{
      await Stripe.instance.presentPaymentSheet().then((value) async {
        Get.snackbar('Transaccion exitosa', 'Tu pago fue procesado correctamente');
        updatePay(context);
        paymentIntentData = null;
      }).onError((error, stackTrace){
        print('Error con la transacción: $error - $stackTrace');
      });
    }on StripeException catch(err){
      print('Error: ${err}');
      showDialog(context: context, builder: (value) => AlertDialog(
        content: Text('Operación cancelada'),
      ));
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51M8AHNLyLP3vlRqw6HcuoVCtN4x0XFrhtMsfVpsZsoues7UJ8KRYoeDEk2oFSkNWat09Eo6F7csDkvsKi3kwzKI800fT1wRax8',
            'Content-Type': 'application/x-www-form-urlencoded'
          }
      );
      print('payment intent body ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch(err){
      print('Error: ${err.toString()}');
    }
  }
  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}