import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/scrollable_item_picker.dart';

class WeightGoalScreen extends StatefulWidget {
  const WeightGoalScreen({Key? key}) : super(key: key);

  @override
  State<WeightGoalScreen> createState() => _WeightGoalScreenState();
}

class _WeightGoalScreenState extends State<WeightGoalScreen> {
  final Color pageColor = Colors.blue;
  final _controller = FixedExtentScrollController();
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Weight Goal",
      appBarColor: pageColor,
      body: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "My goal is",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "50.0 kg",
                    style: TextStyles.extraLargeTextBoldStyle().copyWith(
                      color: pageColor,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ScrollableItemPicker(
                    selectedItem: _selectedItem,
                    controller: _controller,
                    items: List.generate(
                      5700,
                      (index) => (index + 300).toString(),
                    ),
                    selector: (value) {
                      setState(() {
                        _selectedItem = value;
                      });
                    },
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Target Date is :",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    splashColor: Colors.grey,
                    onTap: () {
                      Get.to(() => const TargetChoosingPage());
                    },
                    child: Text(
                      "Click Here To Choose",
                      style: TextStyle(
                        color: pageColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ListView(
                    shrinkWrap: true,
                    children: const [
                      DataListTile(
                        title: "Start weight:",
                        data: "168.0kg",
                      ),
                      DataListTile(
                        title: "Start weight:",
                        data: "168.0kg",
                      ),
                      DataListTile(
                        title: "Start weight:",
                        data: "168.0kg",
                      ),
                      DataListTile(
                        title: "Start weight:",
                        data: "168.0kg",
                      ),
                      DataListTile(
                        title: "Start weight:",
                        data: "168.0kg",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  "SAVE",
                  style: TextStyles.smallTextBoldStyle(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DataListTile extends StatelessWidget {
  const DataListTile({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 0.5,
        ),
      ),
      title: Text(title),
      trailing: Text(data),
    );
  }
}

class TargetChoosingPage extends StatefulWidget {
  const TargetChoosingPage({Key? key}) : super(key: key);

  @override
  State<TargetChoosingPage> createState() => _TargetChoosingPageState();
}

class _TargetChoosingPageState extends State<TargetChoosingPage> {
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Weight Goal",
      appBarColor: Colors.blue,
      body: Column(
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey.shade300,
                width: 0.5,
              ),
            ),
            isThreeLine: true,
            horizontalTitleGap: 18,
            leading: Column(
              children: [
                Text(
                  "3885",
                  style: TextStyles.extraLargeTextStyle().copyWith(
                    color: Colors.blue,
                  ),
                ),
                Text(
                  "days",
                  style: TextStyles.smallTextStyle().copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            title: Text(
              "Easy",
              style: TextStyles.normalTextStyle().copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Calories Deficit"),
                Text("Weight Loss Per Week"),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "28 Jul 2033",
                  style: TextStyles.normalTextStyle().copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Text("250"),
                const Text("0.2"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
