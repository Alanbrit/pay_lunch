import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/user.dart';
import 'package:pay_lunch/src/models/menu.dart';
import 'package:pay_lunch/src/providers/menu_provider.dart';

class UserMenuListController extends GetxController{
  List<Menu> menu = [];
  MenuProvider menuProvider = MenuProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});



  Future<List<Menu>> getMenus() async {
    menu = await menuProvider.findBySchool(user.idEscuela ?? '');
    return menu;
  }


}