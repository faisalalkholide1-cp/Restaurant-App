import 'package:ecommercetwoexample/controller/usersetting_controller.dart';
import 'package:ecommercetwoexample/core/constractor/color.dart';
import 'package:ecommercetwoexample/core/constractor/linkapi.dart';
import 'package:ecommercetwoexample/core/service/apiservice.dart';
import 'package:ecommercetwoexample/data/model/usersettingmodel.dart';
import 'package:ecommercetwoexample/view/widget/editrest/castumtextformedit.dart';
import 'package:flutter/material.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  TextEditingController password = TextEditingController();

  TextEditingController restaurantId = TextEditingController();
  TextEditingController userName = TextEditingController();
  List restaurants = [];
  String? selectedRestaurantId;
  String? selectedRestaurantName;

  String? role;

  final controller = UserController();

  @override
  void initState() {
    super.initState();
    getRestu();
  }

  getRestu() async {
    var re = await Apiservice.getRequest(LinkApi.getRestom);

    setState(() {
      restaurants = re['active'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "إضافة مستخدم",
          style: TextStyle(
              color: AppColor.textColorButton, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          MaterialButton(
            textColor: AppColor.textColorButton,
            onPressed: () async {
              if (userName.text.isEmpty ||
                  password.text.isEmpty ||
                  role == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("لا يمكن ان تكون الحقول فارغة",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    backgroundColor: Color.fromARGB(255, 255, 1, 1),
                    duration: Duration(seconds: 3),
                  ),
                );
              } else {
                var response = await controller.addUser(
                    UserSettingModel(
                      username: userName.text,
                      password: password.text,
                      role: role!,
                      restaurantId: selectedRestaurantId,
                    ),
                    LinkApi.addUser);
                if (response["status"] == "Success") {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("تم الحفظ بنجاح",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {}
              }
            },
            child: const Row(
              children: [
                Icon(Icons.save),
                Text(
                  "حفظ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            CastumTextFormEdit(
              hinttext: "اسم المستخدم",
              text: "اسم المستخدم",
              mycontroller: userName,
            ),
            const SizedBox(height: 20),
            CastumTextFormEdit(
              hinttext: "كلمة المرور",
              text: "كلمة المرور",
              mycontroller: password,
            ),
            const SizedBox(height: 10),
            Card(
              child: DropdownButtonFormField(
                hint: const Text("دور المستخدم"),
                value: role,
                items: ["admin", "cashier", "kitchen", "superadmin"]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  role = val!;
                },
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: DropdownButton<String>(
                hint: const Text("المطعم"),
                value: selectedRestaurantId,
                isExpanded: true,
                items: restaurants.map<DropdownMenuItem<String>>((restaurants) {
                  return DropdownMenuItem<String>(
                      value: restaurants["id"],
                      child: Text(restaurants["name"]));
                }).toList(),
                onChanged: (val) {
                  setState(() {});
                  selectedRestaurantId = val.toString();
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
