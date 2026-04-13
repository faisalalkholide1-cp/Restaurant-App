import 'package:flutter/material.dart';

class CastumImgLogoAuth extends StatelessWidget {
  final String textImg;
  const CastumImgLogoAuth({super.key, required this.textImg});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      textImg,
      height: 100,
      width: 100,
    );
  }
}
