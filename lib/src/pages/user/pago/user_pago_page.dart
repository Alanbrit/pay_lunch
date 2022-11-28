import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:pay_lunch/src/pages/user/pago/user_pago_controller.dart';
import 'package:pay_lunch/src/pages/user/stripe/payment/user_stripe_payment.dart';


class UserPagoPage extends StatelessWidget {

  UserPagoController con = Get.put(UserPagoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
        ],
      ),
    );
  }
  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.lightBlue[900],
    );
  }
  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20, left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }
  Widget _textYourInfo(){
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 30),
      child: Text(
        'INGRESA EL MONTO A ABONAR',
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }

  Widget _textFieldName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: TextField(
        controller: con.numberController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Monto',
            prefixIcon: Icon(Icons.monetization_on)
        ),
      ),
    );
  }
  Widget _buttonUpdate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 90),
      child: ElevatedButton(
          onPressed: () => con.updateInfo(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'Pagar',
            style: TextStyle(
                color: Colors.white
            ),
          )
      ),
    );
  }




}