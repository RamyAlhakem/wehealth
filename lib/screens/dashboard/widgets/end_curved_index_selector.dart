import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class HorizontalEndCurvedIndexSelector<T> extends StatelessWidget {
  const HorizontalEndCurvedIndexSelector({
    Key? key,
    required this.selectedIndex,
    required this.itemsList,
    required this.onChange,
    this.selectedBg,
    this.unselectedBg,
    this.borderColor,
    this.textColor,
  }) : super(key: key);

  final int selectedIndex;
  final List<T> itemsList;
  final ValueChanged<int> onChange;
  final Color? selectedBg;
  final Color? unselectedBg;
  final Color? borderColor;
  final Color? textColor;

  BorderRadius _borderRadius(int index) {
    if (index == 0) return const BorderRadius.only(topLeft: Radius.circular(8));
    if (index == (itemsList.length - 1)) {
      return const BorderRadius.only(topRight: Radius.circular(8));
    }
    return BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Row(
        children: itemsList
            .asMap()
            .entries
            .map(
              (item) => Expanded(
                child: GestureDetector(
                  onTap: () => onChange(item.key),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: (selectedIndex == item.key)
                          ? (selectedBg ?? Colors.white)
                          : (unselectedBg ?? Colors.amberAccent),
                      border: Border.all(
                          color: (borderColor ?? Colors.amber.shade700),
                          width: 1.5),
                      borderRadius: _borderRadius(item.key),
                    ),
                    child: Center(
                        child: Text(
                      item.value.toString(),
                      style: TextStyles.extraSmallDaysTextStyle().copyWith(
                        color: textColor,
                      ),
                    )),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
