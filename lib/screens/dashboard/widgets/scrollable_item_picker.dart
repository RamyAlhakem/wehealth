import 'package:flutter/material.dart';

class ScrollableItemPicker extends StatelessWidget {
  const ScrollableItemPicker({
    Key? key,
    required this.controller,
    required int selectedItem,
    required this.selector,
    required this.items,
  })  : _selectedItem = selectedItem,
        super(key: key);

  final int _selectedItem;
  final FixedExtentScrollController controller;
  final ValueChanged<int> selector;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      height: 150,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        magnification: 1.3,
        useMagnifier: true,
        overAndUnderCenterOpacity: 0.8,
        controller: controller,
        onSelectedItemChanged: selector,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: items.length,
          builder: (context, index) => SizedBox.expand(
            child: Center(
              child: Text(
                items[index],
                style: TextStyle(
                  color: (_selectedItem == index)
                      ? Colors.green.shade300
                      : Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
