import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class TitledRadioWidget<T> extends StatelessWidget {
  const TitledRadioWidget({
    Key? key,
    required this.value,
    required this.groupValue,
    this.onChange,
    required this.title,
  }) : super(key: key);
  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?>? onChange;
/* 
  bool get _selected => value == groupValue;
  void _handleChanged(bool? selected) {
    if (selected == null || false) {
      onChange!(null);
      return;
    }
    if (selected) {
      onChange!(value);
    }
  } */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => _handleChanged(_selected),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T>(
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            groupValue: groupValue,
            onChanged: onChange,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyles.smallTextBoldStyle(),
          )
        ],
      ),
    );
  }
}