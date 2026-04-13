import 'package:ecommercetwoexample/core/constractor/linkapi.dart';
import 'package:ecommercetwoexample/core/function/logout_function.dart';
import 'package:ecommercetwoexample/core/service/apiservice.dart';
import 'package:ecommercetwoexample/view/widget/home/castumcardhome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommercetwoexample/core/constractor/color.dart';
import 'package:ecommercetwoexample/controller/user_auth_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? active;
  int? inactive;

  @override
  void initState() {
    opencountr();
    super.initState();
  }

  opencountr() async {
    var response = await Apiservice.getRequest(LinkApi.restCount);
    if (response['status'] == "Success") {
      active = response['active'];
      inactive = response['inactive'];
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.buttonColor,
        centerTitle: true,
        title: const Text(
          "لوحة التحكم",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          MaterialButton(
              textColor: AppColor.backgroundcolor,
              onPressed: () {
                showLogoutDialog(context);
              },
              child: const Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            /// 👤 USER INFO
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.buttonColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 30),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          user.username ?? "",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          user.role ?? "",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                /// ACTIVE
                CastumCardHome(
                  title: "المطاعم المفعلة",
                  value: active ?? 0,
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),

                /// INACTIVE
                CastumCardHome(
                  title: "المطاعم الموقفة",
                  value: inactive ?? 0,
                  icon: Icons.cancel,
                  color: Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
