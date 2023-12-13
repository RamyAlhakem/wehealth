import 'package:flutter/material.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';

class NutritionistScaleScreen extends StatefulWidget {
  const NutritionistScaleScreen({Key? key}) : super(key: key);

  @override
  State<NutritionistScaleScreen> createState() =>
      _NutritionistScaleScreenState();
}

class _NutritionistScaleScreenState extends State<NutritionistScaleScreen> {
  @override
  Widget build(BuildContext context) {
    return const IosScaffoldWrapper(
      title: "Dietary Intake",
      appBarColor: Colors.blue,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Please press start button of nutrition scale"),
          ],
        ),
      ),
    );
  }
}
