import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class VerticalTitledDropdown<T> extends StatelessWidget {
  VerticalTitledDropdown({
    Key? key,
    required this.title,
    this.titleColor,
    required List<T> options,
    required T selectedItem,
    this.onChange,
  })  : _items = (options is List<String>)
            ? [("Select an item" as T), ...options]
            : options,
        _selected = ((selectedItem is String && selectedItem == "")
            ? "Select an item"
            : selectedItem) as T,
        super(key: key);

  final String title;
  final Color? titleColor;
  final List<T> _items;
  final T _selected;
  final ValueChanged<T?>? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.smallTextBoldStyle().copyWith(color: titleColor ?? Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60.h,
          child: DropdownButtonFormField<T>(
            isExpanded: true,
            decoration: decoration,
            value: _selected,
            alignment: Alignment.center,
            items: _items
                .map((value) => DropdownMenuItem<T>(
                      value: value,
                      child: Text(
                        value.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ))
                .toList(),
            onChanged: (onChange != null)
                ? (value) {
                    if (_selected is String && value == "Select an item") {
                      onChange!(null);
                    } else {
                      onChange!(value);
                    }
                  }
                : null,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
