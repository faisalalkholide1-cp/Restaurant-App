import 'package:ecommercetwoexample/controller/usersetting_controller.dart';
import 'package:ecommercetwoexample/core/constractor/color.dart';
import 'package:ecommercetwoexample/core/constractor/linkapi.dart';
import 'package:flutter/material.dart';
import 'add_user_view.dart';
import 'edit_user_view.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  UserController controller = UserController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller.fetchUsers(LinkApi.selectUsers).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "إعدادات المستخدمين",
          style: TextStyle(
              color: AppColor.textColorButton, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.buttonColor,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddUserView()),
          );
          setState(() {
            isLoading = true;
          });
          await controller.fetchUsers(LinkApi.selectUsers);
          setState(() {
            isLoading = false;
          });
        },
        child:const Icon(
          Icons.add,
          color: AppColor.backgroundcolor,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.users.isEmpty
              ? const Center(child: Text("لا يوجد مستخدمين"))
              : ListView.builder(
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) {
                    var user = controller.users[index];

                    return Card(
                      margin:const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColor.buttonColor,
                          child: Text(
                            user.username[0].toUpperCase(),
                            style:const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(user.username),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Role: ${user.role}"),
                            Text(
                              "Restaurant: ${user.restaurantName ?? "No Restaurant"}",
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          color: AppColor.buttonColor,
                          icon:const Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditUserView(user: user),
                              ),
                            );

                            setState(() {
                              isLoading = true;
                            });
                            await controller.fetchUsers(LinkApi.selectUsers);
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
