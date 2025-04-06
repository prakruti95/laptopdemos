import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Connectivity Check',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NetworkCheck(),
    );
  }
}

class NetworkCheck extends StatefulWidget {
  const NetworkCheck({super.key});

  @override
  _NetworkCheckState createState() => _NetworkCheckState();
}

class _NetworkCheckState extends State<NetworkCheck> {
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkNetworkConnectivity(); // Check network connection on app startup
  }

  // Function to check network connectivity
  Future<void> _checkNetworkConnectivity() async {
    try {
      // Make a request to a reliable server (e.g., Google's DNS or any API)
      final response = await http.get(Uri.parse('https://www.google.com/'));

      if (response.statusCode == 200) {
        // If the server responds with status code 200, we have an internet connection
        setState(() {
          _isConnected = true;
        });
      } else {
        setState(() {
          _isConnected = false;
        });
      }
    } catch (e) {
      // If there is an error (e.g., no connection), handle it here
      setState(() {
        _isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network Connectivity Check')),
      body: Center(
        child: _isConnected
            ? const ConnectedWidget() // Connected screen
            : const NoConnectionWidget(), // No internet connection screen
      ),
    );
  }
}

// Widget for when the device is connected to the internet
class ConnectedWidget extends StatelessWidget {
  const ConnectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(Icons.wifi, color: Colors.green, size: 50),
        SizedBox(height: 20),
        Text(
          'You are connected to the internet',
          style: TextStyle(fontSize: 18, color: Colors.green),
        ),
      ],
    );
  }
}

// Widget for when there is no internet connection
class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.error, color: Colors.red, size: 50),
        const SizedBox(height: 20),
        const Text(
          'No internet connection',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Retry the network check
            (context as Element).reassemble();
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
