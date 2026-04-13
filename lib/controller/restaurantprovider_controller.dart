import 'package:ecommercetwoexample/data/model/restaurantmodel.dart';
import 'package:flutter/material.dart';

class RestaurantProvider extends ChangeNotifier {
  List<RestaurantModel> all = [];
  List<RestaurantModel> filtered = [];

  String filter = "all";

  void setData(List data) {
    all = data.map((e) => RestaurantModel.fromJson(e)).toList();
    applyFilter();
  }

  void applyFilter() {
    if (filter == "active") {
      filtered = all.where((e) => e.status == "active").toList();
    } else if (filter == "inactive") {
      filtered = all.where((e) => e.status == "inactive").toList();
    } else {
      filtered = all;
    }
    notifyListeners();
  }

  void changeFilter(String value) {
    filter = value;
    applyFilter();
  }

  void search(String text) {
    filtered = all
        .where((e) =>
            e.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void toggleStatus(String id) {
    var item = all.firstWhere((e) => e.id == id);
    item.status = item.status == "active" ? "inactive" : "active";
    applyFilter();
  }
}