import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_wrapper.dart';
import 'package:wehealth/screens/dashboard/widgets/scrollable_item_picker.dart';

class WaterIntakeScreen extends StatefulWidget {
  const WaterIntakeScreen({Key? key}) : super(key: key);

  @override
  State<WaterIntakeScreen> createState() => _WaterIntakeScreenState();
}

class _WaterIntakeScreenState extends State<WaterIntakeScreen> {
  final Color pageColor = Colors.blue.shade300;
  int _selectedItem = 0;
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: 2000);
  }

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Water Intake Goal",
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
                    "2000 ml/day",
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
                                  "*Suggested Water Intake For You",
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
                                    "1899.0 ml/day",
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

/* extension getItemNumber on FixedExtentScrollController {
  int get selectedItem {
  assert(
    positions.isNotEmpty,
    'FixedExtentScrollController.selectedItem cannot be accessed before a '
    'scroll view is built with it.',
  );
  assert(
    positions.length == 1,
    'The selectedItem property cannot be read when multiple scroll views are '
    'attached to the same FixedExtentScrollController.',
  );
  final _FixedExtentScrollPosition position = this.position;
  return position.itemIndex;
}
}
 */
