import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_lunch/src/pages/user/messages/user_messages_controller.dart';

class MessagesPage extends StatelessWidget {

  MessagesController con = Get.put(MessagesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 246, 248, 1),
      body: Column(
        children: [
          customAppBar(),
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                child: ListView(
                  children: [],
                ),
              )
          ),
          messagesBox(context)
        ],
      ),
    );
  }

  Widget messagesBox(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 15,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
              flex: 10,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Escribe tu mensaje...',
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20)
                ),
              )
          ),
          Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
              )
          )
        ],
      ),
    );
  }

  Widget customAppBar() {
    return SafeArea(
      child: ListTile(
        title: Text(
          '${con.userChat.name ?? ''} ${con.userChat.apellidos ?? ''}',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(
          'Desconectado',
          style: TextStyle(
            color: Colors.grey
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        trailing: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: AspectRatio(
            aspectRatio: 1,
            child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/img/user_profile_2.png',
                image: 'https://bysperfeccionoral.com/wp-content/uploads/2020/01/136-1366211_group-of-10-guys-login-user-icon-png.jpg'
            ),
          ),
        ),
      ),
    );
  }
}
