import 'package:ecommercetwoexample/data/model/usersettingmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Apiservice {
  static postRequest(String url, Map data) async {
    // await Future.delayed(Duration(seconds: 2));// تاخير 2 ثواني
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        if (responsebody == null) {
          return;
        }
        return responsebody;
      } else {
      }
    } catch (e) {
      return {"status": "fail", "message": "Connection Error"};
    }
  }

  static Future<Map<String, dynamic>> getRequest(String url) async {
    try {
      var response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        return responsebody;
      } else {
        return {
          "status": "fail",
          "message": "Server Error ${response.statusCode}"
        };
      }
    } catch (e) {

      return {"status": "fail", "message": "Connection Error"};
    }
  }
  static Future<List<UserSettingModel>> get(String url) async {
    var response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body);

    List list = data['active'];

    return list.map((e) => UserSettingModel.fromJson(e)).toList();
  }
}
