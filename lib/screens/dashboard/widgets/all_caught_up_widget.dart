import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class AllCaughtUpWidget extends StatelessWidget {
  const AllCaughtUpWidget({
    Key? key,
    required this.endLine,
  }) : super(key: key);
  final String endLine;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Image.asset(
              "assets/images/takemed.webp",
            ),
          ),
          const SizedBox(height: 8),
          Text("You're all caught up!", style: TextStyles.extraSmallTextStyle(),),
          const SizedBox(height: 8),
          Text(endLine, style: TextStyles.extraSmallTextStyle()),
        ],
      ),
    );
  }
}
