import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/auth_controller/auth_controller.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/global/styles/button_style.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import '../../../global/constants/color_resources.dart';
import '../../../global/styles/text_styles.dart';
import '../drawer/drawer_items.dart';
import '../notifications/notification_screen.dart';
import '../sleep/sleep_detail_screen.dart';

class MyHealthScreen extends StatefulWidget {
  const MyHealthScreen({Key? key}) : super(key: key);

  @override
  State<MyHealthScreen> createState() => _MyHealthScreenState();
}

class _MyHealthScreenState extends State<MyHealthScreen> {
  final pageColor = ColorResources.myHealthScreenColor;
  final _icController = TextEditingController();
  final _mrnController = TextEditingController();
  String selectedHospital = "Select a hospital";
  late bool isVarified = false;
  String _isConnect = "Select an option";
  @override
  void initState() {
    super.initState();
    final profile = Get.find<ProfileController>();
    log(profile.userProfile.loginType.toString());
    isVarified = profile.userProfile.loginType != "0" &&
        profile.userProfile.loginType != "";
    if (isVarified) {
      _isConnect = "Yes";
      _icController.text = profile.userProfile.icNumber ?? "";
      _mrnController.text = profile.userHospitalRelation?.refID ?? "";
    }
    Get.find<ProfileController>().fetchProfileHospitalList();
  }

  //For not varified view!
  bool _isIntro = true;
  @override
  Widget build(BuildContext context) {
    Widget varifiedView = GestureDetector(
      onTap: () {
        Get.to(() => const SleepDetailsScreen());
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: pageColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "My Health",
                style: TextStyles.normalTextBoldStyle()
                    .copyWith(color: Colors.white),
              ),
            ),
            const Divider(
              thickness: 1,
              color: ColorResources.colorWhite,
            ),
            const SizedBox(height: 8),
            Expanded(
                child: GetBuilder<ProfileController>(builder: (controller) {
              return Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    "Connect With Hospital",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.smallTextBoldStyle(),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 4,
                                  child: SizedBox(
                                    height: 50,
                                    child: DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      decoration: decoration,
                                      value: _isConnect,
                                      alignment: Alignment.center,
                                      items: [
                                        "Select an option",
                                        "Yes",
                                        "No",
                                      ]
                                          .map((value) =>
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: isVarified
                                          ? null
                                          : (value) {
                                              setState(() {
                                                _isConnect = value!;
                                              });
                                            },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Select Hospital",
                              style: TextStyles.smallTextBoldStyle(),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 50,
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                decoration: decoration,
                                value: controller.getSelectedHospital?.name,
                                alignment: Alignment.center,
                                items: [
                                  "Select a hospital",
                                  ...?controller.profileHospitals
                                      ?.map((e) => e.name!)
                                      .toList()
                                ]
                                    .map((value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            maxLines: 1,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: isVarified
                                    ? null
                                    : (value) {
                                        setState(() {
                                          selectedHospital = value!;
                                        });
                                      },
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              "NRIC or Passport Number",
                              style: TextStyles.smallTextBoldStyle(),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                enabled: !isVarified,
                                keyboardType: TextInputType.number,
                                controller: _icController,
                                decoration: decoration.copyWith(
                                  hintText: "99XXXXXXXXXX",
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              "MRN Number",
                              style: TextStyles.smallTextBoldStyle(),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                enabled: !isVarified,
                                keyboardType: TextInputType.number,
                                controller: _mrnController,
                                decoration: decoration.copyWith(
                                  hintText: "123456",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset("assets/images/ummc.png"),
                    ),
                  ),
                ],
              );
            }))
          ],
        ),
      ),
    );
    return 
    Scaffold(
      drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      appBar: AppBar(
        backgroundColor: pageColor,
        title: const Text("My Health"),
           automaticallyImplyLeading: !Platform.isIOS,
        leading: Platform.isIOS  
        ?  IconButton(onPressed: (){
          Get.back();
          }, icon: const Icon(Icons.close),) 
        : null,
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

      body: Builder(builder: (BuildContext context) {
        return isVarified
            ? varifiedView
            : AnimatedCrossFade(
                layoutBuilder:
                    (topChild, topChildKey, bottomChild, bottomChildKey) =>
                        LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: Stack(
                        children: [topChild, bottomChild],
                      ),
                    );
                  },
                ),
                crossFadeState: _isIntro
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isIntro = false;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: pageColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "My Health",
                            style: TextStyles.normalTextBoldStyle()
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: ColorResources.colorWhite,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Connect With Hospital",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles.smallTextBoldStyle()
                                              .copyWith(
                                                  color: ColorResources
                                                      .colorWhite),
                                        ),
                                        SizedBox(width: 24),
                                        Text(
                                          "No",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles.smallTextBoldStyle()
                                              .copyWith(
                                                  color: ColorResources
                                                      .colorWhite),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    Text(
                                      "Tab here to connect",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.smallTextBoldStyle()
                                          .copyWith(
                                              color: ColorResources.colorWhite),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset("assets/images/ummc.png"),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                secondChild: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: pageColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "My Health",
                                style: TextStyles.normalTextBoldStyle()
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: ColorResources.colorWhite,
                            ),
                            const SizedBox(height: 8),
                            Expanded(child: GetBuilder<ProfileController>(
                                builder: (controller) {
                              return Column(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    "Connect With Hospital",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyles
                                                        .smallTextBoldStyle(),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  flex: 4,
                                                  child: SizedBox(
                                                    height: 50,
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      isExpanded: true,
                                                      decoration: decoration,
                                                      value: _isConnect,
                                                      alignment:
                                                          Alignment.center,
                                                      items: [
                                                        "Select an option",
                                                        "Yes",
                                                        "No",
                                                      ]
                                                          .map((value) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                  value,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      true,
                                                                  maxLines: 1,
                                                                ),
                                                              ))
                                                          .toList(),
                                                      onChanged: isVarified
                                                          ? null
                                                          : (value) {
                                                              setState(() {
                                                                _isConnect =
                                                                    value!;
                                                              });
                                                            },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            if (_isConnect == "Yes") ...[
                                              Text(
                                                "Select Hospital",
                                                style: TextStyles
                                                    .smallTextBoldStyle(),
                                              ),
                                              const SizedBox(height: 12),
                                              SizedBox(
                                                height: 50,
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  isExpanded: true,
                                                  decoration: decoration,
                                                  value: selectedHospital,
                                                  alignment: Alignment.center,
                                                  items: [
                                                    "Select a hospital",
                                                    ...?controller
                                                        .profileHospitals
                                                        ?.map((e) => e.name!)
                                                        .toList()
                                                  ]
                                                      .map((value) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(
                                                              value,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: true,
                                                              maxLines: 1,
                                                            ),
                                                          ))
                                                      .toList(),
                                                  onChanged: isVarified
                                                      ? null
                                                      : (value) {
                                                          setState(() {
                                                            selectedHospital =
                                                                value!;
                                                          });
                                                        },
                                                ),
                                              ),
                                            ],
                                            const SizedBox(height: 24),
                                            if (selectedHospital !=
                                                "Select a hospital") ...[
                                              Text(
                                                "NRIC or Passport Number",
                                                style: TextStyles
                                                    .smallTextBoldStyle(),
                                              ),
                                              const SizedBox(height: 12),
                                              SizedBox(
                                                height: 50,
                                                child: TextFormField(
                                                  textCapitalization:
                                                      TextCapitalization.none,
                                                  enabled: !isVarified,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _icController,
                                                  decoration:
                                                      decoration.copyWith(
                                                    hintText: "99XXXXXXXXXX",
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 24),
                                              Text(
                                                "MRN Number",
                                                style: TextStyles
                                                    .smallTextBoldStyle(),
                                              ),
                                              const SizedBox(height: 12),
                                              SizedBox(
                                                height: 50,
                                                child: TextFormField(
                                                  textCapitalization:
                                                      TextCapitalization.none,
                                                  enabled: !isVarified,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _mrnController,
                                                  decoration:
                                                      decoration.copyWith(
                                                    hintText: "123456",
                                                  ),
                                                ),
                                              ),
                                            ]
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child:
                                          Image.asset("assets/images/ummc.png"),
                                    ),
                                  ),
                                ],
                              );
                            }))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: pageColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                onPressed: () async {},
                                child: Text(
                                  "Save",
                                  style: TextStyles.smallTextBoldStyle()
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                duration: const Duration(milliseconds: 300),
              );
      }),
    );
  }
}

