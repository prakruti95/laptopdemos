import 'package:flutter/material.dart';


class ThirdScreen extends StatefulWidget {
  final String a;

  ThirdScreen({required this.a});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  int selectedIndex = 0;

  // List of separate screen widgets
  final List<Widget> screens = [
    HomeScreen(),
    AboutScreen(),
    ContactScreen(),
    SettingsScreen(),
  ];

  final List<String> drawerTitles = [
    "Home",
    "About",
    "Contact",
    "Settings",
  ];

  void _onSelectDrawerItem(int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.a}"),
        backgroundColor: Colors.purple,
      ),
      body: screens[selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Tops Technologies"),
              accountEmail: Text("tops@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  widget.a[0].toUpperCase(),
                  style: TextStyle(fontSize: 40.0, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.purple),
            ),
            for (int i = 0; i < drawerTitles.length; i++)
              ListTile(
                leading: Icon(Icons.circle),
                title: Text(drawerTitles[i]),
                selected: selectedIndex == i,
                selectedTileColor: Colors.purple.shade100,
                onTap: () => _onSelectDrawerItem(i),
              ),
          ],
        ),
      ),
    );
  }
}

// ------------------------ Separate Screens ------------------------

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(Icons.home, size: 100, color: Colors.purple),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(Icons.info, size: 100, color: Colors.green),
    );
  }
}

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(Icons.contact_mail, size: 100, color: Colors.blue),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(Icons.settings, size: 100, color: Colors.orange),
    );
  }
}
