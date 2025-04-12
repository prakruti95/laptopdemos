import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'dart:io'; // For Platform (Mobile-specific)

class MyApp7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Layout',
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
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Web Platform"),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.blue,
                width: 200,
                height: 200,
                child: Center(child: Text('Web Layout')),
              ),
              SizedBox(width: 20),
              Container(
                color: Colors.green,
                width: 200,
                height: 200,
                child: Center(child: Text('Web Layout')),
              ),
            ],
          ),
        ),
      );
    }

    // Mobile Layout (Single Column)
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Platform"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.blue,
              width: 200,
              height: 200,
              child: Center(child: Text('Mobile Layout')),
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.green,
              width: 200,
              height: 200,
              child: Center(child: Text('Mobile Layout')),
            ),
          ],
        ),
      ),
    );
  }
}
