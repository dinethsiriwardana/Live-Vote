import 'package:flutter/material.dart';
import 'package:live_vote/const.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.text, required this.onPressed, this.size});

  final String text;
  final Function onPressed;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: size ?? 60.w,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomeColor().primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(text.toUpperCase(),
            style: TextStyle(
              fontSize: 50,
              color: Colors.white,
              // fontWeight: FontWeight.w700,
            )),
      ),
    );
  }
}
