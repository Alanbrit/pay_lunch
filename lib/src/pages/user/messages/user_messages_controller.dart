import 'package:get/get.dart';
import 'package:pay_lunch/src/models/response_api.dart';
import '../../../models/chat.dart';
import '../../../models/user.dart';
import 'package:get_storage/get_storage.dart';

import '../../../providers/chat_provider.dart';

class MessagesController extends GetxController{
  List<Chat> chat = [];
  User userChat = User.fromJson(Get.arguments['user']);
  User myUser = User.fromJson(GetStorage().read('user') ?? {});

  ChatProvider chatProvider = ChatProvider();

  Future<List<Chat>> findById() async {
    chat = await chatProvider.findById(userChat.id ?? '0', myUser.id ?? '0', myUser.id ?? '0', userChat.id ?? '0');
    return chat;
  }
  Future getList() async{
    List<Chat> list = await findById();
    if(list.length == 0){
      createChat();
    }else{
      return false;
    }
  }

  MessagesController(){
    print('Usuario chat: ${userChat.toJson()}');
    getList();
  }


  void createChat() async {
    Chat chat = Chat(
      idUser1: myUser.id,
      idUser2: userChat.id
    );
    ResponsiveApi responsiveApi = await chatProvider.create(chat);
    Get.snackbar('Chat creado', responsiveApi.message ?? 'Error en la respuesta');
  }
}