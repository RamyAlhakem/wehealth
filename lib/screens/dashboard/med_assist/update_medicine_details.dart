import 'package:flutter/material.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';


class UpdateMedicineDetails extends StatefulWidget {
  const UpdateMedicineDetails({super.key});

  @override
  State<UpdateMedicineDetails> createState() => _UpdateMedicineDetailsState();
}

class _UpdateMedicineDetailsState extends State<UpdateMedicineDetails> {
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Med Assist",
      appBarColor: Colors.pinkAccent,
    body: Container(
    child: Column(children: [
    
    
    ],),
    ),
    );
  }
}