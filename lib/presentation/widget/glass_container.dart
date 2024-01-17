import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class CustomeGlassContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget? child;

  CustomeGlassContainer({
    required this.height,
    required this.width,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: height,
      width: width,
      blur: 10,
      color: Colors.white.withOpacity(0.1),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.blue.withOpacity(0.3),
        ],
      ),
      shadowStrength: 5,
      borderRadius: BorderRadius.circular(30),
      shadowColor: Colors.white.withOpacity(0.24),
      child: child,
    );
  }
}
