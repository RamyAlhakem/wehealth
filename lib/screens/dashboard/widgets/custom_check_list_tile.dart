import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  const CustomCheckboxListTile({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.enabled,
    this.tileColor,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.secondary,
    this.selected = false,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.autofocus = false,
    this.contentPadding,
    this.tristate = false,
    this.shape,
    this.checkboxShape,
    this.selectedTileColor,
    this.side,
    this.visualDensity,
    this.focusNode,
    this.enableFeedback,
    this.horizontalTitleGap,
  })  : assert(!isThreeLine || subtitle != null),
        super(key: key);

  final bool? value;

  final ValueChanged<bool?>? onChanged;

  final double? horizontalTitleGap;

  final Color? activeColor;

  final Color? checkColor;

  final Color? tileColor;

  final Widget? title;

  final Widget? subtitle;

  final Widget? secondary;

  final bool isThreeLine;

  final bool? dense;

  final bool selected;

  final ListTileControlAffinity controlAffinity;

  final bool autofocus;

  final EdgeInsetsGeometry? contentPadding;

  final bool tristate;

  final ShapeBorder? shape;

  final OutlinedBorder? checkboxShape;

  final Color? selectedTileColor;

  final BorderSide? side;

  final VisualDensity? visualDensity;

  final FocusNode? focusNode;

  final bool? enableFeedback;

  final bool? enabled;

  void _handleValueChange() {
    assert(onChanged != null);
    switch (value) {
      case false:
        onChanged!(true);
        break;
      case true:
        onChanged!(tristate ? null : false);
        break;
      case null:
        onChanged!(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget control = Checkbox(
      value: value,
      onChanged: enabled ?? true ? onChanged : null,
      activeColor: activeColor,
      checkColor: checkColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      autofocus: autofocus,
      tristate: tristate,
      shape: checkboxShape,
      side: side,
    );
    Widget? leading, trailing;
    switch (controlAffinity) {
      case ListTileControlAffinity.leading:
        leading = control;
        trailing = secondary;
        break;
      case ListTileControlAffinity.trailing:
      case ListTileControlAffinity.platform:
        leading = secondary;
        trailing = control;
        break;
    }
    return MergeSemantics(
      child: ListTileTheme.merge(
        selectedColor: activeColor ?? Theme.of(context).toggleableActiveColor,
        child: ListTile(
          horizontalTitleGap: horizontalTitleGap,
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          isThreeLine: isThreeLine,
          dense: dense,
          enabled: enabled ?? onChanged != null,
          onTap: onChanged != null ? _handleValueChange : null,
          selected: selected,
          autofocus: autofocus,
          contentPadding: contentPadding,
          shape: shape,
          selectedTileColor: selectedTileColor,
          tileColor: tileColor,
          visualDensity: visualDensity,
          focusNode: focusNode,
          enableFeedback: enableFeedback,
        ),
      ),
    );
  }
}