class VarifyOTPWidget extends StatelessWidget {
  const VarifyOTPWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 350,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.lock,
                  size: 32,
                  color: Colors.red,
                ),
              ),
              Text(
                "A varification code has been sent to your contact number. Please varify by inserting the code here!",
                textAlign: TextAlign.center,
                style: TextStyles.smallTextStyle(),
              ),
              // SizedBox(height: 24),
              const Spacer(),
              SizedBox(
                height: 80,
                child: TextFormField(
                  controller: controller,
                  expands: false,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: decoration.copyWith(
                      // hintText: "XXXXXX",
                      ),
                ),
              ),
              const SizedBox(height: 10),
              GetBuilder<AuthController>(builder: (authCon) {
                return SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyles.getBlueStyle(context),
                    onPressed: () async {
                      final res =
                          await authCon.validatePhoneOTP(controller.text);
                      Get.back();
                      if (res) {
                        Get.snackbar(
                          "OTP Varification!",
                          "Your phone number has been varified!",
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                        );
                      } else {
                        Get.snackbar(
                          "OTP Varification!",
                          "Failed to varify!",
                          backgroundColor: Colors.red,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                        );
                      }
                    },
                    child: Text(
                      "VARIFY OTP",
                      style: TextStyles.smallTextBoldStyle()
                          .copyWith(color: Colors.white),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
