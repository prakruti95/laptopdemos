// import 'dart:async';
// import 'package:flutter/material.dart';
// //import 'package:connectivity_plus/connectivity_plus.dart';
//
//
// class MyApp2 extends StatelessWidget {
//   const MyApp2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Connectivity Check',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ConnectionCheck(),
//     );
//   }
// }
//
// class ConnectionCheck extends StatefulWidget {
//   const ConnectionCheck({super.key});
//
//   @override
//   _ConnectionCheckState createState() => _ConnectionCheckState();
// }
//
// class _ConnectionCheckState extends State<ConnectionCheck> {
//   late ConnectivityResult _connectionStatus;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//     _checkConnectivity(); // Check initial connection status
//   }
//
//   // Function to check current connection status
//   Future<void> _checkConnectivity() async {
//     var connectivityResult = await _connectivity.checkConnectivity();
//     _updateConnectionStatus(connectivityResult);
//   }
//
//   // Update the connection status in the UI
//   void _updateConnectionStatus(ConnectivityResult result) {
//     setState(() {
//       _connectionStatus = result;
//     });
//   }
//
//   // Dispose the subscription to avoid memory leaks
//   @override
//   void dispose() {
//     super.dispose();
//     _connectivitySubscription.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Check Internet Connection')),
//       body: Center(
//         child: _connectionStatus == ConnectivityResult.none
//             ? const NoConnectionWidget() // Display message when no connection
//             : const ConnectedWidget(), // Display message when connected
//       ),
//     );
//   }
// }
//
// // Widget for when the device is connected to the internet
// class ConnectedWidget extends StatelessWidget {
//   const ConnectedWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: const [
//         Icon(Icons.wifi, color: Colors.green, size: 50),
//         SizedBox(height: 20),
//         Text(
//           'You are connected to the internet',
//           style: TextStyle(fontSize: 18, color: Colors.green),
//         ),
//       ],
//     );
//   }
// }
//
// // Widget for when there is no internet connection
// class NoConnectionWidget extends StatelessWidget {
//   const NoConnectionWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         const Icon(Icons.error, color: Colors.red, size: 50),
//         const SizedBox(height: 20),
//         const Text(
//           'No internet connection',
//           style: TextStyle(fontSize: 18, color: Colors.red),
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             // Retry the connection check
//             (context as Element).reassemble();
//           },
//           child: const Text('Retry'),
//         ),
//       ],
//     );
//   }
// }
