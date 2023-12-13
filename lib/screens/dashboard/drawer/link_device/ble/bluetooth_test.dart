// import 'dart:developer';
// import 'dart:math' as matpac;

// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// class BluetoothFnTest extends StatefulWidget {
//   const BluetoothFnTest({Key? key}) : super(key: key);

//   @override
//   State<BluetoothFnTest> createState() => _BluetoothFnTestState();
// }

// class _BluetoothFnTestState extends State<BluetoothFnTest> {
//   @override
//   void initState() {
//     super.initState();
//     /*  FlutterBluePlus blue = FlutterBluePlus.instance;
//     var scanDevices = blue
//         .scan(
//       scanMode: ScanMode.balanced,
//     )
//         .listen((event) {
//       log("Scanning => Result : $event");
//     }); */
//   }

//   void testingBluetoothFn() async {
//     FlutterBluePlus blue = FlutterBluePlus.instance;

//     blue.startScan(timeout: const Duration(seconds: 8));
//     var subscription = blue.scanResults.listen((results) {
//       log("Scanning on going! => Device count ${results.length}");
//       for (ScanResult r in results) {
//         log('${r.device.name} found! rssi: ${r.rssi}');
//       }
//     });

//     blue.stopScan();
//     // blue.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<BluetoothState>(
//         stream: FlutterBluePlus.instance.state,
//         builder: (context, snapshot) {
//           log(snapshot.toString());
//           return Scaffold(
//               appBar: AppBar(
//                 title: const Text("Bluetooth"),
//                 actions: const [],
//               ),
//               body: (snapshot.data == BluetoothState.on)
//                   ? const TestBody()
//                   : Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           const Icon(
//                             Icons.bluetooth_disabled,
//                             size: 200.0,
//                             color: Colors.black,
//                           ),
//                           Text(
//                             'Bluetooth Adapter is ${(snapshot.data != null) ? snapshot.data!.name.toString() : "Loading..."}.',
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context)
//                                 .primaryTextTheme
//                                 .headline4!
//                                 .copyWith(color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ) /* : const SizedBox(), */
//               );
//         });
//   }
// }

// // class TestBody extends StatefulWidget {
// //   const TestBody({Key? key}) : super(key: key);

// //   @override
// //   State<TestBody> createState() => _TestBodyState();
// // }

// // class _TestBodyState extends State<TestBody> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Find Devices'),
// //       ),
// //       body: RefreshIndicator(
// //         onRefresh: () =>
// //             FlutterBluePlus.startScan(timeout: Duration(seconds: 4)),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: <Widget>[
// //               StreamBuilder<List<BluetoothDevice>>(
// //                 stream: Stream.periodic(Duration(seconds: 2))
// //                     .asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
// //                 initialData: [],
// //                 builder: (c, snapshot) => Column(
// //                   children: snapshot.data!
// //                       .map((d) => ListTile(
// //                             title: Text(d.name),
// //                             subtitle: Text(d.id.toString()),
// //                             trailing: StreamBuilder<BluetoothDeviceState>(
// //                               stream: d.state,
// //                               initialData: BluetoothDeviceState.disconnected,
// //                               builder: (c, snapshot) {
// //                                 if (snapshot.data ==
// //                                     BluetoothDeviceState.connected) {
// //                                   return ElevatedButton(
// //                                     child: const Text('OPEN'),
// //                                     onPressed: () {
// //                                       /* Navigator.of(context).push(
// //                                         MaterialPageRoute(
// //                                             builder: (context) =>
// //                                                 DeviceScreen(device: d))), */
// //                                     },
// //                                   );
// //                                 }
// //                                 return Text(snapshot.data.toString());
// //                               },
// //                             ),
// //                           ))
// //                       .toList(),
// //                 ),
// //               ),
// //               StreamBuilder<List<ScanResult>>(
// //                 stream: FlutterBluePlus.instance.scanResults,
// //                 initialData: [],
// //                 builder: (c, snapshot) => Column(
// //                   children: snapshot.data!
// //                       .map(
// //                         (r) => Text(r.toString()),
// //                       )
// //                       .toList(),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       floatingActionButton: StreamBuilder<bool>(
// //         stream: FlutterBluePlus.instance.isScanning,
// //         initialData: false,
// //         builder: (c, snapshot) {
// //           if (snapshot.hasData) {
// //             return FloatingActionButton(
// //               child: Icon(Icons.stop),
// //               onPressed: () => FlutterBluePlus.instance.stopScan(),
// //               backgroundColor: Colors.red,
// //             );
// //           } else {
// //             return FloatingActionButton(
// //                 child: Icon(Icons.search),
// //                 onPressed: () => FlutterBluePlus.instance
// //                     .startScan(timeout: Duration(seconds: 4)));
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }

