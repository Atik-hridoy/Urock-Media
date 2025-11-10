// import 'package:connectivity_plus/connectivity_plus.dart';
// import '../core/utils/logger.dart';

// /// Network connectivity checker utility
// class NetworkChecker {
//   final Connectivity _connectivity = Connectivity();

//   /// Check if device has internet connection
//   Future<bool> hasConnection() async {
//     try {
//       final result = await _connectivity.checkConnectivity();
//       final isConnected = result != ConnectivityResult.none;
      
//       Logger.info('Network connection: ${isConnected ? 'Available' : 'Unavailable'}');
//       return isConnected;
//     } catch (e, stackTrace) {
//       Logger.error('Failed to check network connection', e, stackTrace);
//       return false;
//     }
//   }

//   /// Listen to connectivity changes
//   Stream<ConnectivityResult> get onConnectivityChanged {
//     return _connectivity.onConnectivityChanged;
//   }

//   /// Get current connectivity type
//   Future<ConnectivityResult> getConnectivityType() async {
//     try {
//       return await _connectivity.checkConnectivity();
//     } catch (e, stackTrace) {
//       Logger.error('Failed to get connectivity type', e, stackTrace);
//       return ConnectivityResult.none;
//     }
//   }

//   /// Check if connected to WiFi
//   Future<bool> isWiFi() async {
//     final result = await getConnectivityType();
//     return result == ConnectivityResult.wifi;
//   }

//   /// Check if connected to mobile data
//   Future<bool> isMobile() async {
//     final result = await getConnectivityType();
//     return result == ConnectivityResult.mobile;
//   }
// }
