import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class TimelineDateWidget extends StatelessWidget {
  final DateTime date;
  final Color? color;
  const TimelineDateWidget({
    Key? key,
    required this.date,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
      ),
      child: Text(
        "Date: ${dateFormat.format(date)}",
        style: TextStyles.extraSmallTextStyle().copyWith(color:color, fontWeight: FontWeight.bold),
      ),
    );
  }
}