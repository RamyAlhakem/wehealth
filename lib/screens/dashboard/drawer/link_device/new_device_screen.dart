import 'dart:async';
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
import 'package:wehealth/screens/dashboard/drawer/link_device/ble/HistoryController.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/widgets.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:provider/provider.dart';
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
  bool loading = false;
  static const scandevice = MethodChannel("Scan_Device");

  Future searchfordevice() async {
    await scandevice.invokeMethod("ScanDevices");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood pressure"),
        actions: [
          IconButton(
              onPressed: () async {
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
                searchfordevice();
              },
              icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: StreamBuilder(
          stream: FlutterBluePlus.isScanning,
          builder: (context, snapshot) {
            if (snapshot.data == false) {
              return FloatingActionButton(
                onPressed: () async {
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
                  searchfordevice();
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
                    setState(() {
                      loading = true;
                    });
                    Future.delayed(const Duration(seconds: 4), () {
                      setState(() {
                        loading = false;
                        Provider.of<HistoryController>(context, listen: false)
                            .enablebutton();
                      });
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DevicePage1(
                          devicename: devices[i].advName,
                          device: devices[i],
                        );
                      }));
                    });
                  },
                  child: loading
                      ? Container(
                          height: 18,
                          width: 20,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text("Connect")),
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
    with TickerProviderStateMixin {
  late AnimationController _controller2;
  late Animation _animation2;
  late AnimationController _controller;
  late AnimationController _controller1;
  late Animation _animation1;
  late Animation<double> _animation;
  List<int> values = [];
  int pul = 0;
  int sys = 0;
  int dia = 0;
  double move = 0.0;
  String result = "";
  bool isnormal = true;
  Color colorchange = Colors.grey;
  double fontchange = 14;
  late Timer _timer;

  static const getstored = MethodChannel("GetStoredRrecored");
  List<dynamic> currentData = [];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation1 = Tween(begin: 0.0, end: 1.1).animate(_controller1);
    _controller2 = AnimationController(
        vsync: this, duration: const Duration(seconds: 1000))
      ..repeat(reverse: true);
    _animation2 = Tween(begin: 50.0, end: 200.0).animate(_controller2);
    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   setState(() {
    //     colorchange = colorchange == Colors.grey ? Colors.red : Colors.grey;
    //     fontchange = fontchange == 14 ? 7 : 14;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.devicename),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenheight / 20,
              ),
              AnimatedBuilder(
                  animation: _animation1,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation1.value,
                      child: Text(
                        result,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: isnormal ? Colors.green : Colors.red),
                      ),
                    );
                  }),
              SizedBox(
                height: screenheight / 10,
              ),
              sys == 0
                  ? Image.asset(
                      "assets/images/blood presure.png",
                      width: screenwidth,
                      height: screenheight / 4,
                    )
                  : Stack(
                      children: [
                        AnimatedBuilder(
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: 3.14 / 2 * _animation2.value,
                              child: Container(
                                width: screenwidth / 1.2,
                                height: screenheight / 3,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.blue,
                                      Colors.lightGreen,
                                      Colors.red,
                                      Colors.yellow,
                                    ]),
                                    shape: BoxShape.circle),
                              ),
                            );
                          },
                          animation: _animation2,
                        ),
                        Positioned(
                          top: 20,
                          left: 20,
                          child: Container(
                            width: screenwidth / 1.37,
                            height: screenheight / 3.5,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                        Positioned(
                            left: screenwidth / 3.5,
                            top: screenheight / 10,
                            child: const AnimatedDefaultTextStyle(
                              duration: Duration(seconds: 1),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                              child: Text("SYS"),
                            )),
                        Positioned(
                            left: screenwidth / 2,
                            top: screenheight / 10,
                            child: const AnimatedDefaultTextStyle(
                              duration: Duration(seconds: 1),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                              child: Text("DIA"),
                            )),
                        Positioned(
                            left: screenwidth / 1.7,
                            top: screenheight / 6.6,
                            child: const AnimatedDefaultTextStyle(
                              duration: Duration(seconds: 1),
                              style: TextStyle(fontSize: 9, color: Colors.grey),
                              child: Text("mmHg"),
                            )),
                        Positioned(
                            left: screenwidth / 2.5,
                            top: screenheight / 8.2,
                            child: const Text(
                              "/",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            )),
                        Positioned(
                            left: screenwidth / 3.9,
                            top: screenheight / 8.5,
                            child: Text(
                              "$sys",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                        Positioned(
                            left: screenwidth / 2.1,
                            top: screenheight / 8.5,
                            child: Text(
                              "$dia",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                        Positioned(
                          left: screenwidth / 3,
                          top: screenheight / 5,
                          child: Row(
                            children: [
                              AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _animation.value,
                                    child: const Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("$pul",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        Positioned(
                            top: screenheight / 4.2,
                            left: screenwidth / 2.2,
                            child: const AnimatedDefaultTextStyle(
                              duration: Duration(seconds: 1),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                              child: Text("PUL"),
                            ))
                      ],
                    ),
              // SizedBox(
              //   height: screenheight / 7,
              // ),
              // Expanded(
              //   flex: 3,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //           shadowColor: Colors.blue,
              //           elevation: 15,
              //           padding: const EdgeInsets.symmetric(horizontal: 40),
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(30))),
              //       onPressed: () async {
              //         final dynamic storedrecored =
              //             await getstored.invokeMethod("getStoredDRecord");
              //         if (storedrecored != null) {
              //           setState(() {
              //             currentData = storedrecored;
              //             sys = currentData[0]["systole"];
              //             dia = currentData[0]["dia"];
              //             pul = currentData[0]["pul"];
              //             if (sys < 120 && dia < 80) {
              //               result = "Excellent";
              //               _controller1..forward();
              //             } else {
              //               result = "High pressure";
              //               isnormal = false;
              //               _controller1.forward();
              //             }
              //             Provider.of<HistoryController>(context, listen: false)
              //                 .save(currentData[0]);
              //             print("===================>>>${currentData[0]}");

              //             // print(" new currentdata@@@@@@@@@@ $currentData");
              //             // print("${currentData[0]["systole"]}");
              //             // print("${currentData[0]["dia"]}");
              //             // print("${currentData[0]["pul"]}");
              //             // print(" animation value===>>${_animation.value}");
              //           });
              //         } else {
              //           print("storedrecored nullllllllll");
              //         }

              //         // readbloodpreure(widget.device);
              //       },
              //       child: Text(
              //         "Blood pressure measurement".toUpperCase(),
              //         style: const TextStyle(
              //             shadows: [
              //               Shadow(
              //                   color: Colors.black,
              //                   offset: Offset(2, 2),
              //                   blurRadius: 10)
              //             ],
              //             fontWeight: FontWeight.bold,
              //             fontStyle: FontStyle.italic),
              //       )),
              // ),
              const Spacer(),
              Stack(
                children: [
                  ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      width: screenwidth,
                      height: screenheight / 3.5,
                      color: Colors.blue,
                    ),
                  ),
                  Positioned(
                      left: screenwidth / 2.2,
                      top: screenheight / 6.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue),
                          onPressed: Provider.of<HistoryController>(context)
                                  .isenable
                              ? () async {
                                  final dynamic storedrecored = await getstored
                                      .invokeMethod("getStoredDRecord");
                                  if (storedrecored != null) {
                                    setState(() {
                                      currentData = storedrecored;
                                      sys = currentData[0]["systole"];
                                      dia = currentData[0]["dia"];
                                      pul = currentData[0]["pul"];
                                      if (sys < 120 && dia < 80) {
                                        result = "Excellent";
                                        _controller1..forward();
                                      } else {
                                        result = "High pressure";
                                        isnormal = false;
                                        _controller1.forward();
                                      }
                                      Provider.of<HistoryController>(context,
                                              listen: false)
                                          .save(currentData[0]);
                                      Provider.of<HistoryController>(context,
                                              listen: false)
                                          .disablebutton();
                                      Provider.of<HistoryController>(context,
                                              listen: false)
                                          .SaveData();

                                      print(
                                          "===================>>>${currentData[0]}");

                                      print(
                                          " new currentdata@@@@@@@@@@ $currentData");
                                      print("${currentData[0]["systole"]}");
                                      print("${currentData[0]["dia"]}");
                                      print("${currentData[0]["pul"]}");
                                      print(
                                          " animation value===>>${_animation.value}");
                                    });
                                  } else {
                                    print("storedrecored nullllllllll");
                                  }

                                  // readbloodpreure(widget.dev
                                }
                              : null,
                          child: const Text(
                            "Blood Presure",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ))),
                  Positioned(
                      left: screenwidth / 2.2,
                      top: screenheight / 4.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ViewFullHistory(
                                datahistory: updatedata,
                              );
                            }));
                          },
                          child: const Text(
                            "view  history",
                            style: TextStyle(
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

  List get updatedata {
    return currentData;
  }

  // readbloodpreure(BluetoothDevice device) async {
  //   await device.connect();
  //   device.mtu.listen((mtu) {
  //     print("\n\n\n\n@MTU@@@$mtu\n\n\n\n");
  //   });
  //   List<BluetoothService> services = await device.discoverServices();
  //   for (BluetoothService service in services) {
  //     List<BluetoothCharacteristic> characteristics = service.characteristics;
  //     for (BluetoothCharacteristic c in characteristics) {
  //       await c.setNotifyValue(true);
  //       if (c.properties.read) {
  //         List<int> value = await c.read();
  //         print("\n\n\n\n\n\n\n$value##@@@@#\n\n\n\n\n");
  //         print('UUID=>   ${c.uuid}');
  //       }

  //       c.lastValueStream.listen((value) {
  //         setState(() {
  //           values = value;
  //           print(" \n\n\n\n values ====>$values\n\n\n\n\n");

  //           getpulheart(values);
  //           // pul = getpulheart(values);
  //         });
  //       });
  //     }
  //   }
  // }

  // int getpulheart(List<int> data) {
  //   print("data heart ==>$data");
  //   String stringvalue = String.fromCharCodes(data);
  //   print(" stringhvalue ==>$stringvalue");
  //   List<String> parts = stringvalue.split('.');
  //   print("parts ==>$parts");
  //   if (parts.isNotEmpty) {
  //     String pulsstring = parts.last;
  //     int puls = int.tryParse(pulsstring) ?? 0;
  //     return puls;
  //   } else {
  //     return 0;
  //   }
  // }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height - 180,
        size.width * 0.50, size.height - 140);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 85, size.width, size.height - 215);
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

class ViewFullHistory extends StatefulWidget {
  final List datahistory;
  const ViewFullHistory({super.key, required this.datahistory});

  @override
  State<ViewFullHistory> createState() => _ViewFullHistoryState();
}

class _ViewFullHistoryState extends State<ViewFullHistory> {
  @override
  void initState() {
    Provider.of<HistoryController>(context, listen: false).LoadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  Provider.of<HistoryController>(context, listen: false)
                      .clearhistory();
                });
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child:
              Consumer<HistoryController>(builder: (context, history, child) {
            return Provider.of<HistoryController>(context).updatehistory.isEmpty
                ? const Center(
                    child: Text("Empty History"),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, i) {
                      return const SizedBox(
                        height: 40,
                      );
                    },
                    itemCount: history.updatehistory.length,
                    itemBuilder: (context, i) {
                      return Stack(
                        children: [
                          Container(
                            width: screenwidth,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 216, 236, 232),
                              border: Border(
                                  right: BorderSide(
                                      color: (history.updatehistory[i]
                                                      ["systole"] >
                                                  121 ||
                                              history.updatehistory[i]["dia"] >
                                                  80)
                                          ? Colors.red
                                          : Colors.green,
                                      width: 15)),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Date: ",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                        "${history.updatehistory[i]["day"]}/${history.updatehistory[i]["month"]}/${history.updatehistory[i]["year"]}"),
                                    SizedBox(
                                      width: screenwidth / 4,
                                    ),
                                    const Text(
                                      "Time: ",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                        "${history.updatehistory[i]["hour"]}:${history.updatehistory[i]["mint"]}")
                                  ],
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "SYS: ",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      "${history.updatehistory[i]["systole"]} ",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "mmHg",
                                      style: TextStyle(fontSize: 9),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "DIA: ",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      "${history.updatehistory[i]["dia"]} ",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "mmHg",
                                      style: TextStyle(fontSize: 9),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "PUL: ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      "${history.updatehistory[i]["pul"]} ",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "BPM",
                                      style: TextStyle(fontSize: 9),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              left: screenwidth / 2.1,
                              top: screenheight / 15,
                              child: Container(
                                  color:
                                      const Color.fromARGB(255, 216, 236, 232),
                                  width: 150,
                                  height: 100,
                                  child: Image.asset("assets/images/eco81.png")
                                  // CustomPaint(
                                  //   foregroundPainter: Linnerpainter(),
                                  // ),
                                  )),

                          // Positioned(
                          //     left: screenwidth / 1.55,
                          //     top: screenheight / 15.5,
                          //     child: Icon(
                          //       Icons.favorite_rounded,
                          //       color: Colors.red,
                          //       size: 40,
                          //     ))
                        ],
                      );
                      // ListTile(
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30)),
                      //   tileColor: const Color.fromARGB(255, 216, 236, 232),
                      //   title: Row(
                      //     children: [
                      //       Text(
                      //         "${history.updatehistory[i]["day"]}/${history.updatehistory[i]["month"]}/${history.updatehistory[i]["year"]}",
                      //         style: const TextStyle(fontSize: 15),
                      //       ),
                      //       const SizedBox(
                      //         width: 60,
                      //       ),
                      //       Text(
                      //           "${history.updatehistory[i]["hour"]}:${history.updatehistory[i]["mint"]}")
                      //     ],
                      //   ),
                      //   trailing: const Icon(
                      //     Icons.done_rounded,
                      //     color: Colors.green,
                      //   ),
                      //   leading: const Icon(
                      //     Icons.favorite_rounded,
                      //     color: Colors.blue,
                      //   ),
                      //   subtitle: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Row(
                      //       children: [
                      //         const Text(
                      //           "SYS ",
                      //           style: TextStyle(color: Colors.grey, fontSize: 12),
                      //         ),
                      //         Text(
                      //           "${history.updatehistory[i]["systole"]}",
                      //           style: const TextStyle(
                      //               fontSize: 18, fontWeight: FontWeight.bold),
                      //         ),
                      //         const Text(
                      //           "mmHg",
                      //           style: TextStyle(fontSize: 9, color: Colors.grey),
                      //         ),
                      //         const SizedBox(
                      //           width: 10,
                      //         ),
                      //         const Text("DIA ",
                      //             style:
                      //                 TextStyle(color: Colors.grey, fontSize: 12)),
                      //         Text("${history.updatehistory[i]["dia"]}",
                      //             style: const TextStyle(
                      //                 fontSize: 18, fontWeight: FontWeight.bold)),
                      //         const Text(
                      //           "mmHg",
                      //           style: TextStyle(fontSize: 9, color: Colors.grey),
                      //         ),
                      //         const SizedBox(
                      //           width: 10,
                      //         ),
                      //         const Text("PUL ",
                      //             style:
                      //                 TextStyle(color: Colors.grey, fontSize: 12)),
                      //         Text("${history.updatehistory[i]["pul"]}",
                      //             style: const TextStyle(
                      //                 fontSize: 18, fontWeight: FontWeight.bold)),
                      //         const Text(
                      //           "BPM",
                      //           style: TextStyle(fontSize: 9, color: Colors.grey),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    });
          })),
    );
  }
}

class Linnerpainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(size.width * 1 / 6, size.height * 1 / 2),
        Offset(size.width * 5 / 6, size.height * 1 / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
