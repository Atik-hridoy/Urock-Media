import 'dart:convert';
import 'dart:developer' as developer;

/// Beautiful console logger with colorful output
class AppLogger {
  static const bool _isDebugMode = true;

  // ANSI Color Codes
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';
  static const String _white = '\x1B[37m';
  static const String _bold = '\x1B[1m';
  static const String _dim = '\x1B[2m';

  // Emojis for better visual representation
  static const String _successEmoji = '✅';
  static const String _errorEmoji = '❌';
  static const String _warningEmoji = '⚠️';
  static const String _infoEmoji = 'ℹ️';
  static const String _debugEmoji = '🐛';
  static const String _requestEmoji = '📤';
  static const String _responseEmoji = '📥';
  static const String _jsonEmoji = '📋';

  /// Log API Request with beautiful formatting
  static void logRequest({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
    Map<String, dynamic>? queryParams,
  }) {
    if (!_isDebugMode) return;

    final buffer = StringBuffer();
    buffer.writeln('$_cyan$_bold');
    buffer.writeln('╔═══════════════════════════════════════════════════════════════╗');
    buffer.writeln('║ $_requestEmoji  API REQUEST                                              ');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════╣');
    buffer.writeln('║ Method: $_white$_bold$method$_reset$_cyan');
    buffer.writeln('║ URL: $_white$url$_reset$_cyan');

    if (queryParams != null && queryParams.isNotEmpty) {
      buffer.writeln('║');
      buffer.writeln('║ Query Parameters:');
      queryParams.forEach((key, value) {
        buffer.writeln('║   • $key: $_yellow$value$_reset$_cyan');
      });
    }

    if (headers != null && headers.isNotEmpty) {
      buffer.writeln('║');
      buffer.writeln('║ Headers:');
      headers.forEach((key, value) {
        buffer.writeln('║   • $key: $_dim$value$_reset$_cyan');
      });
    }

    if (body != null) {
      buffer.writeln('║');
      buffer.writeln('║ Body:');
      final prettyBody = _prettyPrintJson(body);
      prettyBody.split('\n').forEach((line) {
        buffer.writeln('║   $line');
      });
    }

    buffer.writeln('╚═══════════════════════════════════════════════════════════════╝');
    buffer.write(_reset);

    developer.log(buffer.toString(), name: 'API_REQUEST');
  }

  /// Log API Response with beautiful formatting
  static void logResponse({
    required int statusCode,
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
    Duration? duration,
  }) {
    if (!_isDebugMode) return;

    final isSuccess = statusCode >= 200 && statusCode < 300;
    final color = isSuccess ? _green : _red;
    final emoji = isSuccess ? _successEmoji : _errorEmoji;

    final buffer = StringBuffer();
    buffer.writeln('$color$_bold');
    buffer.writeln('╔═══════════════════════════════════════════════════════════════╗');
    buffer.writeln('║ $_responseEmoji  API RESPONSE $emoji                                        ');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════╣');
    buffer.writeln('║ Status: $_white$_bold$statusCode$_reset$color');
    buffer.writeln('║ URL: $_white$url$_reset$color');

    if (duration != null) {
      buffer.writeln('║ Duration: $_yellow${duration.inMilliseconds}ms$_reset$color');
    }

    if (headers != null && headers.isNotEmpty) {
      buffer.writeln('║');
      buffer.writeln('║ Headers:');
      headers.forEach((key, value) {
        buffer.writeln('║   • $key: $_dim$value$_reset$color');
      });
    }

    if (data != null) {
      buffer.writeln('║');
      buffer.writeln('║ Response Data:');
      final prettyData = _prettyPrintJson(data);
      prettyData.split('\n').forEach((line) {
        buffer.writeln('║   $line');
      });
    }

    buffer.writeln('╚═══════════════════════════════════════════════════════════════╝');
    buffer.write(_reset);

    developer.log(buffer.toString(), name: 'API_RESPONSE');
  }

  /// Log JSON data with beautiful formatting
  static void logJson(dynamic json, {String? title}) {
    if (!_isDebugMode) return;

    final buffer = StringBuffer();
    buffer.writeln('$_magenta$_bold');
    buffer.writeln('');
    buffer.writeln('╔═══════════════════════════════════════════════════════════════╗');
    buffer.writeln('║                                                               ║');
    buffer.writeln('║  $_jsonEmoji  ${title ?? 'JSON DATA'}                         ║');
    buffer.writeln('║                                                               ║');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════╣');
    buffer.writeln('║                                                               ║');

    final prettyJson = _prettyPrintJson(json);
    prettyJson.split('\n').forEach((line) {
      buffer.writeln('║  $line');
    });

    buffer.writeln('║                                                               ║');
    buffer.writeln('╚═══════════════════════════════════════════════════════════════╝');
    buffer.writeln('');
    buffer.write(_reset);

    developer.log(buffer.toString(), name: 'JSON_LOG');
  }

