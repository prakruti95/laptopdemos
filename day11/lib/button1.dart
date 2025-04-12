import 'package:flutter/material.dart';


class MyApp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InteractiveButton(),
    );
  }
}

class InteractiveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hover over the button!'),
      ),
      body: Center(
        child: MouseRegion(
          onEnter: (_) {
            print('Mouse Hovering!');
          },
          onExit: (_) {
            print('Mouse Left!');
          },
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Hover Me!'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
