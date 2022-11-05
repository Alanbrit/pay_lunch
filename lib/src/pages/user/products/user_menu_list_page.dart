import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/menu.dart';
import 'package:pay_lunch/src/pages/user/products/user_menu_list_controller.dart';
import 'package:pay_lunch/src/pages/user/profile/info/user_profile_info_controller.dart';
import 'package:pay_lunch/src/utils/relative_time_util.dart';
class UserMenuListPage extends StatelessWidget {
  UserMenuListController con = Get.put(UserMenuListController());
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menú semanal',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Stack(
        children: [
          _listMenu(context)
        ],
      ),
    );
  }

  Widget _listMenu(BuildContext context) {
    return FutureBuilder(
        future: con.getMenus(),
        builder: (context, AsyncSnapshot<List<Menu>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (_, index) {
                  return _cardMenu(snapshot.data![index]);
                }
              );
            }
            else {
              return Center(
                child: Text('No hay datos 55'),
              );
            }
          }
          else {
            return Center(
              child: Text('No hay datos'),
            );
          }
        }
    );
  }



  Widget _cardMenu(Menu menu) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Stack(
          children: [
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlue[900],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                )
              ),
              child: Container(
                margin: EdgeInsets.only(top:5),
                child: Text(
                  menu.dia ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                      color: Colors.white
                  ),
                ),
              )
            ),
            Container(
              margin: EdgeInsets.only(top:30, left: 30, right: 30),
              child: Column(
                children: [
                  Container(
                    child: Text('Guisado: ${menu.guisado ?? ''}'),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 5),
                  ),
                  Container(
                    child: Text('Sopa: ${menu.sopaGuarnicion ?? ''}'),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 5),
                  ),
                  Container(
                    child: Text('Agua: ${menu.agua ?? ''}'),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 5),
                  ),
                  Container(
                    child: Text('Postre: ${menu.postre ?? ''}'),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 5),
                  ),
                  Container(
                    child: Text(menu.updatedAt ?? ''),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 5),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
