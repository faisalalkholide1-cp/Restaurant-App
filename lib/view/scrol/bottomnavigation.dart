import 'package:ecommercetwoexample/core/constractor/color.dart';
import 'package:ecommercetwoexample/view/scrol/restmanagmint.dart';
import 'package:ecommercetwoexample/view/scrol/usersettings.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class BottomNavigationBarHome extends StatefulWidget {
  const BottomNavigationBarHome({super.key});

  @override
  State<BottomNavigationBarHome> createState() => _MainScreenState();
}

class _MainScreenState extends State<BottomNavigationBarHome> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const Home(),
    const RestManagmint(),
    const UserListView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: AppColor.buttonColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "الرئيسية",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: "المطاعم",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "الإعدادات",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
