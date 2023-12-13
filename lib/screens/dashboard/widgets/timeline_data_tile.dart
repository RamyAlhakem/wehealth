
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class TimelineDataTile extends StatelessWidget {
  final String leadingData;
  final String leadingUnit;
  final String titleData;
  final String noteData;
  final DateTime timeData;
  final VoidCallback onTap;
  final Color leadingColor;
  final Color? textColor;

  const TimelineDataTile({Key? key, 
  required this.leadingData, 
  required this.leadingUnit, 
  required this.titleData,
  required this.noteData,
  required this.timeData,
  required this.onTap,
  required this.leadingColor,
  this.textColor,
  
   }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormat = DateFormat("HH:mm");
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 100.h,
        ),
        padding: const EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade700,
            ),
            bottom: BorderSide(
              color: Colors.grey.shade700,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(18.sp),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: leadingColor,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          leadingData.isEmpty ? "   " : leadingData,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontFamily: 'monserrat',
                            color: Colors.white, 
                            fontWeight: FontWeight.bold, 
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      leadingUnit,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade900),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            timeFormat.format(timeData),
                            style: TextStyles.extraSmallTextStyle().copyWith(color: textColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          titleData,
                          style: TextStyles.extraSmallTextStyle().copyWith(color: textColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      noteData,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}