import 'package:flutter/material.dart';



class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web MouseRegion Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HoverEffectPage(),
    );
  }
}

class HoverEffectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Web Hover Effect"),
      ),
      body: Center(
        child: MouseRegion(
          onEnter: (_) => print('Mouse Entered'),
          onExit: (_) => print('Mouse Exited'),
          child: Container(
            color: Colors.blue,
            width: 200,
            height: 100,
            child: Center(child: Text('Hover me!')),
          ),
        ),
      ),
    );
  }
}
