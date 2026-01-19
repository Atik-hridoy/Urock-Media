import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../utils/app_logger.dart';
import 'storage_service.dart';

/// API Service
/// Handles all HTTP requests using Dio
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  Dio? _dio;

  /// Initialize API service
  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: Duration(milliseconds: ApiConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: ApiConfig.receiveTimeout),
        sendTimeout: Duration(milliseconds: ApiConfig.sendTimeout),
        headers: ApiConfig.defaultHeaders,
      ),
    );

    // Add interceptors
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add token to headers if available
          final token = StorageService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // Log request
          AppLogger.logRequest(
            method: options.method,
            url: options.uri.toString(),
            headers: options.headers,
            body: options.data,
            queryParams: options.queryParameters,
          );

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Log response
          AppLogger.logResponse(
            statusCode: response.statusCode ?? 0,
            url: response.requestOptions.uri.toString(),
            data: response.data,
            headers: response.headers.map,
          );

          return handler.next(response);
        },
        onError: (error, handler) {
          // Log error
          AppLogger.error(
            'API Error: ${error.message}',
            error: error.response?.data ?? error.message,
            stackTrace: error.stackTrace,
          );

          return handler.next(error);
        },
      ),
    );
  }

  /// Get Dio instance
  Dio get dio {
    if (_dio == null) {
      init(); // Auto-initialize if not initialized
    }
    return _dio!;
  }

  /// GET request
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options:
            options ??
            Options(
              headers: {"Authorization": "Bearer ${StorageService.getToken()}"},
            ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// POST request
  Future<Response> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options:
            options ??
            Options(
              headers: {"Authorization": "Bearer ${StorageService.getToken()}"},
            ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PUT request
  Future<Response> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request
  Future<Response> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PATCH request
  Future<Response> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
