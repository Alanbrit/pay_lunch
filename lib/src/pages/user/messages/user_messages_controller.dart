import 'package:get/get.dart';
import '../../../models/user.dart';

class MessagesController extends GetxController{
  User userChat = User.fromJson(Get.arguments['user']);

  MessagesController(){
    print('Usuario chat: ${userChat.toJson()}');
  }
}