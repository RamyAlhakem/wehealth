import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../drawer/profile/profile_screen.dart';

showProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Complete Profile!!"),
        content: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "To get the best performance out of our app, we require you to complete your personal profile.\n\n Please kindly provide the necessery data to operate all the features properly!",
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              "CANCEL",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Setup Profile"),
            onPressed: () {
              Navigator.of(context).pop();
              Get.to(() => const ProfileScreen());
            },
          ),
        ],
      );
    },
  );
}
