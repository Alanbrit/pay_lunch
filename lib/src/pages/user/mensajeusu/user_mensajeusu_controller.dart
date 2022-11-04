import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_lunch/src/models/user.dart';
import 'package:pay_lunch/src/providers/user_provider.dart';

class UserMensajeListController extends GetxController{
  List<User> user = [];
  UserProvider userProvider = UserProvider();
  User user1 = User.fromJson(GetStorage().read('user') ?? {});



  Future<List<User>> getUsers() async {
    user = await userProvider.findBySchool(user1.idEscuela ?? '');
    return user;
  }


}