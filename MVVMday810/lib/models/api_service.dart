// lib/models/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dbhelper.dart';

class APIService {
  static const String apiUrl = 'https://prakrutitech.buzz/Fluttertestapi/view.php';

  static Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> syncOfflineData() async {
    final db = await DBHelper.initializeDB();
    final offlineUsers = await db.query('users', where: 'isSynced = 0');

    for (var user in offlineUsers) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'id': user['id'].toString(),
            'name': user['name'],
            'surname': user['surname'],
            'email': user['email'],
            'password': user['password'],
          },
        );

        if (response.statusCode == 200) {
          await DBHelper.updateUser({'id': user['id'], 'isSynced': 1});
        }
      } catch (e) {
        print("Sync error: $e");
      }
    }
  }
}
