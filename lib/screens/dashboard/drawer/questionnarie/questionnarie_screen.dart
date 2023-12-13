import 'package:flutter/material.dart';
import 'package:wehealth/global/constants/color_resources.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

class QuestionnarieScreen extends StatefulWidget {
  const QuestionnarieScreen({Key? key}) : super(key: key);

  @override
  State<QuestionnarieScreen> createState() => _QuestionnarieScreenState();
}

class _QuestionnarieScreenState extends State<QuestionnarieScreen> {
  bool _diabetes = false;
  bool _hyperTension = false;
  bool _obese = false;

  bool _secondStage = false;

  final Map<String, bool> _diabetesMap = {
    "Diet Control": false,
    "Oral Antidiabetics-OAD": false,
    "Insulin": false,
  };

  final Map<String, bool> _hyperTensionMap = {
    "Not Controlled On Treatment": false,
    "Well Controlled/Stable On Diet(long term monitoring)": false,
  };

  @override
  Widget build(BuildContext context) {
    return DrawerNotificationScaffold(
      title: "Questionnarie",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ColoredBox(
              color: Colors.black54,
              child: Center(
                child: Text(
                  "Questionaire",
                  style: TextStyles.normalTextBoldStyle()
                      .copyWith(color: ColorResources.colorWhite),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              !_secondStage ? "Are You Diagonsed With?" : "Are You On?",
              style: TextStyles.smallTextBoldStyle(),
            ),
          ),
          const Divider(
            color: ColorResources.colorBlack,
            thickness: 1,
            height: 0,
          ),
          if (!_secondStage) ...[
            SingleOptionTile(
              value: _diabetes,
              title: "Diabetes",
              onTap: (value) {
                setState(() {
                  _diabetes = value!;
                });
              },
            ),
            SingleOptionTile(
              value: _hyperTension,
              title: "Hypertension",
              onTap: (value) {
                setState(() {
                  _hyperTension = value!;
                });
              },
            ),
            SingleOptionTile(
              value: _obese,
              title: "Obese",
              onTap: (value) {
                setState(() {
                  _obese = value!;
                });
              },
            ),
          ],
          if (_secondStage) ...[
            if (_diabetes)
              ..._diabetesMap.entries
                  .map(
                    (e) => SingleOptionTile(
                      value: e.value,
                      title: e.key,
                      onTap: (value) {
                        setState(() {
                          _diabetesMap[e.key] = value!;
                        });
                      },
                    ),
                  )
                  .toList(),
            if (_hyperTension)
              ..._hyperTensionMap.entries
                  .map(
                    (e) => SingleOptionTile(
                      value: e.value,
                      title: e.key,
                      onTap: (value) {
                        setState(() {
                          _diabetesMap[e.key] = value!;
                        });
                      },
                    ),
                  )
                  .toList()
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {},
                    child: Text(
                      _secondStage ? "PREVIOUS" : "SKIP",
                      style: TextStyles.extraSmallTextStyle()
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        _secondStage = true;
                      });
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyles.extraSmallTextStyle()
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SingleOptionTile extends StatelessWidget {
  const SingleOptionTile({
    Key? key,
    required this.value,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final bool value;
  final String title;
  final ValueChanged<bool?> onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          value: value,
          title: Text(
            title,
            style: TextStyles.extraSmallTextStyle(),
          ),
          activeColor: Colors.teal,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: onTap,
        ),
        const Divider(
          color: ColorResources.colorBlack,
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}
