import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/ble/WeightHistoryController.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/new_device_screen.dart';

import '../../notifications/notification_screen.dart';

class AddNewDeviceScreen extends StatefulWidget {
  const AddNewDeviceScreen({Key? key}) : super(key: key);

  @override
  State<AddNewDeviceScreen> createState() => _AddNewDeviceScreenState();
}

class _AddNewDeviceScreenState extends State<AddNewDeviceScreen> {
  List<String> itemsList = [
    "Google Fit",
    "Roche Blood Glucose",
    "Microlife Blood Pressure",
    "Rossmax Blood Pressure",
    "Activity Tracker",
    "Weighing Scale",
    "Blood Pressure",
    "Blood Glucose",
    "Blood Oxygen",
  ];
  List<String> imageList = [
    "Google Fit",
    "Roche Blood Glucose",
    "Microlife Blood Pressure",
    "Rossmax Blood Pressure",
    "Activity Tracker",
    "Weighing Scale",
    "Blood Pressure",
    "Blood Glucose",
    "Blood Oxygen",
  ];

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
          // IconButton(
          //   padding: EdgeInsets.zero,
          //   onPressed: () async {
          //     Get.to(() => const TestingConnectedDevicesScreen());
          //   },
          //   icon: const Icon(
          //     Icons.bluetooth_connected,
          //   ),
          // ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              Get.to(() => const NotificationScreen());
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: ListView(
        children: [
          if (Platform.isAndroid)
            AddDeviceItemWidget(
              id: "1",
              title: "Google Fit",
              imgLink: "assets/images/googlefit.webp",
              onTap: () {
                Get.to(() => const NewDeviceScreen(id: "1"));
              },
            ),
          if (Platform.isIOS)
            AddDeviceItemWidget(
              id: "12",
              title: "Apple Health",
              imgLink: "assets/icons/devices/apple_health.png",
              onTap: () {
                Get.to(() => const NewDeviceScreen(id: "12"));
              },
            ),
          AddDeviceItemWidget(
            id: "2",
            title: "Roche Blood Glucose",
            imgLink: "assets/images/rocheglucometer.png",
            onTap: () {
              Get.to(() => const NewDeviceScreen(id: "2"));
            },
          ),
          AddDeviceItemWidget(
            id: "3",
            title: "Microlife Blood Pressure",
            imgLink: "assets/images/microlife_bp.png",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BloodPresure();
              }));
              // Get.to(() => const NewDeviceScreen(id: "3"));
            },
          ),
          AddDeviceItemWidget(
            id: "4",
            title: "Rossmax Blood Pressure",
            imgLink: "assets/images/rossmax_meter.png",
            onTap: () {
              showToast("Comming soon...", context);
            },
          ),
          AddDeviceItemWidget(
            id: "5",
            title: "Activity Tracker",
            imgLink: "assets/images/mnu_activity.webp",
            color: Colors.blue,
            onTap: () {
              Get.to(() => const NewDeviceScreen(id: "5"));
            },
            subtitle: "Add Device",
          ),
          AddDeviceItemWidget(
            id: "6",
            title: "Weighing Scale",
            imgLink: "assets/images/mnu_bweight_l.webp",
            color: Colors.blue,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return WeightScale();
              }));
              // Get.to(() => const NewDeviceScreen(id: "6"));
            },
            subtitle: "Add Device",
          ),
          AddDeviceItemWidget(
            id: "7",
            title: "Blood Pressure",
            imgLink: "assets/images/mnu_bp_l.webp",
            color: Colors.blue,
            onTap: () {
              Get.to(() => const NewDeviceScreen(id: "7"));
            },
            subtitle: "Add Device",
          ),
          AddDeviceItemWidget(
            id: "8",
            title: "Blood Glucose",
            imgLink: "assets/images/pic_bloodsugar.webp",
            color: Colors.blue,
            onTap: () {
              Get.to(() => const NewDeviceScreen(id: "8"));
            },
          ),
          AddDeviceItemWidget(
            id: "9",
            title: "Blood Oxygen",
            imgLink: "assets/icons/devices/new_device/mnu_bo_l.webp",
            color: Colors.blue,
            onTap: () {
              Get.to(() => const NewDeviceScreen(id: "9"));
            },
            subtitle: "Add Device",
          ),
          AddDeviceItemWidget(
            id: "10",
            title: "Nutritionist Scale",
            imgLink: "assets/icons/devices/new_device/mnu_food.webp",
            color: Colors.blue,
            onTap: () {
              Get.to(() => const NewDeviceScreen(id: "8"));
            },
            subtitle: "Add Device",
          ),
          AddDeviceItemWidget(
            id: "11",
            title: "Nutritionist Scale",
            imgLink: "assets/icons/devices/bodytempicon.webp",
            color: Colors.blue,
            onTap: () {
              Get.to(() => const NewDeviceScreen(id: "8"));
            },
            subtitle: "Add Device",
          ),
        ],
      ),
    );
  }
}

