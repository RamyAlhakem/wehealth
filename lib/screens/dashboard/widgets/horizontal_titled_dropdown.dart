
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class HorizontalTitledDropdown<T> extends StatelessWidget {
  HorizontalTitledDropdown({
    Key? key,
    required this.title,
    required List<T> options,
    required T selectedItem,
    this.onChange,
    this.titleStyle,
  })  : _items = (options is List<String> && !options.contains(selectedItem))
            ? [("Select an item" as T), ...options]
            : options,
        _selected = ((selectedItem is String && selectedItem == "")
            ? "Select an item"
            : selectedItem) as T,
        super(key: key);

  final String title;
  final List<T> _items;
  final T _selected;
  final ValueChanged<T?>? onChange;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: titleStyle ?? TextStyles.extraSmallText14BStyle().copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 6,
          child: SizedBox(
            height: 60.h,
            child: DropdownButtonFormField<T>(
              isExpanded: true,
              decoration: decoration,
              value: _selected,
              alignment: Alignment.center,
              items: _items
                  .map(
                    (value) => DropdownMenuItem<T>(
                      value: value,
                      child: Text(
                        value.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChange,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}