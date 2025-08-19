import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0.r),
        ),

      ),
      child: child,
    );
  }
}
