import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/user.dart';

class HomeController extends GetxController{

  var indexTab = 0.obs;

  void changeTab(int index) {
    indexTab.value = index;
  }

  void singOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}