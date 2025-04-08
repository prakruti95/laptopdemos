import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dbhelper.dart';

class APIService {
  static final dbHelper = DBHelper();

  static const String insertUrl = "https://prakrutitech.buzz/AndroidAPI/addcategory.php";

  static Future<void> syncOfflineData() async {
    final unsynced = await dbHelper.getUnsyncedData();
    for (var item in unsynced) {
      final request = http.MultipartRequest('POST', Uri.parse(insertUrl));
      request.fields['name'] = item['name'];
      request.files.add(await http.MultipartFile.fromPath('url', item['imagePath']));

      final res = await request.send();
      if (res.statusCode == 200) {
        await dbHelper.markAsSynced(item['id']);
      }
    }
  }
}
