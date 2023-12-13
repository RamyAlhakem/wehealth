import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class HorizontalTextFormField extends StatelessWidget {
  const HorizontalTextFormField({
    Key? key,
    required this.controller,
    required this.title,
    this.titleColor,
    this.leftFlex,
    this.rightFlex,
    this.maxLines,
    this.inputDecoration,
    this.fieldPadding,
    this.inputType,
    this.validator,
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final Color? titleColor;
  final int? leftFlex;
  final int? rightFlex;
  final int? maxLines;
  final TextInputType? inputType;
  final InputDecoration? inputDecoration;
  final EdgeInsetsGeometry? fieldPadding;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: leftFlex ?? 4,
          child: Text(
            title,
            style: TextStyles.extraSmallText14BStyle().copyWith(color: titleColor ?? Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: rightFlex ?? 6,
          child: TextFormField(
            maxLines: maxLines ?? 1,
            controller: controller,
            validator: validator ??
                (value) {
                  return (controller.text.isEmpty)
                      ? "This field is empty!"
                      : null;
                },
            keyboardType: inputType,
            decoration: inputDecoration ?? decoration,
          ),
        ),
      ],
    );
  }
}
