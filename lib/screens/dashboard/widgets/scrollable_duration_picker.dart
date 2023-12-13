import 'package:flutter/material.dart';

class ScrollableDurationPicker extends StatelessWidget {
  ScrollableDurationPicker({
    Key? key,
    required this.minuteUpdate,
    required this.hourUpdate,
    FixedExtentScrollController? minuteController,
    FixedExtentScrollController? hourController,
    int selectedHour = 0,
    int selectedMinute = 0,
  })  : _selectedHour = selectedHour,
        _selectedMinute = selectedMinute,
        _hourController = hourController ??
            FixedExtentScrollController(initialItem: selectedHour),
        _minuteController = minuteController ??
            FixedExtentScrollController(initialItem: selectedMinute),
        super(key: key);

  final int _selectedHour;
  final int _selectedMinute;
  final FixedExtentScrollController _hourController;
  final FixedExtentScrollController _minuteController;
  final ValueChanged<int> minuteUpdate;
  final ValueChanged<int> hourUpdate;
  final List<int> hours = List.generate(25, (index) => index);
  final List<int> minutes = List.generate(60, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: double.infinity,
      height: 150,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: Row(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text("Hour"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text("Minute"),
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 7,
            child: Container(
              width: double.infinity,
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
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      magnification: 1.3,
                      useMagnifier: true,
                      overAndUnderCenterOpacity: 0.8,
                      controller: _hourController,
                      onSelectedItemChanged: hourUpdate,
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: hours.length,
                        builder: (context, index) => SizedBox.expand(
                          child: Center(
                            child: Text(
                              hours[index].toString(),
                              style: TextStyle(
                                color: (_selectedHour == index)
                                    ? Colors.green.shade300
                                    : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  /* Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ), */
                  const VerticalDivider(color: Colors.grey, thickness: 1),
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      magnification: 1.3,
                      useMagnifier: true,
                      overAndUnderCenterOpacity: 0.8,
                      controller: _minuteController,
                      onSelectedItemChanged: minuteUpdate,
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: minutes.length,
                        builder: (context, index) => SizedBox.expand(
                          child: Center(
                            child: Text(
                              minutes[index].toString(),
                              style: TextStyle(
                                color: (_selectedMinute == index)
                                    ? Colors.green.shade300
                                    : Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
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
    );
  }
}
