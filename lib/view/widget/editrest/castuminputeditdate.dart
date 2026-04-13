import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CastumInputEditDate extends StatelessWidget {
  final Function()? onTap;
  final DateFormat dateFormatter;
  final DateTime date;
  final String text;
  const CastumInputEditDate(
      {super.key,
      this.onTap,
      required this.dateFormatter,
      required this.date,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        ),
        // ignore: unnecessary_null_comparison
        child: Text(date != null ? dateFormatter.format(date) : 'غير محدد'),
      ),
    );
  }
}
