import 'package:flutter/material.dart';

import '../../../global/styles/text_styles.dart';

class ImageListTile extends StatelessWidget {
  const ImageListTile({
    Key? key,
    required this.image,
    required this.data,
    required this.unit,
    required this.subtitle,
    this.leadingBorderColor,
    this.textColor,
    this.onTap,
  }) : super(key: key);
  final String image;
  final String data;
  final String unit;
  final String subtitle;

  final Color? leadingBorderColor;
  final Color? textColor;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
    dense: true,
    shape: Border.all(
      color: Colors.grey.shade200,
      width: 2
    ),
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: leadingBorderColor ?? Colors.blue.shade200,
        ),
        child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundImage: AssetImage(image),
            radius: 32),
      ),
      title: RichText(
        text: TextSpan(
            text: data,
            style: TextStyles.normalTextBoldStyle()
                .copyWith(color: textColor ?? Colors.blue.shade200),
            children: [
              TextSpan(
                text: " $unit",
                style: TextStyles.extraSmallTextStyle()
                    .copyWith(color: textColor ?? Colors.blue.shade200),
              )
            ]),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyles.extraSmallBoldTextStyle()
            .copyWith(color: textColor ?? Colors.blue.shade200),
      ),
    );
  }
}
