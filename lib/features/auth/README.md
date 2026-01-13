# Authentication System

Complete authentication system with auto-login functionality using token-based authentication.

## Features

✅ **Login** - Email and password authentication  
✅ **Register** - User registration with validation  
✅ **Auto-Login** - Automatic login using saved token  
✅ **Token Storage** - Secure token storage in local storage  
✅ **Logout** - Clear token and user data  
✅ **Beautiful Logging** - Colorful console logs for debugging  
✅ **Error Handling** - Comprehensive error handling  
✅ **Form Validation** - Email, password, and name validation  

## API Configuration

**Base URL:** `http://10.10.7.41:5001/api/v1`

### Endpoints

- **Login:** `POST /auth/login`
- **Register:** `POST /auth/register`
- **Logout:** `POST /auth/logout`

### Request Format

**Login:**
```json
{
  "email": "user@gmail.com",
  "password": "hello123"
}
```

**Register:**
```json
{
  "name": "John Doe",
  "email": "user@gmail.com",
  "password": "hello123",
  "phone": "+880 1234567890"
}
```

### Response Format

```json
{
  "success": true,
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "user@gmail.com",
    "phone": "+880 1234567890",
    "avatar": null,
    "created_at": "2026-01-13T10:00:00Z"
  }
}
```

## Installation

### 1. Add Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  dio: ^5.9.0
  shared_preferences: ^2.3.3
  get: ^4.6.6
```

Run:
```bash
flutter pub get
```

### 2. Initialize Services

Update your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'core/services/api_service.dart';
import 'core/services/storage_service.dart';
import 'core/utils/app_logger.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await StorageService.init();
  ApiService().init();

  runApp(const MyApp());
}
```

## Usage

### 1. Login

```dart
import 'package:get/get.dart';
import 'features/auth/controllers/auth_controller.dart';

// In your widget
final AuthController authController = Get.put(AuthController());

// Set email and password
authController.emailController.text = 'user@gmail.com';
authController.passwordController.text = 'hello123';

// Login
await authController.login();

// Check if logged in
if (authController.isLoggedIn.value) {
  print('User is logged in!');
}
```

### 2. Register

```dart
// Set registration data
authController.nameController.text = 'John Doe';
authController.emailController.text = 'user@gmail.com';
authController.passwordController.text = 'hello123';
authController.phoneController.text = '+880 1234567890';

// Register
await authController.register();
```

### 3. Logout

```dart
await authController.logout();
```

### 4. Check Login Status

```dart
// Check if user is logged in
final isLoggedIn = authController.isLoggedIn.value;

// Or use repository directly
import 'data/repositories/auth_repository.dart';

final authRepo = AuthRepository();
final isLoggedIn = authRepo.isLoggedIn();
```

### 5. Get Current User

```dart
import 'data/repositories/auth_repository.dart';

final authRepo = AuthRepository();
final user = authRepo.getCurrentUser();

if (user != null) {
  print('User: ${user.name}');
  print('Email: ${user.email}');
}
```

### 6. Get Token

```dart
import 'core/services/storage_service.dart';

final token = StorageService.getToken();
print('Token: $token');
```

## Auto-Login Flow

1. **App Starts** → `main.dart` initializes services
2. **Storage Service** → Loads saved token from local storage
3. **Auth Controller** → Checks if token exists in `onInit()`
4. **Token Found** → Sets `isLoggedIn = true`
5. **Navigate** → Redirect to home screen
6. **API Requests** → Token automatically added to headers via interceptor

## File Structure

```
lib/
├── core/
│   ├── config/
│   │   ├── api_config.dart          # API base URLs
│   │   ├── api_endpoints.dart       # API endpoints
│   │   └── app_config.dart          # App configuration
│   ├── services/
│   │   ├── api_service.dart         # HTTP client (Dio)
│   │   └── storage_service.dart     # Local storage
│   ├── middleware/
│   │   └── auth_middleware.dart     # Route protection
│   └── utils/
│       └── app_logger.dart          # Beautiful logging
├── data/
│   ├── models/
│   │   └── auth_response_model.dart # Auth response model
│   └── repositories/
│       └── auth_repository.dart     # Auth API calls
└── features/
    └── auth/
        ├── controllers/
        │   └── auth_controller.dart # Auth state management
        ├── views/
        │   ├── login_screen.dart    # Login UI
        │   └── register_screen.dart # Register UI
        └── auth_example.dart        # Complete example
```

## How It Works

### Token Storage

When user logs in successfully:
1. API returns token in response
2. Token is saved to `SharedPreferences`
3. User data is also saved
4. `isLoggedIn` flag is set to true

### Auto-Login

On app restart:
1. `StorageService.init()` loads SharedPreferences
2. `AuthController.onInit()` checks for saved token
3. If token exists, user is automatically logged in
4. No need to login again

### API Interceptor

All API requests automatically include the token:
```dart
// In api_service.dart
onRequest: (options, handler) {
  final token = StorageService.getToken();
  if (token != null) {
    options.headers['Authorization'] = 'Bearer $token';
  }
  return handler.next(options);
}
```

### Logout

When user logs out:
1. API logout endpoint is called
2. Token is removed from local storage
3. User data is removed
4. User is redirected to login screen

## Beautiful Console Logs

The system includes colorful console logs for debugging:

```dart
// Login request
AppLogger.logRequest(
  method: 'POST',
  url: 'http://10.10.7.41:5001/api/v1/auth/login',
  body: {'email': 'user@gmail.com', 'password': '***'},
);

// Login response
AppLogger.logResponse(
  statusCode: 200,
  url: 'http://10.10.7.41:5001/api/v1/auth/login',
  data: {'success': true, 'token': '...'},
);

// Success message
AppLogger.success('Login successful', data: {'email': 'user@gmail.com'});

// Error message
AppLogger.error('Login failed', error: 'Invalid credentials');
```

## Testing

### Test Login

```dart
// Use these credentials (update with your actual test credentials)
Email: user@gmail.com
Password: hello123
```

### Check Logs

Open your console/terminal to see beautiful colored logs:
- 📤 Blue boxes for API requests
- 📥 Green/Red boxes for API responses
- ✅ Green boxes for success messages
- ❌ Red boxes for errors
- ⚠️ Yellow boxes for warnings

## Troubleshooting

### Token not saving
- Check if `StorageService.init()` is called in `main.dart`
- Check console logs for storage errors

### Auto-login not working
- Verify token is saved: `print(StorageService.getToken())`
- Check if `AuthController` is initialized
- Look for errors in console logs

### API errors
- Verify base URL is correct: `http://10.10.7.41:5001/api/v1`
- Check network connection
- Look at API response in console logs
- Verify API endpoints match your backend

### Navigation issues
- Make sure GetX routes are configured
- Check if `Get.offAllNamed('/home')` is called after login
- Verify route names match

## Security Notes

⚠️ **Important:**
- Never commit API keys or tokens to version control
- Use environment variables for sensitive data
- Implement token refresh mechanism for production
- Add token expiration handling
- Use HTTPS in production
- Implement biometric authentication for better security

## Next Steps

1. ✅ Basic authentication is complete
2. 🔄 Add token refresh mechanism
3. 🔄 Add forgot password functionality
4. 🔄 Add email verification
5. 🔄 Add social login (Google, Facebook)
6. 🔄 Add biometric authentication
7. 🔄 Add two-factor authentication

## Support

For issues or questions:
- Check console logs for detailed error messages
- Review the `auth_example.dart` file for complete implementation
- Check API response format matches expected format
