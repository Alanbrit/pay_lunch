import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/user.dart';

class UserProfileInfoController extends GetxController{
  var user = User.fromJson(GetStorage().read('user') ?? {}).obs;
  void singOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
   void goToProfileUpdate() {
    Get.toNamed('/user/profile/update');
   }



}