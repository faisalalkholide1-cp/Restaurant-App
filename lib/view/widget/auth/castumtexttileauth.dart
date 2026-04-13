import 'package:flutter/material.dart';

class CastumTextTileAuth extends StatelessWidget {
  final String text;
  const CastumTextTileAuth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
