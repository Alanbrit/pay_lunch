import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pay_lunch/src/models/response_api.dart';
import 'package:pay_lunch/src/pages/home/home_controller.dart';
import 'package:pay_lunch/src/providers/mensaje_provider.dart';
import '../../../models/chat.dart';
import '../../../models/user.dart';
import '../../../models/mensaje.dart';
import 'package:get_storage/get_storage.dart';

import '../../../providers/chat_provider.dart';

class MessagesController extends GetxController{
  TextEditingController mensajeController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<Chat> chat = [];
  String idChat = '';
  List<Mensaje> mensajes = <Mensaje>[].obs;
  User userChat = User.fromJson(Get.arguments['user']);
  User myUser = User.fromJson(GetStorage().read('user') ?? {});

  ChatProvider chatProvider = ChatProvider();
  MensajeProvider mensajeProvider = MensajeProvider();

  HomeController homeController = Get.find();

  void listenMensaje(){
    homeController.socket.on('message/$idChat', (data) {
      print('DATA EMITIDA $data');
      getMensajes();
    });
  }

  void listenMensajeSeen(){
    homeController.socket.on('seen/$idChat', (data) {
      print('DATA EMITIDA $data');
      getMensajes();
    });
  }

  void emitMensaje(){
    homeController.socket.emit('message', {
      'id_chat': idChat
    });
  }
  void emitMensajeSeen(){
    homeController.socket.emit('seen', {
      'id_chat': idChat,
      'id_user': userChat.id
    });
  }

  Future<List<Chat>> findById() async {
    chat = await chatProvider.findById(userChat.id ?? '0', myUser.id ?? '0', myUser.id ?? '0', userChat.id ?? '0');
    return chat;
  }

  Future getList() async{
    List<Chat> chat = await findById();
    if(chat.length == 0){
      createChat();
    }else{
      String jsonChat = jsonEncode(chat);
      final jsonChat1 = jsonDecode(jsonChat);
      idChat = jsonChat1[0]['id'];
      getMensajes();
      listenMensaje();
      listenMensajeSeen();
    }
  }

  void getMensajes() async {
    var result = await mensajeProvider.findByChat(idChat);
    mensajes.clear();
    mensajes.addAll(result);

    mensajes.forEach((m) async {
      if(m.status != 'VISTO' && m.idReceptor == myUser.id){
        await mensajeProvider.updateToSeen(m.id!);
        emitMensajeSeen();
      }
    });

    Future.delayed(Duration(milliseconds: 100), (){
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    });
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
    //Get.snackbar('Chat creado', responsiveApi.message ?? 'Error en la respuesta');
  }

  void sendMensaje() async {
    String mensajeText = mensajeController.text;
    if(mensajeText.isEmpty) {
      Get.snackbar('Texto vacio', 'Ingrese el mensaje que quiere enviar');
      return;
    }
    if(idChat.isEmpty) {
      Get.snackbar('Error', 'No se pudo enviar el mensaje');
      return;
    }
    Mensaje mensaje = Mensaje(
      contenido: mensajeText,
      idEmisor: myUser.id,
      idReceptor: userChat.id,
      idChat: idChat,
    );
    ResponsiveApi responsiveApi = await mensajeProvider.create(mensaje);
    if (responsiveApi.success == true){
      mensajeController.text = '';
      emitMensaje();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
    homeController.socket.off('message/$idChat');
    homeController.socket.off('seen/$idChat');
  }
}