import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

import '../../../../global/styles/text_styles.dart';

class GoogleFitSettingScreen extends StatelessWidget {
  const GoogleFitSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerNotificationScaffold(
      title: "Google Fit Setting",
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    onTap: () {},
                    trailing: Switch(value: true, onChanged: (val) {}),
                    title: Text(
                      "Enable Physical Activity",
                      style: TextStyles.normalTextBoldStyle(),
                    ),
                  ),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    onTap: () {},
                    trailing: Switch(value: true, onChanged: (val) {}),
                    title: Text(
                      "Enable Sleep Data",
                      style: TextStyles.normalTextBoldStyle(),
                    ),
                  ),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    onTap: () {},
                    trailing: Switch(value: true, onChanged: (val) {}),
                    title: Text(
                      "Enable Heart Rate",
                      style: TextStyles.normalTextBoldStyle(),
                    ),
                  ),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    onTap: () {},
                    trailing: Switch(value: true, onChanged: (val) {}),
                    title: Text(
                      "Enable Nutritions",
                      style: TextStyles.normalTextBoldStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () async {},
                    child: Text(
                      "Save",
                      style: TextStyles.smallTextBoldStyle()
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