class AddDeviceItemWidget extends StatelessWidget {
  const AddDeviceItemWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.imgLink,
    required this.onTap,
    this.subtitle,
    this.color,
  }) : super(key: key);
  final String id;
  final String imgLink;
  final String title;
  final String? subtitle;
  final Color? color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      horizontalTitleGap: 18,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      leading: Image.asset(
        imgLink,
        color: color,
      ),
      subtitle: Text(subtitle ?? ""),
      title: Text(
        title,
        style: TextStyles.normalTextBoldStyle().copyWith(
          color: Colors.grey.shade800,
        ),
      ),
    );
  }
}

class TestingConnectedDevicesScreen extends StatefulWidget {
  const TestingConnectedDevicesScreen({Key? key}) : super(key: key);

  @override
  State<TestingConnectedDevicesScreen> createState() =>
      _TestingConnectedDevicesScreenState();
}

class _TestingConnectedDevicesScreenState
    extends State<TestingConnectedDevicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connected Devices'),
      ),
      // body: FutureBuilder<List<BluetoothDevice>>(
      //     initialData: const [],
      //     future: FlutterBluePlus.instance.connectedDevices,
      //     builder: (context, snapshot) {
      //       final dataList = snapshot.data!;
      //       return dataList.isEmpty
      //           ? const Text("No connected devices!")
      //           : Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: dataList
      //                   .map(
      //                     (result) => ListTile(
      //                       title: Text(result.name),
      //                       subtitle: Text(
      //                         result.id.toString(),
      //                       ),
      //                       onTap: () {
      //                         Get.to(
      //                           () => DeviceServicesScreen(device: result),
      //                         );
      //                       },
      //                     ),
      //                   )
      //                   .toList(),
      //             );
      //     }),
    );
  }
}

class DeviceServicesScreen extends StatelessWidget {
  const DeviceServicesScreen({Key? key, required this.device})
      : super(key: key);
  static const deviceKey = "0000180a-0000-1000-8000-00805f9b34fb";
  final BluetoothDevice device;
  @override
  Widget build(BuildContext context) {
    device.discoverServices();

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<BluetoothService>>(
        initialData: const [],
        stream: device.services,
        builder: (context, snapshot) => ListView.builder(
          itemBuilder: (context, index) {
            final data = snapshot.data![index];
            return ListTile(
              title: Text(
                data.uuid.toString(),
              ),
              //subtitle: Text(data.deviceId.toString()),
              onTap: () {
                log(data.toString());
                Get.to(() => ServiceCharecteristicsScreen(service: data));
              },
            );
          },
          itemCount: snapshot.data!.length,
        ),
      ),
    );
  }
}

class ServiceCharecteristicsScreen extends StatefulWidget {
  const ServiceCharecteristicsScreen({Key? key, required this.service})
      : super(key: key);

  final BluetoothService service;

  @override
  State<ServiceCharecteristicsScreen> createState() =>
      _ServiceCharecteristicsScreenState();
}

class _ServiceCharecteristicsScreenState
    extends State<ServiceCharecteristicsScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    for (var element in widget.service.characteristics) {
      await element.setNotifyValue(true);
      element.value.listen(callBack);
    }
  }

  callBack(List<int> value) {
    log('##Data Readed! => $value');
  }

  @override
  void dispose() {
    widget.service.characteristics.forEach((element) {
      element.setNotifyValue(false);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: widget.service.characteristics.length,
        itemBuilder: (context, index) {
          final char = widget.service.characteristics[index];
          return ListTile(
            title: Text(
              char.deviceId.toString(),
            ),
            onTap: () async {
              final res = await char.read();
              log(res.toString());
              String data = '';
              res.forEach((element) {
                data = data + element.toRadixString(16);
              });
              log("Converted data => $data || length => ${data.length}");
            },
          );
        },
      ),
    );
  }
}

class WeightScale extends StatefulWidget {
  const WeightScale({
    super.key,
  });

  @override
  State<WeightScale> createState() => _WeightScaleState();
}

class _WeightScaleState extends State<WeightScale> {
  late StreamSubscription connectionstatenow;
  BluetoothConnectionState currentconnection =
      BluetoothConnectionState.disconnected;
  List<BluetoothDevice> devices = [];
  List<int> values = [];
  double myweight = 0.0;
  double calculateWeightNew(List<int> data) {
    // int weight = (data[4] << 8) | (data[5] & 0xFF);
    // double weightrec = 0.1 * weight;
    // return weightrec;
    int temp = data[4];
    data[4] = data[5];
    data[5] = temp;
    String weightHex =
        '${data[4].toRadixString(16).padLeft(2, '0')}${data[5].toRadixString(16).padLeft(2, '0')}';
    int weightDecimal = int.parse(weightHex, radix: 16);
    double weight = weightDecimal / 100.0;
    return weight;
  }

