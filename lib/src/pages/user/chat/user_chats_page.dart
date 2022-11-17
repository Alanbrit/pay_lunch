import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:pay_lunch/src/pages/user/chat/user_chats_controller.dart';
import 'package:pay_lunch/src/models/chat.dart';
import 'package:pay_lunch/src/utils/relative_time_util.dart';

class ChatsPage extends StatelessWidget {

  ChatsController con = Get.put(ChatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de mensajes',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Obx( () =>
        SafeArea(
          child: ListView(
            children: getChats(),
          ),
        ),
      ),
    );
  }

  List<Widget> getChats() {
    return con.chats.map((chat) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: cardUser(chat),
      );
    }).toList();
  }

  Widget cardUser(Chat chat) {
    return ListTile(
      onTap: () => con.goToChat(chat),
      title: Text(chat.idUser1 == con.myUser.id ? chat.nameUser2 ?? '' : chat.nameUser1 ?? ''),
      subtitle: Text(chat.lastMessage ?? ''),
      trailing: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 7),
            child: Text(
              RelativeTimeUtil.getRelativeTime(chat.lastMessageTimestamp ?? 0),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500]
              ),
            ),
          ),
          chat.unreadMessage! > 0 ? circleMessageUnread(chat.unreadMessage ?? 0) : SizedBox(height: 0)
        ],
      ),
      leading: Container(
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
    );
  }

  Widget circleMessageUnread(int number){
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 25,
          width: 25,
          color: Colors.lightBlue[900],
          alignment: Alignment.center,
          child: Text(
            number.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

}
