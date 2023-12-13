import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

///Converts any material color [Color] to it's hex form!
extension GetHexValue on Color {
  String get hexValue => value.toRadixString(16);
}

extension TimeUtils on TimeOfDay {
  bool inInclusiveRange(TimeOfDay start, TimeOfDay end) {
    return (hour >= start.hour && hour <= end.hour);
  }

  DateTime get toTodayDateTime => DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        hour,
        minute,
      );
}

extension DateTimeUtils on DateTime {
  String get weekDayCodeString {
    final List<String> dayCodes = [
      "mon",
      "tue",
      "wed",
      "thu",
      "fri",
      "sat",
      "sun",
    ];
    return dayCodes[weekday + 1];
  }
}

double nanConverter(double data) => data.isNaN ? 0 : data.toPrecision(2);

enum RangeChecker {
  low,
  mid,
  high,
  outOfRange,
}

RangeChecker rangeCheckerExclusive(
    double lowStart, double midStart, double highStart, double value) {
  if (lowStart <= value && midStart > value) {
    return RangeChecker.low;
  } else if (midStart <= value && highStart > value) {
    return RangeChecker.mid;
  } else if (value > highStart) {
    return RangeChecker.high;
  } else {
    return RangeChecker.outOfRange;
  }
}

///Selects a [DateTime] and converts it into a readable Date and sends the string.
Future<String> getSelectedDateString(BuildContext context,
    {int? before,
    int? after,
    DateFormat? formatter,
    DateTime? startDate,
    DateTime? endDate}) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: startDate ??
        DateTime.now().subtract(
          Duration(days: before ?? 60),
        ),
    lastDate: endDate ??
        DateTime.now().add(
          Duration(days: after ?? 730),
        ),
  );

  if (selectedDate != null) {
    DateFormat format = formatter ?? DateFormat("dd-MM-yyyy");
    //DateFormat format = formatter ?? DateFormat.yMd();
    String selectedDayString = format.format(selectedDate);
    return selectedDayString;
  } else {
    return "";
  }
}

///Sends a [String] defining the part of the day using provided time.
String dayPortionToString(TimeOfDay time) {
  String poriton;
  if (time.hour >= 16 && time.hour < 19) {
    poriton = "Evening";
  } else if (time.hour >= 12 && time.hour < 16) {
    poriton = "Noon";
  } else if (time.hour >= 6 && time.hour < 12) {
    poriton = "Morning";
  } else {
    poriton = "Night";
  }
  return poriton;
}

extension NullAwareExtension<T> on Iterable<T> {
  ///Checks the first item of the iterable and sends null if it's empty!
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

///Image picker to get a image and return it.
Future<XFile?> fetchImage(BuildContext context) {
  return showModalBottomSheet<XFile?>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 14.0, left: 8, bottom: 0),
              child: Text(
                "Insert Image From",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color:
                      const Color(0xff2E2E2E), // this is for your text colour
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(
                left: 8,
              ),
              horizontalTitleGap: 6,
              leading: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.black,
              ),
              title: const Text('Camera'),
              onTap: () async {
                final picker = ImagePicker();
                XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (context.mounted) Navigator.pop<XFile?>(context, image);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 8),
              horizontalTitleGap: 6,
              leading: Image.asset(
                "assets/images/upload_image_icon.png",
                color: Colors.black,
                height: 24,
              ),
              title: const Text('Gallery'),
              onTap: () async {
                final picker = ImagePicker();
                XFile? image =
                    await picker.pickImage(source: ImageSource.gallery,);
                if(context.mounted) Navigator.pop<XFile?>(context, image);
              },
            ),
          ],
        );
      });
}
