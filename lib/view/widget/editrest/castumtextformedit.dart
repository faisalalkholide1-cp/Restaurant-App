import 'package:flutter/material.dart';

class CastumTextFormEdit extends StatelessWidget {
  final String hinttext;
  final String text;
  final bool?   enable;
  final IconData? icon;
  final TextEditingController? mycontroller;
  const CastumTextFormEdit(
      {super.key,
      required this.hinttext,
      required this.text,
      this.icon,
      this.mycontroller,  this.enable});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          // validator: valids,
          enabled: enable,
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
            // suffixIcon: Icon(icon),
            border: OutlineInputBorder(
                // borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10)),
          ),
        ));
  }
}
