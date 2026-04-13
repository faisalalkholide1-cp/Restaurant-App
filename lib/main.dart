import 'package:ecommercetwoexample/core/constractor/color.dart';
import 'package:ecommercetwoexample/controller/restaurantprovider_controller.dart';
import 'package:ecommercetwoexample/controller/user_auth_controller.dart';
import 'package:ecommercetwoexample/view/scrol/bottomnavigation.dart';
import 'package:ecommercetwoexample/view/scrol/home.dart';
import 'package:ecommercetwoexample/view/scrol/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => RestaurantProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: AppColor.buttonColor),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            bodyLarge: TextStyle(
                height: 2, color: AppColor.grey, fontWeight: FontWeight.bold),
          )),
      home: const Login(),
      routes: {
        "home": (context) => const Home(),
        "BottomNavigationBarHome": (context) => const BottomNavigationBarHome(),
      },
    );
  }
}
