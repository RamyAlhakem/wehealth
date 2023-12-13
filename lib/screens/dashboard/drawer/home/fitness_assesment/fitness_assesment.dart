import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

class FitnessAssesmentScreen extends StatefulWidget {
  const FitnessAssesmentScreen({Key? key}) : super(key: key);

  @override
  State<FitnessAssesmentScreen> createState() => _FitnessAssesmentScreenState();
}

class _FitnessAssesmentScreenState extends State<FitnessAssesmentScreen> {
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Fitness Assesment",
      appBarColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: const Card(
                  color: Colors.red,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FittedBox(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "START FITNESS TEST",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AssesmentDataCard(
                      data: "_",
                      title: "Push Up Test Result",
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: AssesmentDataCard(
                      data: "_",
                      title: "Curl Up Test Result",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: AssesmentDataCard(
                      data: "_",
                      title: "2.4km Running Test Result",
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: AssesmentDataCard(
                      data: "_",
                      title: "YMCA Step Test Result",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: AssesmentDataCard(
                      data: "_",
                      title: "Long Jump Test Result",
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: AssesmentDataCard(
                      data: "_",
                      title: "Rockport Test Result",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              AssesmentDataCard(
                title: "Squat Test Result",
                data: "_",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AssesmentDataCard extends StatelessWidget {
  const AssesmentDataCard({
    Key? key,
    required this.title,
    required this.data,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.red,
        child: SizedBox(
          width: double.infinity,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  data,
                  style: TextStyles.normalTextBoldStyle().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyles.extraSmallBoldTextStyle().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
