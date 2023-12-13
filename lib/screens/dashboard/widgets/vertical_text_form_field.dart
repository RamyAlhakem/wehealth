import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';

typedef ValidatorFun<T> = String? Function(T? value);

class VerticalFormField extends StatelessWidget {
  const VerticalFormField({
    Key? key,
    required this.controller,
    required this.title,
    this.titleColor,
    this.hintText,
    this.validator,
    
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final Color? titleColor;
  final String? hintText;
  final ValidatorFun? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
      color: titleColor ?? Colors.black,
      fontFamily: 'monserrat',
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
    ),
    
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: decoration.copyWith(hintText: hintText),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
