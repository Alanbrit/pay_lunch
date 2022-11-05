import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/user.dart';
import 'package:pay_lunch/src/pages/home/home_page.dart';
import 'package:pay_lunch/src/pages/login/login_page.dart';
import 'package:pay_lunch/src/pages/user/profile/info/user_profile_info_page.dart';
import 'package:pay_lunch/src/pages/user/profile/update/user_profile_update_page.dart';
import 'package:pay_lunch/src/pages/user/messages/user_messages_page.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pay Lunch',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id !=null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPages()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/user/profile/info', page: () => UserProfileInfoPage()),
        GetPage(name: '/user/profile/update', page: () => UserProfileUpdatePage()),
        GetPage(name: '/messages', page: () => MessagesPage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.lightBlue[900],
        colorScheme: ColorScheme(
          primary: Colors.lightBlue.shade900,
          secondary: Colors.lightBlue.shade800,
          brightness: Brightness.light,
          onBackground: Colors.grey,
          onPrimary: Colors.grey,
          surface: Colors.grey,
          onSurface: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          onSecondary: Colors.grey,
          background: Colors.grey
        )
      ),
      navigatorKey: Get.key ,
    );
  }
}
