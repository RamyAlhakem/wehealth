import 'package:flutter/material.dart';
import 'package:wehealth/global/constants/color_resources.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class HorizontalTextField extends StatefulWidget {
  const HorizontalTextField({
    Key? key,
    required this.controller,
    required this.title,
    this.isPassword = false,
    this.color,
    this.maxLines,
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final bool isPassword;
  final Color? color;
  final int? maxLines;

  @override
  State<HorizontalTextField> createState() => _HorizontalTextFieldState();
}

class _HorizontalTextFieldState extends State<HorizontalTextField> {
  bool _hidden = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              widget.title,
              style: TextStyles.extraSmallTextStyle()
                  .copyWith(color: widget.color),
            ),
          ),
          Expanded(
            flex: 6,
            child: TextFormField(
              autocorrect: false,
              controller: widget.controller,
              obscureText: widget.isPassword ? _hidden : false,
              maxLines: widget.maxLines ?? 1,
              decoration: decoration.copyWith(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.5,
                      color: widget.color ?? ColorResources.colorGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.color ?? ColorResources.colorWhite,
                      width: 2.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.5,
                      color: widget.color ?? ColorResources.colorGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.5,
                      color: widget.color ?? ColorResources.colorGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: (widget.isPassword)
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            _hidden = !_hidden;
                          });
                        },
                        icon: _hidden
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