  /// Log Success message
  static void success(String message, {dynamic data}) {
    if (!_isDebugMode) return;

    final buffer = StringBuffer();
    buffer.writeln('$_green$_bold');
    buffer.writeln('');
    buffer.writeln('╭───────────────────────────────────────────────────────────────╮');
    buffer.writeln('│                                                               │');
    buffer.writeln('│  $_successEmoji  SUCCESS                                      │');
    buffer.writeln('│                                                               │');
    buffer.writeln('├───────────────────────────────────────────────────────────────┤');
    buffer.writeln('│                                                               │');
    buffer.writeln('│  $_white$message$_reset$_green');

    if (data != null) {
      buffer.writeln('│                                                             ');
      buffer.writeln('│  ┌─────────────────────────────────────────────────────┐    ');
      buffer.writeln('│  │ 📊 Data                                                 ');
      buffer.writeln('│  └─────────────────────────────────────────────────────┘    ');
      final prettyData = _prettyPrintJson(data);
      prettyData.split('\n').forEach((line) {
        buffer.writeln('│     $line');
      });
    }

    buffer.writeln('│                                                               │');
    buffer.writeln('╰───────────────────────────────────────────────────────────────╯');
    buffer.writeln('');
    buffer.write(_reset);

    developer.log(buffer.toString(), name: 'SUCCESS');
  }

  /// Log Error message
  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    if (!_isDebugMode) return;

    final buffer = StringBuffer();
    buffer.writeln('$_red$_bold');
    buffer.writeln('');
    buffer.writeln('╔═══════════════════════════════════════════════════════════════╗');
    buffer.writeln('║                                                               ║');
    buffer.writeln('║  $_errorEmoji  ERROR                                          ║');
    buffer.writeln('║                                                               ║');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════╣');
    buffer.writeln('║                                                               ║');
    buffer.writeln('║  $_white$message$_reset$_red');

    if (error != null) {
      buffer.writeln('║                                                             ║');
      buffer.writeln('║  ┌─────────────────────────────────────────────────────┐    ║');
      buffer.writeln('║  │ 🔴 Error Details                                    │    ║');
      buffer.writeln('║  └─────────────────────────────────────────────────────┘    ║');
      buffer.writeln('║     $_white$error$_reset$_red');
    }

    if (stackTrace != null) {
      buffer.writeln('║                                                               ║');
      buffer.writeln('║  ┌─────────────────────────────────────────────────────┐    ║');
      buffer.writeln('║  │ 📍 Stack Trace (Top 5)                              │    ║');
      buffer.writeln('║  └─────────────────────────────────────────────────────┘    ║');
      final stackLines = stackTrace.toString().split('\n').take(5);
      for (var line in stackLines) {
        buffer.writeln('║     $_dim$line$_reset$_red');
      }
    }

    buffer.writeln('║                                                               ║');
    buffer.writeln('╚═══════════════════════════════════════════════════════════════╝');
    buffer.writeln('');
    buffer.write(_reset);

