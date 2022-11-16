import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/environment/environment.dart';
import 'package:pay_lunch/src/models/user.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeController extends GetxController{
  User user = User.fromJson(GetStorage().read('user') ?? {});
  var indexTab = 0.obs;

  Socket socket = io('${Environment.API_URL}chat', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false
  });

  void changeTab(int index) {
    indexTab.value = index;
  }

  void connectAndListen(){
    if(user.id != null){
      socket.connect();
      socket.onConnect((data) {
        print('USUARIO CONECTADO A SOCKET IO');
      });
    }
  }

  HomeController(){
    connectAndListen();
  }

  void singOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    socket.disconnect();
  }
}