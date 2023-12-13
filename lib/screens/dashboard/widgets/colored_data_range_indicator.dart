import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class ColoredDataRangeIndicator extends StatelessWidget {
  const ColoredDataRangeIndicator({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);
  final String title;
  final List<ColoredDataRangeWidget> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              title,
              style: TextStyles.normalTextStyle(),
            ),
          ),
          Expanded(
            child: Row(
              children: items,
            ),
          ),
        ],
      ),
    );
  }
}

class ColoredDataRangeWidget extends StatelessWidget {
  const ColoredDataRangeWidget({
    Key? key,
    required this.color,
    required this.inRange,
    required this.rangeDescription,
    required this.rangeName,
  }) : super(key: key);
  final Color color;
  final bool inRange;
  final String rangeDescription;
  final String rangeName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: ColoredBox(
                color: color,
                child: Center(
                  child: inRange
                      ? Container(
                          height: double.infinity,
                          width: 5,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              rangeDescription,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.extraSmallTextStyle(),
            ),
          ),
          Text(
            rangeName,
            style: TextStyles.smallTextStyle(),
          ),
        ],
      ),
    );
  }
}
