import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/chat.dart';
import 'package:pay_lunch/src/models/user.dart';
import 'package:pay_lunch/src/providers/chat_provider.dart';
import 'package:pay_lunch/src/providers/user_provider.dart';

import '../../home/home_controller.dart';

class ChatsController extends GetxController{
  List<Chat> chats = <Chat>[].obs;
  ChatProvider chatProvider = ChatProvider();
  User myUser = User.fromJson(GetStorage().read('user') ?? {});
  HomeController homeController = Get.find();


  ChatsController(){
    getChats();
    listenMensaje();
  }

  void getChats() async {
    var result = await chatProvider.findByIdUser(myUser.id ?? '', myUser.id ?? '', myUser.id ?? '');
    chats.clear();
    chats.addAll(result);

  }

  void listenMensaje(){
    homeController.socket.on('message/${myUser.id}', (data) {
      print('DATA EMITIDA1 $data');
      getChats();
    });
  }


  void goToChat(Chat chat){
    User user = User();
    if(chat.idUser1 == myUser.id) {
      user.id = chat.idUser2;
      user.name = chat.nameUser2;
      user.apellidos = chat.apellidosUser2;
      user.email = chat.emailUser2;
      user.numero = chat.numeroUser2;
    }
    else {
      user.id = chat.idUser1;
      user.name = chat.nameUser1;
      user.apellidos = chat.apellidosUser1;
      user.email = chat.emailUser1;
      user.numero = chat.numeroUser1;
    }
    Get.toNamed('/messages', arguments: {
      'user': user.toJson()
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    homeController.socket.off('message/${myUser.id}');
  }
}