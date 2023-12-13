import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';

import '../notifications/notification_screen.dart';

class NextOfKinScreen extends StatefulWidget {
  const NextOfKinScreen({Key? key}) : super(key: key);

  @override
  State<NextOfKinScreen> createState() => _NextOfKinScreenState();
}

class _NextOfKinScreenState extends State<NextOfKinScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> relations = [
    "Father",
    "Mother",
    "Son",
    "Daughter",
    "Husband",
    "Wife",
    "Brother",
    "Sister",
    "Grandfather",
    "Grandmother",
    "Others",
  ];

  List<String> types = [
    "Care Taker",
    "Care Giver",
  ];

  String defaultValue = "Father";
  String type = "Care Taker";
  bool email = true;
  bool app = true;
  bool sms = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: const Text("Next Of Kin"),
         automaticallyImplyLeading: !Platform.isIOS,
        leading: Platform.isIOS  
        ?  IconButton(onPressed: (){
          Get.back();
          }, icon: const Icon(Icons.close),) 
        : null,
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
            Get.to(() => const NotificationScreen());
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "User Name:",
                          style: TextStyles.extraSmallBoldTextStyle()
                              .copyWith(color: Colors.pink.shade200),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextFormField(
                          decoration: decoration,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Relationship:",
                          style: TextStyles.extraSmallBoldTextStyle()
                              .copyWith(color: Colors.pink.shade200),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: decoration,
                          value: defaultValue,
                          items: relations
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              defaultValue = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Type:",
                          style: TextStyles.extraSmallBoldTextStyle()
                              .copyWith(color: Colors.pink.shade200),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: decoration,
                          value: type,
                          items: types
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              type = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: email,
                              onChanged: (value) {
                                setState(() {
                                  email = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: Text(
                                "Email Alert",
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.pink.shade200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: app,
                              onChanged: (value) {
                                setState(() {
                                  app = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: Text(
                                "App Alert",
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.pink.shade200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                              value: sms,
                              onChanged: (value) {
                                setState(() {
                                  sms = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: Text(
                                "SMS Alert",
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.pink.shade200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                        color: Colors.pink.shade200,
                      )),
                      onPressed: () {},
                      child: Text(
                        "Save",
                        style: TextStyles.extraSmallBoldTextStyle()
                            .copyWith(color: Colors.pink.shade200),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
