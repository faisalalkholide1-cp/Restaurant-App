import 'package:ecommercetwoexample/controller/user_auth_controller.dart';
import 'package:ecommercetwoexample/main.dart';
import 'package:ecommercetwoexample/view/scrol/login.dart';
import 'package:flutter/material.dart';

void showLogoutDialog(BuildContext context) {
  UserProvider controller = UserProvider();
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('تسجيل الخروج'),
      content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
      actions: [
        TextButton(
          child: const Text('إلغاء'),
          onPressed: () => Navigator.of(ctx).pop(),
        ),
        FilledButton(
          child: const Text('خروج'),
          onPressed: () {
            controller.logout();
            sharedPref!.clear();
            Navigator.of(ctx).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Login()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ],
    ),
  );
}