  List<int> calculatePresureBlood(List<int> data) {
    int systolic = ((data[1] << 8) | data[0]) & 0xFFFF;
    int diastolic = ((data[3] << 8) | data[2]) & 0xFFFF;
    return [systolic, diastolic];
  }

  Future connectToDevice(BluetoothDevice device) async {
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
        }
        // ignore: deprecated_member_use
        c.value.listen((value) {
          setState(() {
            values = value;
            calculateWeightNew(values);
            myweight = calculateWeightNew(values);
            print("\n\n\n\n\n data weight  :$myweight\n\n\n\n\n\n\n\n\n");
            print("\n\n\n\n UUID=>   ${c.uuid}\n\n\n\n\n");
            print('\n\n\n\n values =>${values}');
            //  values =>[49, 48, 58, 50, 52, 58, 51, 49, 32, 65, 117, 103, 32, 49, 48, 32, 50, 48, 49, 55]
            // values =>[48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 102]
          });
        });
      }
    }
    // ignore: deprecated_member_use
  }

  @override
  void initState() {
    super.initState();
  }

  // ignore: non_constant_identifier_names
//   Future<void> connectToDevice(BluetoothDevice device) async {
//   try {
//     await device.connect();
//     device.mtu.listen((mtu) {
//       print("\n\n\n\n@MTU@@@$mtu\n\n\n\n");
//     });
//     List<BluetoothService> services = await device.discoverServices();
//     for (BluetoothService service in services) {
//       List<BluetoothCharacteristic> characteristics = service.characteristics;
//       for (BluetoothCharacteristic c in characteristics) {
//         try {
//           if (c.properties.notify || c.properties.indicate) {
//             await c.setNotifyValue(true);
//             if (c.properties.read) {
//               List<int> value = await c.read();
//               print("\n\n\n\n\n\n\n$value##@@@@#\n\n\n\n\n");
//               print('UUID=>   ${c.uuid}');
//             }
//             c.value.listen((value) {
//               setState(() {
//                 values = value;
//                 calculateWeightNew(values);
//                 myweight = calculateWeightNew(values);
//                 print("\n\n\n\n\n my weight =>$myweight\n\n\n");
//               });
//             });
//           } else {
//             print('Characteristic does not support notifications or indications');
//           }
//         } catch (e) {
//           print("Error: $e");
//         }
//       }
//     }
//   } catch (error) {
//     print("Connection Error: $error");
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  FlutterBluePlus.startScan(
                      timeout: const Duration(seconds: 15));
                  FlutterBluePlus.scanResults.listen((results) {
                    for (ScanResult r in results) {
                      if (r.device.advName.startsWith("ADORE1") ||
                          r.device.advName.startsWith("Electronic Scale")) {
                        setState(() {
                          if (!devices.contains(r.device)) {
                            devices.add(r.device);
                          }
                        });
                      }
                    }
                  });
                },
                icon: Icon(Icons.search))
          ],
          title: Text("weight scale".toUpperCase()),
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
                        // if (!devices.contains(r.device)) {
                        //   setState(() {
                        //     devices.add(r.device);
                        //   });
                        // }
                        if (r.device.advName.startsWith("ADORE1")) {
                          setState(() {
                            if (!devices.contains(r.device)) {
                              devices.add(r.device);
                            }
                          });
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
                // ignore: deprecated_member_use
                title: Text(devices[i].advName),
                subtitle: Text(devices[i].remoteId.toString()),
                trailing: ElevatedButton(
                    onPressed: () {
                      connectToDevice(devices[i]);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Devicepage(
                          devicename: devices[i].advName,
                          device: devices[i],
                        );
                      }));
                    },
                    child: const Text(
                      "Connect",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    )),
              );
            }));
  }
}

class Devicepage extends StatefulWidget {
  final String devicename;
  final BluetoothDevice device;
  const Devicepage({super.key, required this.devicename, required this.device});

  @override
  State<Devicepage> createState() => _DevicepageState();
}

class _DevicepageState extends State<Devicepage> {
  late StreamSubscription<BluetoothConnectionState> _connectionstate;
  BluetoothConnectionState CurrentConnectionState =
      BluetoothConnectionState.disconnected;
  List<int> values = [];
  double myweight = 0.0;

