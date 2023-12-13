
import 'package:flutter/material.dart';

import '../drawer/home/appointment/appt_constants.dart';

class SlotWidget extends StatelessWidget {
  const SlotWidget({
    Key? key,
    required this.isSelected,
    required this.type,
    required this.time,
    required this.isBlocked,
    required this.onSelect,
  }) : super(key: key);
  final int type;
  final String time;
  final bool isBlocked;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isBlocked ? null : onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isBlocked
              ? Colors.red
              : isSelected
                  ? Colors.blue
                  : getColorBasedOfAppt(type),
        ),
        padding: const EdgeInsets.all(6),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            time,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
