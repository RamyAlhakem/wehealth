import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static const readbloodpresure = MethodChannel("Blood_Presure");

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
                  onPressed: () async {
                    // ConnectToDevice(devices[i]);

                    await readbloodpresure.invokeMethod("ReadData");

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DevicePage1(
                        devicename: devices[i].advName,
                        device: devices[i],
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
  final BluetoothDevice device;
  const DevicePage1(
      {super.key, required this.devicename, required this.device});

  @override
  State<DevicePage1> createState() => _DevicePage1State();
}

class _DevicePage1State extends State<DevicePage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<int> values = [];
  String pul = "";
  String sys = "";
  String dia = "";
  static const getstored = MethodChannel("GetStoredRrecored");
  List<dynamic> currentData = [];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.devicename),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              sys == ""
                  ? Image.asset("assets/images/blood presure.png")
                  : Stack(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.blue,
                                Colors.lightGreen,
                                Colors.red,
                                Colors.yellow,
                              ]),
                              color: Colors.blue,
                              shape: BoxShape.circle),
                        ),
                        Positioned(
                          top: 20,
                          left: 20,
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                        Positioned(
                            left: 65,
                            top: 65,
                            child: Text(
                              "SYS",
                              style: TextStyle(color: Colors.grey),
                            )),
                        Positioned(
                            left: 108,
                            top: 65,
                            child: Text(
                              "DIA",
                              style: TextStyle(color: Colors.grey),
                            )),
                        Positioned(
                            left: 140,
                            top: 107,
                            child: Text(
                              "mmHg",
                              style: TextStyle(fontSize: 9, color: Colors.grey),
                            )),
                        Positioned(
                            left: 55,
                            top: 80,
                            child: Text(
                              "$sys/$dia",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            )),
                        Positioned(
                          left: 60,
                          top: 130,
                          child: Row(
                            children: [
                              AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _animation.value,
                                    child: Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  );
                                },
                                // child: Icon(
                                //   Icons.favorite_rounded,
                                //   color: Colors.red,
                                // ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("$pul",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 153,
                            left: 100,
                            child: Text(
                              "pul".toUpperCase(),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ))
                      ],
                    ),
              SizedBox(
                height: 150,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.blue,
                      elevation: 15,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () async {
                    final dynamic storedrecored =
                        await getstored.invokeMethod("getStoredDRecord");
                    if (storedrecored != null) {
                      setState(() {
                        currentData = storedrecored;
                        sys = currentData[0]["systole"].toString();
                        dia = currentData[0]["dia"].toString();
                        pul = currentData[0]["pul"].toString();

                        // print(" new currentdata@@@@@@@@@@ $currentData");
                        // print("${currentData[0]["systole"]}");
                        // print("${currentData[0]["dia"]}");
                        // print("${currentData[0]["pul"]}");
                        // print(" animation value===>>${_animation.value}");
                      });
                    } else {
                      print("storedrecored nullllllllll");
                    }

                    // readbloodpreure(widget.device);
                  },
                  child: Text(
                    "Blood pressure measurement".toUpperCase(),
                    style: TextStyle(
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(2, 2),
                              blurRadius: 10)
                        ],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  )),
              const Spacer(),
              Stack(
                children: [
                  ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.blue,
                    ),
                  ),
                  Positioned(
                      left: 100,
                      top: 85,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "view full history",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          )))
                ],
              )
            ],
          ),
        ));
  }

  readbloodpreure(BluetoothDevice device) async {
    await device.connect();
    device.mtu.listen((mtu) {
      print("\n\n\n\n@MTU@@@$mtu\n\n\n\n");
    });
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      List<BluetoothCharacteristic> characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        await c.setNotifyValue(true);
        if (c.properties.read) {
          List<int> value = await c.read();
          print("\n\n\n\n\n\n\n$value##@@@@#\n\n\n\n\n");
          print('UUID=>   ${c.uuid}');
        }

        c.lastValueStream.listen((value) {
          setState(() {
            values = value;
            print(" \n\n\n\n values ====>$values\n\n\n\n\n");

            getpulheart(values);
            // pul = getpulheart(values);
          });
        });
      }
    }
  }

  int getpulheart(List<int> data) {
    print("data heart ==>$data");
    String stringvalue = String.fromCharCodes(data);
    print(" stringhvalue ==>$stringvalue");
    List<String> parts = stringvalue.split('.');
    print("parts ==>$parts");
    if (parts.isNotEmpty) {
      String pulsstring = parts.last;
      int puls = int.tryParse(pulsstring) ?? 0;
      return puls;
    } else {
      return 0;
    }
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height - 140,
        size.width * 0.50, size.height - 90);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 50, size.width, size.height - 130);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
