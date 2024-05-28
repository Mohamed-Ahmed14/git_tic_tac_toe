import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double? borderRadius ;
  final double? contentPadding;
  final Color? prefixIconColor;
  final String? hintText;
  const CustomTextFormField({
     this.controller,
    this.validator,
    this.contentPadding,
     this.borderRadius,
    this.prefixIconColor,
    this.hintText,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator:validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius?? 12.r),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius?? 12.r),
          borderSide: const BorderSide(
            color: Colors.orange
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius?? 12.r),
          borderSide: const BorderSide(
              color: Colors.orange
          ),
        ),
        errorStyle:const TextStyle(
          color: Colors.orangeAccent,
        ),
        fillColor: AppColor.blueGreyDark,
        filled: true,
        contentPadding: EdgeInsetsDirectional.all(contentPadding??5.w),
        prefixIcon: Icon(Icons.person,color: prefixIconColor,),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18.sp
        ),
      ),
      cursorColor: AppColor.white,
      style: TextStyle(
          color: AppColor.white,letterSpacing: 1.5.sp
      ),
    );
  }
}
