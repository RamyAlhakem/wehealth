import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class FitnessWorkoutScreen extends StatefulWidget {
  const FitnessWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<FitnessWorkoutScreen> createState() => _FitnessWorkoutScreenState();
}

class _FitnessWorkoutScreenState extends State<FitnessWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "WeHealth",
      appBarColor: Colors.greenAccent.shade400,
      tabCount: 3,
      tabTitles: const [
        "CHALLENGES",
        "INSTRUCTION",
        "SCIENCE",
      ],
      tabs: const [
        FitnessChallengesTab(),
        FitnessInstructionsTab(),
        FitnessScienceTab(),
      ],
    );
  }
}

class FitnessChallengesTab extends StatelessWidget {
  const FitnessChallengesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              elevation: 3,
              child: SizedBox(
                width: double.infinity,
                height: 70,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 32,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Image.asset(
                              "assets/images/ic_insert_chart_black.png")
                          /* Icon(
                            Icons.timer,
                            color: Colors.indigoAccent,
                          ) */
                          ,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Text(
                          "50.5.25",
                          style: TextStyles.normalTextStyle().copyWith(
                            color: Colors.indigoAccent,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 32,
                        child: FittedBox(
                          child: Icon(
                            Icons.insert_chart_outlined_sharp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FitnessChallengeCard(
            title: "Full Body Workout",
            onTap: () {},
            imgLink: "assets/images/td_ic_body.webp",
          ),
          FitnessChallengeCard(
            title: "Abs Workout",
            onTap: () {},
            imgLink: "assets/images/td_ic_abs.webp",
          ),
          FitnessChallengeCard(
            title: "Butt Workout",
            onTap: () {},
            imgLink: "assets/images/td_ic_butt.webp",
          ),
          FitnessChallengeCard(
            title: "Arm Workout",
            onTap: () {},
            imgLink: "assets/images/td_ic_arm.webp",
          ),
          FitnessChallengeCard(
            title: "Leg Workout",
            onTap: () {},
            imgLink: "assets/images/td_ic_leg.webp",
          ),
        ],
      ),
    );
  }
}

class FitnessChallengeCard extends StatelessWidget {
  const FitnessChallengeCard({
    Key? key,
    required this.imgLink,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String imgLink;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 3),
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 32,
                  backgroundColor: Colors.black,
                  foregroundImage: AssetImage(imgLink),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyles.normalTextBoldStyle(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FitnessInstructionsTab extends StatelessWidget {
  const FitnessInstructionsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          title: const Text("Full Body Workout"),
        ),
        ListTile(
          onTap: () {},
          title: const Text("Abs Workout"),
        ),
        ListTile(
          onTap: () {},
          title: const Text("Butt Workout"),
        ),
        ListTile(
          onTap: () {},
          title: const Text("Arm Workout"),
        ),
        ListTile(
          onTap: () {},
          title: const Text("Leg Workout"),
        ),
      ],
    );
  }
}

class FitnessScienceTab extends StatelessWidget {
  const FitnessScienceTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
