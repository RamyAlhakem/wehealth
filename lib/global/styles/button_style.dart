import 'package:flutter/material.dart';

import '../constants/color_resources.dart';

class ButtonStyles {
  //* ================== |> Button Style Based On Theme <| ==================  */
  static ButtonStyle getThemeStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(ColorResources.getRedColor(context)),
      foregroundColor: MaterialStateProperty.all(Colors.white),
    );
  }

  //* ================== |> Button Style Based On Theme <| ==================  */
  static ButtonStyle getBlueStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(ColorResources.getBlueColor(context)),
      foregroundColor: MaterialStateProperty.all(const Color(0xff057dcf)),
    );
  }

  //* ================== |> Button Style Based on Customization <| ==================  */
  static ButtonStyle getCommonStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Theme.of(context).primaryColor,
      ),
      foregroundColor: MaterialStateProperty.all(Colors.white),
    );
  }

  static ButtonStyle getGreyStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Theme.of(context).primaryColor,
      ),
      foregroundColor: MaterialStateProperty.all(Colors.white),
    );
  }
}
