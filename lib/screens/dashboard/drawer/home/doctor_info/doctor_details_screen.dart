import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/doctor_controller/doctor_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/user_doctors_list_model.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';

import '../../../notifications/notification_screen.dart';
import '../../drawer_items.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({Key? key, required this.doctorId})
      : super(key: key);
  final int doctorId;

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final Color pageColor = Colors.indigo.shade900;

  final Map<String, VoidCallback> doctorActiveButtonMap = {
    "MESSAGE": () {},
    "UNSUBSCRIBE": () {},
  };

  final Map<String, VoidCallback> doctorPendingButtonMap = {};

  final Map<String, VoidCallback> doctorAuthPendingButtonMap = {
    "MESSAGE": () {},
    "REGISTER": () => Get.to(() => const AuthenticationScreen()),
    "REJECT": () {},
  };

  List<MapEntry<String, VoidCallback>> getButtonDataByStatus(int doctorStatus) {
    switch (doctorStatus) {
      case 0:
        return doctorAuthPendingButtonMap.entries.toList();
      case 1:
        return doctorPendingButtonMap.entries.toList();
      case 2:
        return doctorActiveButtonMap.entries.toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Doctor Info"),
        backgroundColor: pageColor,
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              Get.to(() => const NotificationScreen());
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: GetBuilder<DoctorController>(builder: (controller) {
        final UserDoctorModel doctor;
        final isDoctorOnlist = controller.doctorsList
            ?.any((element) => element.professionalID == widget.doctorId);
        if (isDoctorOnlist ?? false) {
          doctor = controller.doctorsList!.firstWhere(
              (element) => element.professionalID == widget.doctorId);
        } else {
          doctor = UserDoctorModel();
        }
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              color: pageColor,
              child: Text(
                doctor.email ?? "",
                style: TextStyles.extraSmallTextStyle()
                    .copyWith(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "First Name:",
                      style: TextStyles.smallTextBoldStyle(),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      doctor.firstName ?? "",
                      style: TextStyles.extraSmallTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Last Name:",
                      style: TextStyles.smallTextBoldStyle(),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      doctor.lastName ?? "",
                      style: TextStyles.extraSmallTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Status:",
                      style: TextStyles.smallTextBoldStyle(),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      doctor.statusString,
                      style: TextStyles.extraSmallTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Email:",
                      style: TextStyles.smallTextBoldStyle(),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      doctor.email ?? "",
                      style: TextStyles.extraSmallTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Gender:",
                      style: TextStyles.smallTextBoldStyle(),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      doctor.gender ?? "",
                      style: TextStyles.extraSmallTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Phone:",
                      style: TextStyles.smallTextBoldStyle(),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      doctor.phone ?? "",
                      style: TextStyles.extraSmallTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Hospital:",
                      style: TextStyles.smallTextBoldStyle(),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "_",
                      style: TextStyles.extraSmallTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                for (MapEntry<String, VoidCallback> singleButtonData
                    in getButtonDataByStatus(doctor.status ?? 0)) ...[
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: pageColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                      onPressed: singleButtonData.value,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          singleButtonData.key,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.smallTextBoldStyle().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ], /*  getButtonDataByStatus(widget.doctorData.status ?? 0)
                    .map(
                      (e) => Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: pageColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              )),
                          onPressed: e.value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e.key,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.smallTextBoldStyle().copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(), */
            ),
          ],
        );
      }),
    );
  }
}

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final Color pageColor = Colors.indigo.shade900;
  late final TextEditingController _codeController;
  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Authentication",
                style: TextStyles.normalTextBoldStyle()
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(height: 5),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Key in Authentication Code To Complete Registration Process",
                      style: TextStyles.normalTextStyle()
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: TextField(
                        controller: _codeController,
                        decoration:
                            decoration.copyWith(fillColor: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "SUBMIT",
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.smallTextBoldStyle().copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_codeController.text.isNotEmpty) {
                            await Get.showOverlay(
                              loadingWidget: const OverlayLoadingIndicator(),
                              asyncFunction: () async {
                                await Get.find<DoctorController>()
                                    .authenticationCode(_codeController.text);
                              },
                            );
                          } else {
                            showToast(
                                "Please Enter Authentication Code", context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
