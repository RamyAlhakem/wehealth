import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/widgets/titled_radio.dart';

class MedicalHistoryTab extends StatefulWidget {
  const MedicalHistoryTab({
    Key? key,
  }) : super(key: key);

  @override
  State<MedicalHistoryTab> createState() => _MedicalHistoryTabState();
}

class _MedicalHistoryTabState extends State<MedicalHistoryTab> {
  bool medicalIllness = false;
  bool physicalDisability = false;
  bool familyIllness = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.palette_rounded),
                            const SizedBox(width: 8),
                            Text(
                              "Are you a smoker?",
                              style: TextStyles.smallTextStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TitledRadioWidget(
                          value: false,
                          groupValue: true,
                          title: "Yes",
                          onChange: (value) {},
                        ),
                        TitledRadioWidget(
                          value: false,
                          groupValue: false,
                          title: "No",
                          onChange: (value) {},
                        ),
                        TitledRadioWidget(
                          value: false,
                          groupValue: true,
                          title: "Just quitted smoking!",
                          onChange: (value) {},
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                MedicalHistoryQueryWidget(
                  selectedValue: medicalIllness,
                  listController: TextEditingController(),
                  title:
                      "Do you have any medical illness (e.g asthma, heart attack, etc.)?",
                  imagePath: "assets/icons/smokericon.webp",
                  onChange: (value) {
                    setState(() {
                      medicalIllness = value!;
                    });
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                MedicalHistoryQueryWidget(
                  selectedValue: physicalDisability,
                  listController: TextEditingController(),
                  title: "Physical Disability?",
                  imagePath: "assets/icons/smokericon.webp",
                  onChange: (value) {
                    setState(() {
                      physicalDisability = value!;
                    });
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                MedicalHistoryQueryWidget(
                  selectedValue: familyIllness,
                  listController: TextEditingController(),
                  title:
                      "Do you have any family history of disease (e.g asthma, heart attack, etc.)?",
                  imagePath: "assets/icons/smokericon.webp",
                  onChange: (value) {
                    setState(() {
                      familyIllness = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.deepPurpleAccent,
              backgroundColor: Colors.white,
              side: const BorderSide(
                color: Colors.deepPurpleAccent,
              ),
            ),
            onPressed: () {},
            child: Text(
              "Save Report",
              style: TextStyles.smallTextBoldStyle(),
            ),
          ),
        )
      ],
    );
  }
}

class MedicalHistoryQueryWidget extends StatelessWidget {
  const MedicalHistoryQueryWidget({
    Key? key,
    required this.selectedValue,
    required this.title,
    required this.imagePath,
    required this.onChange,
    required this.listController,
  }) : super(key: key);

  final String title;
  final String imagePath;
  final bool selectedValue;
  final ValueChanged<bool?> onChange;
  final TextEditingController listController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.square(
                  dimension: 32,
                  child: Image.asset(imagePath),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.smallTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TitledRadioWidget(
              value: true,
              groupValue: selectedValue,
              title: "Yes",
              onChange: onChange,
            ),
            TitledRadioWidget(
              value: false,
              groupValue: selectedValue,
              title: "No",
              onChange: onChange,
            ),
            if (selectedValue) ...[
              const SizedBox(height: 16),
              TextField(
                decoration: decoration.copyWith(
                  label: const Text("Please List "),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
