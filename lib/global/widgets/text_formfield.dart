import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  TextEditingController controller;
  Icon icon;
  String labelText;
  CustomInputField(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.labelText})
      : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
