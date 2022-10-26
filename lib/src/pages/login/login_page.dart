import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_lunch/src/pages/login/login_controller.dart';
import 'package:pay_lunch/src/utils/text_frave.dart';

class LoginPages extends StatelessWidget {

  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [

              Stack(
                children: [
                  Container(
                    height: 209,
                    color: Colors.lightBlue[900],
                  ),

                  Positioned(
                    top: 111,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,

                      ),
                    ),
                  ),

                  Positioned(
                    top: 111,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[900],
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.0)),
                          border: Border.all(color: Color(0xff01579B), width: 0)
                      ),
                    ),
                  ),


                  Positioned(
                    top: 160,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0)),
                          border: Border.all(color: Colors.white)
                      ),
                    ),
                  ),

                  Positioned(
                    top: 55,
                    left: 20,
                    child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(9.0),
                          child: Image.asset('assets/img/logo2.png',),
                        )
                    ),
                  ),

                  Positioned(
                      top: 80,
                      left: 170,
                      child: const TextFrave(text: 'Bienvenido', fontSize: 25, color: Colors.white)
                  ),
                ],
              ),



              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  controller: con.emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Usuario',
                      suffixIcon: Icon(Icons.account_circle_outlined)
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  controller: con.passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Contraseña',
                      suffixIcon: Icon(Icons.lock)
                  ),
                ),
              ),

              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[900],
                      borderRadius: BorderRadius.circular(7.0)
                  ),
                  child: TextButton(
                    child: const TextFrave(text: 'Iniciar sesion', color: Colors.white, fontSize: 22 ),
                    onPressed: () => con.login(),
                  ),
                ),
              ),


            ],
          ),
        )
    );
  }
}




