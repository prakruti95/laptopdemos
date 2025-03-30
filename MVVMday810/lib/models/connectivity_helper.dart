import 'package:connectivity_plus/connectivity_plus.dart';

import 'api_service.dart';

class ConnectivityHelper {
  static Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<void> monitorConnectivity() async {
    Connectivity().onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        await APIService.syncOfflineData();
      }
    });
  }
}