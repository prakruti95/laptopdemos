import 'package:flutter/material.dart';


class MyApp14 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAB with BottomAppBar',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Pages to switch between
  final List<Widget> _pages = [
    Center(child: Text('Calendar Screen', style: TextStyle(fontSize: 22))),
    Center(child: Text('Messages Screen', style: TextStyle(fontSize: 22))),
    Center(child: Text('Home (FAB) Screen', style: TextStyle(fontSize: 22))),
    Center(child: Text('Notifications Screen', style: TextStyle(fontSize: 22))),
    Center(child: Text('Profile Screen', style: TextStyle(fontSize: 22))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFabPressed() {
    setState(() {
      _selectedIndex = 2; // FAB opens the "Home" screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomAppBar Navigation'),
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.purple,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Left side icons
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.calendar_today,
                        color: _selectedIndex == 0 ? Colors.white : Colors.white60),
                    onPressed: () => _onItemTapped(0),
                  ),
                  IconButton(
                    icon: Icon(Icons.message,
                        color: _selectedIndex == 1 ? Colors.white : Colors.white60),
                    onPressed: () => _onItemTapped(1),
                  ),
                ],
              ),
              // Right side icons
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications,
                        color: _selectedIndex == 3 ? Colors.white : Colors.white60),
                    onPressed: () => _onItemTapped(3),
                  ),
                  IconButton(
                    icon: Icon(Icons.person,
                        color: _selectedIndex == 4 ? Colors.white : Colors.white60),
                    onPressed: () => _onItemTapped(4),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