// class DeviceScreen extends StatelessWidget {
//   const DeviceScreen({Key? key, required this.device}) : super(key: key);

//   final BluetoothDevice device;

//   List<int> _getRandomBytes() {
//     final math = matpac.Random();
//     return [
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255)
//     ];
//   }

//   List<Widget> _buildServiceTiles(List<BluetoothService> services) {
//     return services
//         .map<Widget>(
//           (s) => Text(s.toString()),
//         )
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(device.name),
//         actions: <Widget>[
//           StreamBuilder<BluetoothDeviceState>(
//             stream: device.state,
//             initialData: BluetoothDeviceState.connecting,
//             builder: (c, snapshot) {
//               VoidCallback onPressed;
//               String text;
//               switch (snapshot.data) {
//                 case BluetoothDeviceState.connected:
//                   onPressed = () => device.disconnect();
//                   text = 'DISCONNECT';
//                   break;
//                 case BluetoothDeviceState.disconnected:
//                   onPressed = () => device.connect();
//                   text = 'CONNECT';
//                   break;
//                 default:
//                   onPressed = () {};
//                   text = snapshot.data.toString().substring(21).toUpperCase();
//                   break;
//               }
//               return TextButton(
//                   onPressed: onPressed,
//                   child: Text(
//                     text,
//                     style: Theme.of(context)
//                         .primaryTextTheme
//                         .bodyMedium!
//                         .copyWith(color: Colors.white),
//                   ));
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             StreamBuilder<BluetoothDeviceState>(
//               stream: device.state,
//               initialData: BluetoothDeviceState.connecting,
//               builder: (c, snapshot) => ListTile(
//                 leading: (snapshot.data == BluetoothDeviceState.connected)
//                     ? Icon(Icons.bluetooth_connected)
//                     : Icon(Icons.bluetooth_disabled),
//                 title: Text(
//                     'Device is ${snapshot.data.toString().split('.')[1]}.'),
//                 subtitle: Text('${device.id}'),
//                 trailing: StreamBuilder<bool>(
//                   stream: device.isDiscoveringServices,
//                   initialData: false,
//                   builder: (c, snapshot) => IndexedStack(
//                     index: snapshot.data ?? false ? 1 : 0,
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(Icons.refresh),
//                         onPressed: () => device.discoverServices(),
//                       ),
//                       IconButton(
//                         icon: SizedBox(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Colors.grey),
//                           ),
//                           width: 18.0,
//                           height: 18.0,
//                         ),
//                         onPressed: null,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             StreamBuilder<int>(
//               stream: device.mtu,
//               initialData: 0,
//               builder: (c, snapshot) => ListTile(
//                 title: Text('MTU Size'),
//                 subtitle: Text('${snapshot.data} bytes'),
//                 trailing: IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () => device.requestMtu(223),
//                 ),
//               ),
//             ),
//             StreamBuilder<List<BluetoothService>>(
//               stream: device.services,
//               initialData: [],
//               builder: (c, snapshot) {
//                 return Column(
//                   children: _buildServiceTiles(snapshot.data ?? []),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
