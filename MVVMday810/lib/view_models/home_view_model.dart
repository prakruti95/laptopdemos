// lib/view_models/home_view_model.dart
import 'dart:async';
import '../models/api_service.dart';
import '../models/connectivity_helper.dart';
import '../models/dbhelper.dart';

class HomeViewModel {
  final StreamController<List<Map<String, dynamic>>> _usersController =
  StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get usersStream => _usersController.stream;

  // Method to load data (from API or local DB)
  Future<void> loadData() async {
    bool online = await ConnectivityHelper.isOnline();

    if (online) {
      await APIService.syncOfflineData();
      final data = await APIService.fetchData();
      for (var user in data) {
        await DBHelper.insertUser({
          'id': user['id'],
          'name': user['name'],
          'surname': user['surname'],
          'email': user['email'],
          'password': user['password'],
          'isSynced': 1,
        });
      }
    }

    final localData = await DBHelper.fetchUsers();
    _usersController.sink.add(localData); // Updating UI with the users data
  }

  // Method to add new user
  Future<void> addUser(Map<String, dynamic> user) async {
    await DBHelper.insertUser(user);
    loadData(); // Reload data after adding a user
  }

  // Dispose method to close the stream controller
  void dispose() {
    _usersController.close();
  }
}
