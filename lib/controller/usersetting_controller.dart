import 'package:ecommercetwoexample/core/service/apiservice.dart';
import 'package:ecommercetwoexample/data/model/usersettingmodel.dart';

class UserController {
  List<UserSettingModel> users = [];

  Future<void> fetchUsers(String url) async {
    users = await Apiservice.get(url);
  }

  Future addUser(UserSettingModel user, String url) async {
    var response = await Apiservice.postRequest(url, {
      "username": user.username,
      "password": user.password,
      "role": user.role,
      "restaurant_id": user.restaurantId ?? "",
    });
    return response;
  }

  Future updateUser(UserSettingModel user, String url) async {
    var response = await Apiservice.postRequest(url, {
      "id": user.id,
      "username": user.username,
      "password": user.password,
      "role": user.role,
      "restaurant_id": user.restaurantId ?? "",
    });
    return response;
  }
}