  ReadWeight(BluetoothDevice device) async {
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
        // ignore: deprecated_member_use
        c.value.listen((value) {
          setState(() {
            values = value;
            calculateWeightNew(values);
            myweight = calculateWeightNew(values);
            print("\n\n\n\n\n my weight =>$myweight\n\n\n");

            // byteArrayToString(values);
            // result = byteArrayToString(values);
            // hexStringToByteArray(result);
            // sys = hexStringToByteArray(result) as int;
            // byteToInt(sys);
            // pul = byteToInt(sys);

            // calculatePresureBlood(values);
            // result = calculatePresureBlood(values);
            print("\n\n\n\n\n\n valuesss ======>$values\n\n\n\n\n\n");
            // [66, 51, 32, 66, 84]
            // [49, 46, 48, 46, 50, 50]
            // [49, 48, 58, 50, 52, 58, 51, 49, 32, 65, 117, 103, 32, 49, 48, 32, 50, 48, 49, 55]
            // [76, 73, 84, 69, 79, 78]
            // [87, 66, 49, 48, 48, 78]
          });
        });
      }
    }
  }

  double get myupdateweight {
    return myweight;
  }

  double calculateWeightNew(List<int> data) {
    print("data2 =>${data[2]}");
    print("data3 =>${data[3]}");
    print("data4 =>${data[4]}");
    print("data5 =>${data[5]}");
    int temp = data[4];
    data[4] = data[5];
    data[5] = temp;
    String weightHex =
        '${data[4].toRadixString(16).padLeft(2, '0')}${data[5].toRadixString(16).padLeft(2, '0')}';
    int weightDecimal = int.parse(weightHex, radix: 16);
    double weight = weightDecimal / 100.0;
    return weight;
  }

  // String calculatePresureBlood(List<int> data) {
  //   if (data.length >= 4 && data[0] == 77 && data[1] == 58) {
  //     int expectedLength = (data[2] * 256 + data[3] + 4);

  //     if (data.length >= expectedLength) {
  //       int checksum = data.reduce((a, b) => a + b) % 256;

  //       if (checksum == data.last) {
  //         List<int> presureBlood = data.sublist(4, expectedLength - 1);

  //         if (presureBlood.length >= 6) {
  //           // Assuming systolic, diastolic, and pulse are each represented by 2 bytes
  //           sys = (presureBlood[0] << 8) + presureBlood[1];
  //           dia = (presureBlood[2] << 8) + presureBlood[3];
  //           pul = (presureBlood[4] << 8) + presureBlood[5];
  //         }
  //       }
  //     }
  //   }
  //   return "sys: $sys dia: $dia pul: $pul";
  // }

  // String byteArrayToString(List<int> data) {
  //   if (data != null && data.isNotEmpty) {
  //     final stringBuffer = StringBuffer();
  //     data.forEach((byteChar) {
  //       stringBuffer.write('${byteChar.toRadixString(16).padLeft(2, '0')} ');
  //     });
  //     return stringBuffer.toString().trim(); // Trim removes extra whitespace
  //   }
  //   return ''; // Return an empty string if data is null or empty
  // }

  // Uint8List hexStringToByteArray(String s) {
  //   int len = s.length;
  //   Uint8List data = Uint8List(len ~/ 2);

  //   for (int i = 0; i < len; i += 2) {
  //     data[i ~/ 2] = int.parse(s.substring(i, i + 2), radix: 16);
  //   }

  //   return data;
  // }

  // int byteToInt(int data) {
  //   return int.parse(data.toRadixString(16), radix: 16);
  // }

  @override
  void initState() {
    _connectionstate = widget.device.connectionState.listen((state) {
      setState(() {
        CurrentConnectionState = state;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: ListTile(
              title: Text(
                widget.devicename,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                CurrentConnectionState.toString().substring(25),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Weight:   $myweight",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 250,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 15.0,
                    shadowColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  ReadWeight(widget.device);
                  Provider.of<WeightHistoryController>(context)
                      .save(myupdateweight);
                },
                child: Text(
                  "step on the scale".toUpperCase(),
                  style: const TextStyle(
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 10)
                      ],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 15.0,
                    shadowColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const WeightHistory();
                  }));
                },
                child: const Text(
                  "History",
                  style: TextStyle(
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 10)
                      ],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ))
          ],
        ),
      ),
    );
  }
}

class WeightHistory extends StatefulWidget {
  const WeightHistory({super.key});

  @override
  State<WeightHistory> createState() => _WeightHistoryState();
}

class _WeightHistoryState extends State<WeightHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Consumer<WeightHistoryController>(
        builder: (context, weightcontroller, child) {
          return ListView.separated(
              itemBuilder: (context, i) {
                return ListTile(
                  title: const Text(""),
                  subtitle: Row(
                    children: [
                      const Text("weight: "),
                      Text(weightcontroller.updatehistory[i].toString())
                    ],
                  ),
                );
              },
              separatorBuilder: (context, i) {
                return const SizedBox(
                  height: 50,
                );
              },
              itemCount: weightcontroller.updatehistory.length);
        },
      ),
    );
  }
}
