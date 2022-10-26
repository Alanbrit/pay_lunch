import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_lunch/src/pages/login/login_controller.dart';

class PruebaPage extends StatelessWidget {

  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
            onPressed: () => con.singOut(),
            child: Text(
              'Cerrar sesion',
              style: TextStyle(
                  color: Colors.black87
              ),
            ),
          )
      ),
    );
  }
}
