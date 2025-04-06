import 'package:day5/bottomnavi2.dart';
import 'package:day5/bottomnavigation.dart';
import 'package:day5/homepage3.dart';
import 'package:day5/homepage4.dart';
import 'package:day5/networkconnectioncheck.dart';
import 'package:day5/permission.dart';
import 'package:flutter/material.dart';

import 'audio.dart';
import 'homepage.dart';
import 'homepage2.dart';
import 'location.dart';
import 'navigationdrawer.dart';
import 'networkconnectioncheck2.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MaterialApp(
    home: CameraPermissionExample(),
    debugShowCheckedModeBanner: false,
  ));
}


List<CameraDescription> cameras = [];


class CameraPermissionExample extends StatefulWidget {
  @override
  _CameraPermissionExampleState createState() => _CameraPermissionExampleState();
}

class _CameraPermissionExampleState extends State<CameraPermissionExample> {
  CameraController? controller;
  String status = "Checking camera permission...";

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    var permission = await Permission.camera.status;

    if (permission.isDenied || permission.isRestricted || permission.isPermanentlyDenied) {
      permission = await Permission.camera.request();
    }

    if (permission.isGranted) {
      if (cameras.isNotEmpty) {
        controller = CameraController(cameras[0], ResolutionPreset.medium);
        await controller!.initialize();
        setState(() {
          status = "Camera ready ✅";
        });
      } else {
        setState(() {
          status = "No camera found!";
        });
      }
    } else {
      setState(() {
        status = "Camera permission denied.";
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera Permission"), backgroundColor: Colors.deepPurple),
      body: Center(
        child: controller != null && controller!.value.isInitialized
            ? CameraPreview(controller!)
            : Text(
          status,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}



// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: LocationScreen(),
//     );
//   }
// }