import 'package:flutter/material.dart';

import '../../../../global/styles/text_styles.dart';
import '../drawer_items.dart';

class IntelligentAlerts extends StatefulWidget {
  const IntelligentAlerts({Key? key}) : super(key: key);

  @override
  State<IntelligentAlerts> createState() => _IntelligentAlertsState();
}

class _IntelligentAlertsState extends State<IntelligentAlerts> {
  bool enableSwitch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     drawer: const DrawerSide(),
      appBar: AppBar(
        title: const Text("Intelligent Alerts"),
      ),
      body: SingleChildScrollView(
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
              trailing: Switch(value: enableSwitch, onChanged: (val) {}),
              title: Text(
                "Personalized",
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
              trailing: Switch(value: enableSwitch, onChanged: (val) {}),
              title: Text(
                "Subscriptions",
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
              trailing: Switch(value: enableSwitch, onChanged: (val) {}),
              title: Text(
                "Diet",
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
              trailing: Switch(value: enableSwitch, onChanged: (val) {}),
              title: Text(
                "Physical Activities",
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
              trailing: Switch(value: enableSwitch, onChanged: (val) {}),
              title: Text(
                "Sleep",
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
              trailing: Switch(value: enableSwitch, onChanged: (val) {}),
              title: Text(
                "Health Score",
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
              trailing: Switch(value: enableSwitch, onChanged: (val) {}),
              title: Text(
                "Fitness",
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
              trailing: Switch(value: enableSwitch, onChanged: (val) {}),
              title: Text(
                "Medical Report",
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
              trailing: Switch(value: enableSwitch, onChanged: (val) {}),
              title: Text(
                "Personalized",
                style: TextStyles.normalTextBoldStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
