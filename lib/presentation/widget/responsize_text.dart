import 'package:flutter/material.dart';

class RepText extends StatelessWidget {
  String text;
  double size;
  bool? isCenter;
  Color? color;

  RepText({
    super.key,
    required this.text,
    required this.size,
    this.isCenter,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: size,
        height: 0,
        color: color ?? Colors.white,
      ),
      textAlign: isCenter ?? false ? TextAlign.center : TextAlign.left,
    );
  }
}
