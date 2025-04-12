import 'package:flutter/material.dart';



class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Layout Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsivePage(),
    );
  }
}

class ResponsivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use the `LayoutBuilder` widget to make a responsive design
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Web Page'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Show two columns for wider screens (e.g., Web/Desktop)
            return Row(
              children: [
                Expanded(child: Container(color: Colors.blue, height: 300)),
                Expanded(child: Container(color: Colors.green, height: 300)),
              ],
            );
          } else {
            // Single column for mobile or smaller screens
            return Column(
              children: [
                Container(color: Colors.blue, height: 300),
                Container(color: Colors.green, height: 300),
              ],
            );
          }
        },
      ),
    );
  }
}
