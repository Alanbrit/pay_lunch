import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:pay_lunch/src/pages/user/mensajeusu/user_mensajeusu_controller.dart';

import '../../../models/user.dart';

class UserMensajeListPage extends StatelessWidget {
  UserMensajeListController con = Get.put(UserMensajeListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de usuarios'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue[900],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: con.getUsers(),
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.isNotEmpty == true) {
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (_, index) {
                      return cardUser(snapshot.data![index]);
                    }
                );
              }
              else {
                return Container();
              }
            }
            else {
              return Container();
            }
          }
    ),
      ),
    );
  }

  Widget cardUser(User user) {
    return ListTile(
      title: Text(user.name ?? ''),
      subtitle: Text(user.email ?? ''),
      leading: Image.asset('assets/img/img.png'),
    );
  }

}