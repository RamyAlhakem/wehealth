import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnableDisableButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  //final ButtonStyle buttonStyle;

  const EnableDisableButton({
    Key? key,
    required this.title,
    required this.onPressed,
    //required this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onSurface: Colors.blue,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.sm,
            fontWeight: FontWeight.bold,
          ),
        ),
        //style: buttonStyle,
      ),
    );
  }
}
