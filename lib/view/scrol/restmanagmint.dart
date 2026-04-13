import 'package:ecommercetwoexample/core/constractor/color.dart';
import 'package:ecommercetwoexample/core/constractor/linkapi.dart';
import 'package:ecommercetwoexample/core/service/apiservice.dart';
import 'package:ecommercetwoexample/controller/restaurantprovider_controller.dart';
import 'package:ecommercetwoexample/view/scrol/addnewretaurant.dart';
import 'package:ecommercetwoexample/view/scrol/editrestmmanagmint.dart';
import 'package:ecommercetwoexample/view/widget/snackbarmasseges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestManagmint extends StatefulWidget {
  const RestManagmint({super.key});

  @override
  State<RestManagmint> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestManagmint> {
  bool? result = false;
  bool? resultAdd = false;
  bool? resultEditState = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var response = await Apiservice.getRequest(LinkApi.restaurants);

    if (response['status'] == "Success") {
      // ignore: use_build_context_synchronously
      Provider.of<RestaurantProvider>(context, listen: false)
          .setData(response['active']);
    }
  }

  activStates(String stat, String id) async {
    var respons = await Apiservice.postRequest(
        LinkApi.restEditStates, {"id": id, "status": stat});
    if (respons != null && respons["status"] == "Success") {
      const SnackBarMasseges(
        text: "تم تعديل الحالة بنجاح",
      );
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    if (result != false) {
      const SnackBarMasseges(
        text: "تم التعديل  بنجاح",
      );
    } else if (resultAdd != false) {
      const SnackBarMasseges(
        text: "تم الحفظ  بنجاح",
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "إدارة المطاعم",
          style: TextStyle(
              color: AppColor.textColorButton, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColor.buttonColor,
        actions: [
          MaterialButton(
            textColor: AppColor.textColorButton,
            onPressed: () async {
              resultAdd = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>const AddNewRetaurant()));
              if (resultAdd == true) {
                setState(() {
                  getData();
                });
              }
            },
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "بحث...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (val) {
                Provider.of<RestaurantProvider>(context, listen: false)
                    .search(val);
              },
            ),
          ),
          Consumer<RestaurantProvider>(
            builder: (context, data, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _filterBtn("الكل", "all", data),
                  _filterBtn("مفعل", "active", data),
                  _filterBtn("موقف", "inactive", data),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<RestaurantProvider>(
              builder: (context, data, child) {
                if (data.filtered.isEmpty) {
                  return const Center(child: Text("لا توجد بيانات"));
                }

                return ListView.builder(
                  itemCount: data.filtered.length,
                  itemBuilder: (context, index) {
                    var rest = data.filtered[index];
                    return InkWell(
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: rest.logo.isEmpty
                                ? const Icon(Icons.restaurant_outlined)
                                : Image.network(
                                    "${LinkApi.linkserver}/${rest.logo}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          title: Text(rest.name),
                          subtitle: Text(rest.createdAt),
                          trailing: Switch(
                            value: rest.status == "active",
                            onChanged: (val) async {
                              Provider.of<RestaurantProvider>(context,
                                      listen: false)
                                  .toggleStatus(rest.id);

                              await activStates(rest.status, rest.id);
                            },
                          ),
                        ),
                      ),
                      onTap: () async {
                        result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditRestmManagmint(rest: rest)));
                        if (result == true) {
                          setState(() {
                            getData();
                          });
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ///  FILTER BUTTON
  Widget _filterBtn(String text, String value, RestaurantProvider data) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            data.filter == value ? AppColor.buttonColor : Colors.grey,
      ),
      onPressed: () {
        data.changeFilter(value);
      },
      child: Text(
        text,
        style: const TextStyle(
            color: AppColor.textColorButton, fontWeight: FontWeight.bold),
      ),
    );
  }
}
