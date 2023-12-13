import 'package:flutter/material.dart';

import '../constants/color_resources.dart';
import 'text_styles.dart';

InputDecoration decoration = InputDecoration(
  hintText: "",
  isDense: true,
  errorMaxLines: 2,
  border: OutlineInputBorder(
    borderSide: const BorderSide(width: 1, color: ColorResources.colorGrey),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: ColorResources.colorWhite, width: 2.5),
    borderRadius: BorderRadius.circular(8),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide:
        const BorderSide(width: 1.0, color: ColorResources.colorlightGrey),
    borderRadius: BorderRadius.circular(8),
  ),
  iconColor: ColorResources.colorGrey,
  floatingLabelStyle: TextStyles.normalTextBoldStyle()
      .copyWith(color: ColorResources.colorGrey, fontSize: 24),
  labelStyle:
      TextStyles.smallTextStyle().copyWith(color: ColorResources.colorBlack),
  suffixIconColor: ColorResources.colorGrey,
  filled: true,
);
