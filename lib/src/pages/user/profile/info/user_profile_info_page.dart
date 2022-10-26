import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_lunch/src/models/user.dart';
import 'package:pay_lunch/src/pages/user/profile/info/user_profile_info_controller.dart';
class UserProfileInfoPage extends StatelessWidget {

  UserProfileInfoController con = Get.put(UserProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _buttonSignOut()
        ],
      )),
    );
  }

  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      color: Colors.lightBlue[900],
    );
  }

  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17, left: 50, right: 50),
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
            _textName(),
            _textUser(),
            _textPhone(),
            _textPhone2(),
            _textSaldo(),
            _buttonUpdate()
          ],
        ),
      ),
    );
  }


  Widget _textName(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
        leading: Icon(Icons.supervised_user_circle),
        title: Text('${con.user.value.name ?? ''} ${con.user.value.apellidos ?? ''}'),
        subtitle: Text('Nombre del alumno'),
      ),
    );
  }

  Widget _textUser(){
    return ListTile(
        leading: Icon(Icons.account_circle_outlined),
        title: Text(con.user.value.email ?? ''),
        subtitle: Text('Usuario'),
    );
  }

  Widget _textPhone(){
    return ListTile(
        leading: Icon(Icons.phone),
        title: Text(con.user.value.numero ?? ''),
        subtitle: Text('Número telefónico'),
    );
  }

  Widget _textPhone2(){
    return ListTile(
        leading: Icon(Icons.phone),
        title: Text(con.user.value.numero2 ?? ''),
        subtitle: Text('Segundo número telefónico'),
    );
  }

  Widget _textSaldo(){
    return ListTile(
        leading: Icon(Icons.payment_outlined),
        title: Text(con.user.value.saldo ?? ''),
        subtitle: Text('Saldo'),
    );
  }


  Widget _buttonUpdate(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
          onPressed: () => con.goToProfileUpdate(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'Actualizar',
            style: TextStyle(
                color: Colors.white
            ),
          )
      ),
    );
  }

  Widget _buttonSignOut(){
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => con.singOut(),
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
    );
  }
}