    developer.log(buffer.toString(), name: 'ERROR', error: error, stackTrace: stackTrace);
  }

  /// Log Warning message
  static void warning(String message, {dynamic data}) {
    if (!_isDebugMode) return;

    final buffer = StringBuffer();
    buffer.writeln('$_yellow$_bold');
    buffer.writeln('');
    buffer.writeln('┌───────────────────────────────────────────────────────────────┐');
    buffer.writeln('│                                                               │');
    buffer.writeln('│  $_warningEmoji  WARNING                                      │');
    buffer.writeln('│                                                               │');
    buffer.writeln('├───────────────────────────────────────────────────────────────┤');
    buffer.writeln('│                                                               │');
    buffer.writeln('│  $_white$message$_reset$_yellow');

    if (data != null) {
      buffer.writeln('│                                                             │');
      buffer.writeln('│  ╔═════════════════════════════════════════════════════╗    │');
      buffer.writeln('│  ║ 📊 Warning Data                                     ║    │');
      buffer.writeln('│  ╚═════════════════════════════════════════════════════╝    │');
      final prettyData = _prettyPrintJson(data);
      prettyData.split('\n').forEach((line) {
        buffer.writeln('│     $line');
      });
    }

    buffer.writeln('│                                                               │');
    buffer.writeln('└───────────────────────────────────────────────────────────────┘');
    buffer.writeln('');
    buffer.write(_reset);

    developer.log(buffer.toString(), name: 'WARNING');
  }

  /// Log Info message
  static void info(String message, {dynamic data}) {
    if (!_isDebugMode) return;

    final buffer = StringBuffer();
    buffer.writeln('$_blue$_bold');
    buffer.writeln('');
    buffer.writeln('╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮');
    buffer.writeln('┃                                                               ┃');
    buffer.writeln('┃  $_infoEmoji  INFO                                            ┃');
    buffer.writeln('┃                                                               ┃');
    buffer.writeln('┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫');
    buffer.writeln('┃                                                               ┃');
    buffer.writeln('┃  $_white$message$_reset$_blue');

    if (data != null) {
      buffer.writeln('┃                                                            ┃');
      buffer.writeln('┃  ╭─────────────────────────────────────────────────────╮   ┃');
      buffer.writeln('┃  │ 💡 Additional Info                                  │   ┃');
      buffer.writeln('┃  ╰─────────────────────────────────────────────────────╯    ┃');
      final prettyData = _prettyPrintJson(data);
      prettyData.split('\n').forEach((line) {
        buffer.writeln('┃     $line');
      });
    }

    buffer.writeln('┃                                                             ┃');
    buffer.writeln('╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯');
    buffer.writeln('');
    buffer.write(_reset);

    developer.log(buffer.toString(), name: 'INFO');
  }

  /// Log Debug message
  static void debug(String message, {dynamic data}) {
    if (!_isDebugMode) return;

    final buffer = StringBuffer();
    buffer.writeln(_cyan);
    buffer.writeln('');
    buffer.writeln('▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓');
    buffer.writeln('▓                                                               ▓');
    buffer.writeln('▓  $_debugEmoji  DEBUG                                          ▓');
    buffer.writeln('▓                                                               ▓');
    buffer.writeln('▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓');
    buffer.writeln('▓                                                               ▓');
    buffer.writeln('▓  $message');

    if (data != null) {
      buffer.writeln('▓                                                             ▓');
      buffer.writeln('▓  ╔═════════════════════════════════════════════════════╗    ▓');
      buffer.writeln('▓  ║ 🔍 Debug Data                                       ║    ▓');
      buffer.writeln('▓  ╚═════════════════════════════════════════════════════╝    ▓');
      final prettyData = _prettyPrintJson(data);
      prettyData.split('\n').forEach((line) {
        buffer.writeln('▓     $line');
      });
    }

    buffer.writeln('▓                                                               ▓');
    buffer.writeln('▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓');
    buffer.writeln('');
    buffer.write(_reset);

    developer.log(buffer.toString(), name: 'DEBUG');
  }

  /// Pretty print JSON with proper indentation
  static String _prettyPrintJson(dynamic json) {
    try {
      if (json is String) {
        // Try to parse if it's a JSON string
        try {
          final decoded = jsonDecode(json);
          return const JsonEncoder.withIndent('  ').convert(decoded);
        } catch (_) {
          return json;
        }
      }
      return const JsonEncoder.withIndent('  ').convert(json);
    } catch (e) {
      return json.toString();
    }
  }

  /// Log separator line
  static void separator({String style = 'double'}) {
    if (!_isDebugMode) return;
    
    String line;
    switch (style) {
      case 'single':
        line = '─────────────────────────────────────────────────────────────────';
        break;
      case 'double':
        line = '═════════════════════════════════════════════════════════════════';
        break;
      case 'thick':
        line = '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━';
        break;
      case 'dotted':
        line = '┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄';
        break;
      case 'stars':
        line = '✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦';
        break;
      default:
        line = '═════════════════════════════════════════════════════════════════';
    }
    
    developer.log('$_dim$line$_reset');
  }

  /// Log a custom box with title and content
  static void customBox({
    required String title,
    required String content,
    String emoji = '📌',
    String color = 'cyan',
  }) {
    if (!_isDebugMode) return;

    String colorCode;
    switch (color) {
      case 'red':
        colorCode = _red;
        break;
      case 'green':
        colorCode = _green;
        break;
      case 'yellow':
        colorCode = _yellow;
        break;
      case 'blue':
        colorCode = _blue;
        break;
      case 'magenta':
        colorCode = _magenta;
        break;
      case 'cyan':
        colorCode = _cyan;
        break;
      default:
        colorCode = _white;
    }

    final buffer = StringBuffer();
    buffer.writeln('$colorCode$_bold');
    buffer.writeln('');
    buffer.writeln('╔═══════════════════════════════════════════════════════════════╗');
    buffer.writeln('║                                                               ');
    buffer.writeln('║  $emoji  $title');
    buffer.writeln('║                                                               ');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════');
    buffer.writeln('║                                                               ');
    
    content.split('\n').forEach((line) {
      buffer.writeln('║  $line');
    });

    buffer.writeln('║                                                               ');
    buffer.writeln('╚═══════════════════════════════════════════════════════════════╝');
    buffer.writeln('');
    buffer.write(_reset);

    developer.log(buffer.toString(), name: 'CUSTOM_BOX');
  }
}
