import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyApp12 extends StatelessWidget {
  const MyApp12({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key}); // Marked as const

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // List of screens for each page
  static const List<Widget> _pages = <Widget>[
    HomePage(),   // Home page screen
    SearchPage(), // Search page screen
    ProfilePage(), // Profile page screen
  ];

  // Method to handle the tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bottom Navigation Example"),
      ),
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex, // Highlight the selected tab
        selectedItemColor: Colors.black, // Color for selected item
        iconSize: 40, // Icon size
        onTap: _onItemTapped, // Handle tab click
        elevation: 5, // Bottom navigation bar shadow
      ),
    );
  }
}

// HomePage Screen
class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Marked as const

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// SearchPage Screen
class SearchPage extends StatelessWidget {
  const SearchPage({super.key}); // Marked as const

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ProfilePage Screen
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key}); // Marked as const

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }
}
