import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserStripePayment extends GetConnect{
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(BuildContext context, String saldo) async {
    try{
      paymentIntentData = await createPaymentIntent(saldo, 'USD');
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
      await Stripe.instance.presentPaymentSheet().then((value) {
        Get.snackbar('Transaccion exitosa', 'Tu pago fue procesado correctamente');
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