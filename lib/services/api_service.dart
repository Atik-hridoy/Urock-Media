// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../core/utils/logger.dart';

// /// Generic API service for REST/GraphQL calls
// class ApiService {
//   static const String baseUrl = 'https://api.themoviedb.org/3';
//   static const String apiKey = 'YOUR_API_KEY_HERE'; // Replace with actual key

//   /// GET request
//   Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? params}) async {
//     try {
//       final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
//       Logger.network('GET', uri.toString());

//       final response = await http.get(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//       );

//       return _handleResponse(response);
//     } catch (e, stackTrace) {
//       Logger.error('GET request failed', e, stackTrace);
//       rethrow;
//     }
//   }

//   /// POST request
//   Future<Map<String, dynamic>> post(
//     String endpoint, {
//     Map<String, dynamic>? body,
//     Map<String, String>? params,
//   }) async {
//     try {
//       final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
//       Logger.network('POST', uri.toString(), body);

//       final response = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: body != null ? jsonEncode(body) : null,
//       );

//       return _handleResponse(response);
//     } catch (e, stackTrace) {
//       Logger.error('POST request failed', e, stackTrace);
//       rethrow;
//     }
//   }

//   /// PUT request
//   Future<Map<String, dynamic>> put(
//     String endpoint, {
//     Map<String, dynamic>? body,
//     Map<String, String>? params,
//   }) async {
//     try {
//       final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
//       Logger.network('PUT', uri.toString(), body);

//       final response = await http.put(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: body != null ? jsonEncode(body) : null,
//       );

//       return _handleResponse(response);
//     } catch (e, stackTrace) {
//       Logger.error('PUT request failed', e, stackTrace);
//       rethrow;
//     }
//   }

//   /// DELETE request
//   Future<Map<String, dynamic>> delete(String endpoint, {Map<String, String>? params}) async {
//     try {
//       final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
//       Logger.network('DELETE', uri.toString());

//       final response = await http.delete(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//       );

//       return _handleResponse(response);
//     } catch (e, stackTrace) {
//       Logger.error('DELETE request failed', e, stackTrace);
//       rethrow;
//     }
//   }

//   /// Handle HTTP response
//   Map<String, dynamic> _handleResponse(http.Response response) {
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       return jsonDecode(response.body) as Map<String, dynamic>;
//     } else {
//       throw ApiException(
//         statusCode: response.statusCode,
//         message: 'Request failed with status: ${response.statusCode}',
//       );
//     }
//   }
// }

// /// Custom API exception
// class ApiException implements Exception {
//   final int statusCode;
//   final String message;

//   ApiException({
//     required this.statusCode,
//     required this.message,
//   });

//   @override
//   String toString() => 'ApiException: $message (Status: $statusCode)';
// }
