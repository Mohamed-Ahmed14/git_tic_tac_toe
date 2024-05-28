import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {

  final void Function()? onPressed;
  final Widget? child;
  final Color? backgroundColor;
  const CustomElevatedButton({required this.onPressed,
    required this.child,
    this.backgroundColor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:onPressed ,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}
