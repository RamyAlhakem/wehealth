import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class HorizontalBoxyIndexSelector<T> extends StatelessWidget {
  const HorizontalBoxyIndexSelector({
    Key? key,
    required this.selectedIndex,
    required this.itemsList,
    required this.onChange,
  }) : super(key: key);

  final int selectedIndex;
  final List<T> itemsList;
  final ValueChanged<int> onChange;

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
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      border: Border(
                        bottom: BorderSide(
                          color: selectedIndex == item.key
                              ? Colors.green
                              : Colors.grey.shade900,
                          width: 5,
                        ),
                      ),
                    ),
                    child: Text(
                      item.value.toString(),
                      style: TextStyles.extraSmallTextStyle(),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
