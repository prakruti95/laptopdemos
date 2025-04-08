import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'api_service.dart';

class ConnectivityHelper {
  static Future<bool> isOnline() async {
    return await InternetConnectionChecker().hasConnection;
  }

  static void monitorConnectivity() {
    InternetConnectionChecker().onStatusChange.listen((status) async {
      if (status == InternetConnectionStatus.connected) {
        await APIService.syncOfflineData();
      }
    });
  }
}
