import 'package:ecommercetwoexample/core/constractor/color.dart';
import 'package:ecommercetwoexample/core/constractor/linkapi.dart';
import 'package:ecommercetwoexample/core/service/apiservice.dart';
import 'package:ecommercetwoexample/controller/user_auth_controller.dart';
import 'package:ecommercetwoexample/main.dart';
import 'package:ecommercetwoexample/view/widget/auth/castumimglogoauth.dart';
import 'package:ecommercetwoexample/view/widget/auth/castumtextbodyauth.dart';
import 'package:ecommercetwoexample/view/widget/auth/castumtexttileauth.dart';
import 'package:ecommercetwoexample/view/widget/auth/textform.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  login() async {
    if (username.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "لا يمكن ان يكون اسم المستخدم او كلمة المرور فارغ",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    } else {
      if (formstate.currentState!.validate()) {
        var response = await Apiservice.postRequest(LinkApi.linkLogin,
            {"username": username.text, "password": password.text});
        if (response['status'] == "Success") {
          if (sharedPref!.getBool("remmberMe") == true) {
            sharedPref!.setString("id", response['data']['id'].toString());
            sharedPref!.setString("role", response['data']['role'].toString());
            sharedPref!
                .setString("username", response['data']['username'].toString());

            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false).login(
              response['data']['username'],
              response['data']['role'],
            );
          } else {
            sharedPref!.remove("role");
            sharedPref!.remove("username");
            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false).login(
              response['data']['username'],
              response['data']['role'],
            );
          }
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamedAndRemoveUntil(
              "BottomNavigationBarHome", (route) => false);
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "كلمة السر او اسم المستخدم خطاء او المستخدم غير موجود",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ));
        }
      }
    }
  }

  @override
  void initState() {
    if (sharedPref!.getBool("remmberMe") == true) {
      username.text = sharedPref!.getString("username") ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var data = Provider.of<Data>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.buttonColor,
        title: const Text(
          "تسجيل الدخول",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColor.textColorButton),
        ),
        centerTitle: true,
        forceMaterialTransparency: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    const CastumImgLogoAuth(
                      textImg: "images/1.png",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CastumTextTileAuth(
                      text: "مرحباَ بعودتك",
                    ),
                    const CastumTextBodyAuth(
                      text: "سجل الدخول باستخدام اسم المستخدم و كلمة السر",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextformSign(
                      mycontroller: username,
                      hinttext: 'ادخل اسم المستخدم',
                      text: "اسم المستخدم",
                      icon: Icons.person_2_outlined,
                    ),
                    CustomTextformSign(
                      mycontroller: password,
                      hinttext: 'ادحل كلمة السر',
                      text: "كلمة السر",
                      icon: Icons.lock_open_outlined,
                    ),
                    CheckboxListTile(
                        title: const Text("تذكرني"),
                        value: sharedPref!.getBool("remmberMe") ?? false,
                        onChanged: (val) {
                          setState(() {
                            // remmberMe = val!;
                            sharedPref!.setBool("remmberMe", val!);
                          });
                        }),
                    MaterialButton(
                      color: AppColor.buttonColor,
                      textColor: AppColor.textColorButton,
                      onPressed: () async {
                        await login();
                      },
                      child: const Text("تسجيل الدخول"),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
