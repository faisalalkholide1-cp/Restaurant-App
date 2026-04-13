import 'package:flutter/material.dart';

class CustomTextformSign extends StatelessWidget {
  final String hinttext;
  final String text;
  final IconData? icon;
  final TextEditingController mycontroller;
  // final String? Function(String?) valids;
  const CustomTextformSign(
      {super.key,
      required this.hinttext,
      required this.mycontroller,
      // required this.valids,
      required this.text, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          // validator: valids,
          controller: mycontroller,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            hintText: hinttext,
            hintStyle: const TextStyle(fontSize: 14),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(text)),
            suffixIcon: Icon(icon),
            border: OutlineInputBorder(
                // borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(30)),
          ),
        ));
  }
}
