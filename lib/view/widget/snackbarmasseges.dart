import 'package:flutter/material.dart';

class SnackBarMasseges extends StatelessWidget {
  final String text;
  const SnackBarMasseges({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
    );
  }
}
