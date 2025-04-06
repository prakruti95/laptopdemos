import 'package:flutter/material.dart';
import 'package:location/location.dart';


class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String location = "Fetching location...";
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    Location locationService = Location();

    bool serviceEnabled = await locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationService.requestService();
      if (!serviceEnabled) {
        setState(() {
          location = "Location services are disabled.";
        });
        return;
      }
    }

    PermissionStatus permissionGranted = await locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          location = "Location permission denied.";
        });
        return;
      }
    }

    _locationData = await locationService.getLocation();
    setState(() {
      location = "Latitude: ${_locationData?.latitude},\nLongitude: ${_locationData?.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Location"),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          location,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
