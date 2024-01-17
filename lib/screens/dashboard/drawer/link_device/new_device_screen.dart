import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/user_devices_controller/user_devices_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/widgets.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';

import '../../../../controller/google_fit_controller/google_fit_controller.dart';
import '../../notifications/notification_screen.dart';

class NewDeviceScreen extends StatefulWidget {
  final String? id;
  const NewDeviceScreen({Key? key, this.id}) : super(key: key);

  @override
  State<NewDeviceScreen> createState() => _NewDeviceScreenState();
}

class _NewDeviceScreenState extends State<NewDeviceScreen> {
  String? id;
  List<String> scannedDevices = [];
  // List<BluetoothDevice> devices = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Platform.isAndroid ? const DrawerSide() : null,
      appBar: AppBar(
        title: const Text("Devices"),
        automaticallyImplyLeading: !Platform.isIOS,
        leading: Platform.isIOS
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close),
              )
            : null,
        actions: [
          // IconButton(onPressed: () {
          //   FlutterBluePlus.instance.startScan(timeout: Duration(seconds: ))
          // }, icon: Icon(Icons.search)),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              Get.to(() => const NotificationScreen());
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     FlutterBluePlus.instance
      //         .startScan(timeout: const Duration(seconds: 15));
      //     FlutterBluePlus.instance.scanResults.listen((results) {
      //       for (ScanResult r in results) {
      //         if (!devices.contains(r.device)) {
      //           setState(() {
      //             devices.add(r.device);
      //           });
      //         }
      //       }
      //     });
      //   },
      //   child: Icon(Icons.search),
      // ),
      body: scannedDevices.isNotEmpty
          ? ListView.builder(
              itemCount: scannedDevices.length,
              itemBuilder: (context, index) => const ListTile(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5,
                ),
                child: Column(
                  children: [
                    if (widget.id == "12")
                      InkWell(
                        onTap: () async {
                          final gfit = Get.find<GoogleFitController>();
                          final deviceCon = Get.find<UserDevicesController>();
                          if ((await gfit.checkPermissionSetting() ?? false)) {
                            if (mounted) {
                              showToast(
                                  "Apple Health already connected!", context);
                            }
                          } else {
                            final res = await gfit.requestNeededPermissions();
                            if (res) {
                              await deviceCon.postNewUserDevice(
                                deviceName: "Apple Health",
                                bleTypeId: 40,
                              );
                            }
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/icons/devices/apple_health.png",
                                width: 50),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Apple Health",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                Text("Sync Data From Apple Health"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (widget.id == "1")
                      InkWell(
                        onTap: () async {
                          final gfit = Get.find<GoogleFitController>();
                          final deviceCon = Get.find<UserDevicesController>();
                          if ((await gfit.checkPermissionSetting() ?? false)) {
                            if (mounted) {
                              showToast(
                                  "Google Fit already connected!", context);
                            }
                          } else {
                            final res = await gfit.requestNeededPermissions();
                            if (res) {
                              await deviceCon.postNewUserDevice(
                                deviceName: "Google Fit",
                                bleTypeId: 30,
                              );
                            }
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/googlefit.webp",
                                width: 50),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Google Fit",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                Text("Sync Data From Google Fit"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (widget.id == "2") const RocheBloodGlucoseWidget(),
                    const SizedBox(height: 8),
                    if (widget.id == "3") const BloodPresure(),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Center(
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Please press and hold Microlife's \"Power On\" button until the screen show \"CL Pr\".",
                    //           style: TextStyle(
                    //               fontSize: 18,
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    if (widget.id == "4") const Text("Comming soon..."),
                    if (widget.id == "5")
                      const Text(
                          "Please press Start button of Activity Tracker"),
                    // if (widget.id == "6") const WeightScale(),
                    if (widget.id == "7")
                      const Text("Please press start button of bp device"),
                    if (widget.id == "8") const Text("Blood Glucose"),
                    if (widget.id == "9")
                      const Text("Please press start button of blood oxymeter"),
                    if (widget.id == "10")
                      const Text(
                          "Please press start button of nutrition scale"),
                    if (widget.id == "11")
                      const Text(
                          "Please press start button of body temperature device"),
                  ],
                ),
              ),
            ),
    );
  }
}

class PairDialogue extends StatelessWidget {
  const PairDialogue({
    Key? key,
    required this.scanResult,
    required this.bleTypeId,
  }) : super(key: key);
  final ScanResult scanResult;
  final int bleTypeId;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Do you want to pair this device?',
                  style: TextStyles.normalTextStyle(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.showOverlay(
                            loadingWidget: const OverlayLoadingIndicator(),
                            asyncFunction: () async {
                              await scanResult.device.connect();
                              final bool? res =
                                  await Get.find<UserDevicesController>()
                                      .postNewUserDevice(
                                deviceName: scanResult.device.name,
                                uuid: scanResult.device.id.toString(),
                                bleTypeId: bleTypeId,
                              );
                              if (res ?? false) {
                                showToast(
                                  'Device Connected!',
                                  Get.context,
                                );
                              } else {
                                showToast(
                                  'Connection failed! Try again.',
                                  Get.context,
                                );
                              }
                            });
                      },
                      child: const Text('Pair'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Roche Blood Gluecose
class RocheBloodGlucoseWidget extends StatefulWidget {
  const RocheBloodGlucoseWidget({Key? key}) : super(key: key);

  @override
  State<RocheBloodGlucoseWidget> createState() =>
      _RocheBloodGlucoseWidgetState();
}

class _RocheBloodGlucoseWidgetState extends State<RocheBloodGlucoseWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanResult>>(
      initialData: const [],
      stream: FlutterBluePlus.scanResults,
      builder: (context, snapshot) {
        final dataList = snapshot.data!
            .where((element) => element.device.name == 'meter+04444063')
            .toList();
        return dataList.isEmpty
            ? Column(
                children: [
                  Image.asset("assets/images/pairdevice1.png"),
                  Image.asset("assets/images/second.png"),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: dataList
                    .map((result) => ListTile(
                          onTap: () async {
                            if (await result.device.state.first !=
                                BluetoothDeviceState.connected) {
                              Get.dialog(
                                PairDialogue(
                                  scanResult: result,
                                  bleTypeId: 13,
                                ),
                              );
                            }
                          },
                          leading: Image.asset(
                              "assets/icons/devices/rocheglucometer.png"),
                          title: const Text("Roche Blood Gluecose"),
                          subtitle: const Text(""),
                        ))
                    .toList(),
              );
      },
    );
  }
}

// Weight Scale
// class WeightScaleWidget extends StatefulWidget {
//   const WeightScaleWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<WeightScaleWidget> createState() => _WeightScaleWidgetState();
// }

// class _WeightScaleWidgetState extends State<WeightScaleWidget> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       FlutterBluePlus.instance.startScan(timeout: const Duration(seconds: 5));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<ScanResult>>(
//         initialData: const [],
//         stream: FlutterBluePlus.instance.scanResults,
//         builder: (context, snapshot) {
//           final dataList = snapshot.data!
//               .where((element) => element.device.name == 'Health Scale')
//               .toList();
//           return dataList.isEmpty
//               ? const Text("Please step on weighing scale")
//               : Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: dataList
//                       .map((result) => ListTile(
//                                 onTap: () async {
//                                   if (await result.device.state.first !=
//                                       BluetoothDeviceState.connected) {
//                                     Get.dialog(
//                                       PairDialogue(
//                                         scanResult: result,
//                                         bleTypeId: 35,
//                                       ),
//                                     );
//                                   }
//                                 },
//                                 leading: Image.asset(
//                                     "assets/icons/devices/center_logo.webp"),
//                                 title: const Text("WeHealth Body Age Analyzer"),
//                                 subtitle: Text(""),
//                               )
//                           //ScanResultTile(
//                           //   result: result,
//                           //   deviceName: "WeHealth Body Age Analyzer",
//                           //   onTap: () async {
//                           //     if (await result.device.state.first !=
//                           //         BluetoothDeviceState.connected) {
//                           //       Get.dialog(
//                           //         PairDialogue(
//                           //           scanResult: result,
//                           //           bleTypeId: 18,
//                           //         ),
//                           //       );
//                           //     }
//                           //   },
//                           // ),
//                           )
//                       .toList(),
//                 );
//         });
//   }
// }

// class WeightScale extends StatefulWidget {
//   const WeightScale({
//     super.key,
//   });

//   @override
//   State<WeightScale> createState() => _WeightScaleState();
// }

// class _WeightScaleState extends State<WeightScale> {
//   List<BluetoothDevice> devices = [];
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 150),
//               ),
//               onPressed: () {
//                 FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
//                 FlutterBluePlus.scanResults.listen((results) {
//                   for (ScanResult r in results) {
//                     if (!devices.contains(r.device)) {
//                       setState(() {
//                         devices.add(r.device);
//                       });
//                     }
//                   }
//                 });
//               },
//               child: const Icon(Icons.search)),
//           ListView.builder(
//               itemCount: devices.length,
//               itemBuilder: (context, i) {
//                 return ListTile(
//                   // ignore: deprecated_member_use
//                   title: Text(devices[i].name),
//                   subtitle: Text(devices[i].remoteId.toString()),
//                 );
//               })
//         ],
//       ),
//     );
//   }
// }

class BloodPresure extends StatefulWidget {
  const BloodPresure({super.key});

  @override
  State<BloodPresure> createState() => _BloodPresureState();
}

class _BloodPresureState extends State<BloodPresure> {
  List<BluetoothDevice> devices = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood pressure"),
        actions: [
          IconButton(
              onPressed: () {
                FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
                FlutterBluePlus.scanResults.listen((results) {
                  for (ScanResult r in results) {
                    if (r.device.advName.startsWith("B3 BT")) {
                      if (!devices.contains(r.device)) {
                        setState(() {
                          devices.add(r.device);
                        });
                      }
                    }
                  }
                });
              },
              icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: StreamBuilder(
          stream: FlutterBluePlus.isScanning,
          builder: (context, snapshot) {
            if (snapshot.data == false) {
              return FloatingActionButton(
                onPressed: () {
                  FlutterBluePlus.startScan(
                      timeout: const Duration(seconds: 15));
                  FlutterBluePlus.scanResults.listen((results) {
                    for (ScanResult r in results) {
                      if (r.device.advName.startsWith("B3 BT")) {
                        if (!devices.contains(r.device)) {
                          setState(() {
                            devices.add(r.device);
                          });
                        }
                      }
                    }
                  });
                },
                child: const Icon(Icons.search),
              );
            } else {
              return FloatingActionButton(
                onPressed: () {
                  FlutterBluePlus.stopScan();
                },
                child: const Icon(
                  Icons.stop,
                  color: Colors.red,
                ),
              );
            }
          }),
      body: ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(devices[i].advName),
              subtitle: Text(devices[i].remoteId.toString()),
              trailing: ElevatedButton(
                  onPressed: () {
                    ConnectToDevice(devices[i]);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DevicePage1(
                        devicename: devices[i].advName,
                      );
                    }));
                  },
                  child: const Text("Connect")),
            );
          }),
    );
  }

  Future ConnectToDevice(BluetoothDevice device) async {
    await device.connect();
  }
}

class DevicePage1 extends StatefulWidget {
  final String devicename;
  const DevicePage1({super.key, required this.devicename});

  @override
  State<DevicePage1> createState() => _DevicePage1State();
}

class _DevicePage1State extends State<DevicePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.devicename),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.red,
              width: 300,
              height: 300,
            )
          ],
        ));
  }
}
