import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_textfield.dart';

class DietAddClassScreen extends StatefulWidget {
  const DietAddClassScreen({Key? key}) : super(key: key);

  @override
  State<DietAddClassScreen> createState() => _DietAddClassScreenState();
}

class _DietAddClassScreenState extends State<DietAddClassScreen> {
  final pageColor = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Add Class",
      appBarColor: pageColor,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: HorizontalTextField(
                    controller: TextEditingController(),
                    title: "Keyword:",
                    color: pageColor,
                  ),
                ),
                Divider(
                  color: pageColor,
                  thickness: 1,
                  height: 0,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: pageColor,
                    ),
                    onPressed: () async {},
                    child: Text(
                      "SEND KEYWORD",
                      style: TextStyles.smallTextBoldStyle()
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
