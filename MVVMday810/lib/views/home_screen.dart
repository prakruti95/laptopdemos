// lib/views/home_screen.dart
import 'package:flutter/material.dart';
import '../view_models/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.loadData(); // Load initial data
  }

  @override
  void dispose() {
    _viewModel.dispose(); // Clean up the view model when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Offline Sync App')),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _viewModel.usersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users available.'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index]['name']),
                subtitle: Text(users[index]['email']),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _viewModel.addUser({
            'id': DateTime.now().millisecondsSinceEpoch,
            'name': 'New User',
            'surname': 'Surname',
            'email': 'newuser@example.com',
            'password': 'password123',
            'isSynced': 0,
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
