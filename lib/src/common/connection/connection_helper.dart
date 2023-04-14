import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionHelper {
  static Future<bool> isConnected() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult != ConnectivityResult.none);
  }
}
