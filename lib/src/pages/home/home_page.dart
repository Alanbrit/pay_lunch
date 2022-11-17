import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_lunch/src/pages/home/home_controller.dart';
import 'package:pay_lunch/src/pages/login/prueba_page.dart';
import 'package:pay_lunch/src/pages/user/profile/info/user_profile_info_page.dart';
import 'package:pay_lunch/src/utils/custom_animated_bottom_bar.dart';

import '../user/products/user_menu_list_page.dart';
import '../user/mensajeusu/user_mensajeusu_page.dart';

class HomePage extends StatelessWidget {

  HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottonBar(),
      body: Obx(() => IndexedStack(
        index: con.indexTab.value,
        children: [
          PruebaPage(),
          UserMensajeListPage(),
          UserMenuListPage(),
          UserProfileInfoPage(),
          PruebaPage()
        ],
      )),
    );
  }

  Widget _bottonBar(){
    return Obx(() => CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.lightBlue.shade900,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      selectedIndex: con.indexTab.value,
      onItemSelected: (index) => con.changeTab(index),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.message),
          title: Text('Mensaje'),
          activeColor: Colors.white,
          inactiveColor: Colors.black87
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.contact_page),
            title: Text('Usuarios'),
            activeColor: Colors.white,
            inactiveColor: Colors.black87
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.restaurant_menu),
            title: Text('Menu'),
            activeColor: Colors.white,
            inactiveColor: Colors.black87
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
            activeColor: Colors.white,
            inactiveColor: Colors.black87
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.payment),
            title: Text('Pagos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black87
        )
      ],
    ));
  }
}
