import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/scrollable_item_picker.dart';

class CaloriesGoalScreen extends StatefulWidget {
  const CaloriesGoalScreen({Key? key}) : super(key: key);

  @override
  State<CaloriesGoalScreen> createState() => _CaloriesGoalScreenState();
}

class _CaloriesGoalScreenState extends State<CaloriesGoalScreen> {
  final Color pageColor = Colors.blue;
  int _selectedItem = 0;
  late FixedExtentScrollController _controller;
  final lifestyleOptions = [
    "Sedentary",
    "Lightly Active",
    "Moderate Active",
    "Very Active",
    "Extra Active",
  ];
  String selectedOption = "Sedentary";

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: 500);
  }

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Calories Intake Goal",
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
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "0 kcal/day",
                    style: TextStyles.extraLargeTextBoldStyle().copyWith(
                      color: pageColor,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ScrollableItemPicker(
                    selectedItem: _selectedItem,
                    controller: _controller,
                    items: List.generate(
                      2000,
                      (index) => (index + 900).toString(),
                    ),
                    selector: (value) {
                      setState(() {
                        _selectedItem = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    height: 50,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text("Lifestyle :"),
                        ),
                        Expanded(
                          flex: 6,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedOption,
                              alignment: Alignment.center,
                              items: lifestyleOptions
                                  .map((value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ColoredBox(
                              color: pageColor,
                              child: const Center(
                                child: Text(
                                  "*Suggested Calories Intake For You",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: ColoredBox(
                              color: Colors.cyan.shade100,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: FittedBox(
                                      child: Text(
                                    "1610 kcal/day",
                                    style: TextStyles.smallTextBoldStyle(),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
