import 'app_logger.dart';

/// Example usage of AppLogger
class LoggerExample {
  static void demonstrateLogger() {
    // 1. Log API Request
    AppLogger.logRequest(
      method: 'POST',
      url: 'https://api.example.com/v1/users/login',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer token123',
      },
      queryParams: {
        'page': '1',
        'limit': '10',
      },
      body: {
        'email': 'user@example.com',
        'password': '********',
      },
    );

    // 2. Log API Response (Success)
    AppLogger.logResponse(
      statusCode: 200,
      url: 'https://api.example.com/v1/users/login',
      duration: const Duration(milliseconds: 245),
      data: {
        'success': true,
        'message': 'Login successful',
        'data': {
          'user': {
            'id': 1,
            'name': 'John Doe',
            'email': 'user@example.com',
          },
          'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
        },
      },
    );

    // 3. Log API Response (Error)
    AppLogger.logResponse(
      statusCode: 404,
      url: 'https://api.example.com/v1/users/999',
      duration: const Duration(milliseconds: 120),
      data: {
        'success': false,
        'message': 'User not found',
        'error': 'RESOURCE_NOT_FOUND',
      },
    );

    // 4. Log JSON Data
    AppLogger.logJson(
      {
        'movies': [
          {'id': 1, 'title': 'Inception', 'rating': 8.8},
          {'id': 2, 'title': 'The Matrix', 'rating': 8.7},
        ],
      },
      title: 'Movie List',
    );

    // 5. Log Success
    AppLogger.success(
      'User profile updated successfully',
      data: {'userId': 123, 'updatedFields': ['name', 'email']},
    );

    // 6. Log Error
    AppLogger.error(
      'Failed to fetch data from server',
      error: 'Connection timeout',
      stackTrace: StackTrace.current,
    );

    // 7. Log Warning
    AppLogger.warning(
      'API rate limit approaching',
      data: {'remaining': 10, 'limit': 100, 'resetTime': '2026-01-13 15:30:00'},
    );

    // 8. Log Info
    AppLogger.info(
      'App initialized successfully',
      data: {'version': '1.0.0', 'environment': 'development'},
    );

    // 9. Log Debug
    AppLogger.debug(
      'Processing user authentication',
      data: {'step': 'validating_token', 'userId': 456},
    );

    // 10. Different Separator Styles
    AppLogger.separator(style: 'double');
    AppLogger.separator(style: 'single');
    AppLogger.separator(style: 'thick');
    AppLogger.separator(style: 'dotted');
    AppLogger.separator(style: 'stars');

    // 11. Custom Box
    AppLogger.customBox(
      title: 'CUSTOM MESSAGE',
      content: 'This is a custom box with your own title and content!\nYou can add multiple lines here.',
      emoji: '🎨',
      color: 'magenta',
    );

    // 12. Another Custom Box Example
    AppLogger.customBox(
      title: 'PAYMENT SUCCESSFUL',
      content: 'Transaction ID: TXN123456789\nAmount: \$99.99\nStatus: Completed',
      emoji: '💳',
      color: 'green',
    );
  }
}
