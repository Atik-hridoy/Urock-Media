# 🚀 Authentication Setup Guide

Complete guide to set up and use the authentication system with auto-login.

## ✅ What's Been Created

### 1. **API Configuration**
- ✅ Base URL: `http://10.10.7.41:5001/api/v1`
- ✅ API endpoints configured
- ✅ Image and video URLs configured

### 2. **Services**
- ✅ `ApiService` - HTTP client using Dio
- ✅ `StorageService` - Local storage using SharedPreferences
- ✅ `AppLogger` - Beautiful colorful console logs

### 3. **Authentication System**
- ✅ Login functionality
- ✅ Register functionality
- ✅ Auto-login with token storage
- ✅ Logout functionality
- ✅ Token management
- ✅ User data management

### 4. **UI Screens**
- ✅ Login screen with validation
- ✅ Register screen with validation
- ✅ Error handling and loading states

### 5. **Dependencies Installed**
- ✅ `dio: ^5.9.0` - HTTP client
- ✅ `shared_preferences: ^2.3.3` - Local storage
- ✅ `get: ^4.6.6` - State management & navigation

## 🎯 Quick Start

### Step 1: Test the Login

The system is ready to use! Here's how to test it:

```dart
// In your main.dart or any screen
import 'package:get/get.dart';
import 'features/auth/controllers/auth_controller.dart';

final AuthController authController = Get.put(AuthController());

// Login
authController.emailController.text = 'user@gmail.com';
authController.passwordController.text = 'hello123';
await authController.login();
```

### Step 2: Check Auto-Login

1. Login successfully
2. Close the app
3. Restart the app
4. ✅ You'll be automatically logged in!

### Step 3: View Beautiful Logs

Open your console to see colorful logs:

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                                                                 ┃
┃  📤  API REQUEST                                                ┃
┃                                                                 ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                                 ┃
┃  🔹 Method: POST                                                ┃
┃  🔹 URL: http://10.10.7.41:5001/api/v1/auth/login              ┃
┃                                                                 ┃
┃  ╭─────────────────────────────────────────────────────────╮  ┃
┃  │ 📦 Request Body                                         │  ┃
┃  ╰─────────────────────────────────────────────────────────╯  ┃
┃     {                                                           ┃
┃       "email": "user@gmail.com",                                ┃
┃       "password": "hello123"                                    ┃
┃     }                                                            ┃
┃                                                                 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

## 📁 File Locations

### Core Files
```
lib/core/
├── config/
│   ├── api_config.dart          ← Base URL: http://10.10.7.41:5001/api/v1
│   ├── api_endpoints.dart       ← All API endpoints
│   └── app_config.dart          ← App settings
├── services/
│   ├── api_service.dart         ← HTTP client
│   └── storage_service.dart     ← Token storage
└── utils/
    └── app_logger.dart          ← Beautiful logs
```

### Auth Files
```
lib/features/auth/
├── controllers/
│   └── auth_controller.dart     ← Login/Register logic
├── views/
│   ├── login_screen.dart        ← Login UI
│   └── register_screen.dart     ← Register UI
└── README.md                    ← Full documentation
```

### Data Files
```
lib/data/
├── models/
│   └── auth_response_model.dart ← API response model
└── repositories/
    └── auth_repository.dart     ← API calls
```

## 🔧 How to Use in Your App

### Option 1: Use the Example Screens

```dart
import 'package:get/get.dart';
import 'features/auth/views/login_screen.dart';

// Navigate to login
Get.to(() => LoginScreen());
```

### Option 2: Create Your Own UI

```dart
import 'package:get/get.dart';
import 'features/auth/controllers/auth_controller.dart';

class MyLoginScreen extends StatelessWidget {
  final AuthController auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: auth.emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: auth.passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () => auth.login(),
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
```

## 🔐 How Auto-Login Works

### 1. **First Login**
```
User enters credentials
    ↓
API call to /auth/login
    ↓
Server returns token
    ↓
Token saved to SharedPreferences
    ↓
User data saved to SharedPreferences
    ↓
Navigate to home screen
```

### 2. **App Restart**
```
App starts
    ↓
StorageService.init() loads SharedPreferences
    ↓
AuthController checks for saved token
    ↓
Token found? → isLoggedIn = true
    ↓
Navigate to home screen (skip login)
```

### 3. **API Requests**
```
Any API call
    ↓
Interceptor checks for token
    ↓
Token found? → Add to headers
    ↓
Request sent with: Authorization: Bearer {token}
```

## 📝 API Request/Response Format

### Login Request
```json
POST http://10.10.7.41:5001/api/v1/auth/login

{
  "email": "user@gmail.com",
  "password": "hello123"
}
```

### Login Response (Success)
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

### Login Response (Error)
```json
{
  "success": false,
  "message": "Invalid credentials"
}
```

## 🧪 Testing

### Test Credentials
Update these with your actual test credentials:
```
Email: user@gmail.com
Password: hello123
```

### Test Auto-Login
1. Run the app
2. Login with credentials
3. Check console - you should see: ✅ "Login successful"
4. Close the app completely
5. Restart the app
6. Check console - you should see: ℹ️ "User is already logged in"
7. ✅ You're automatically logged in!

### Test Logout
```dart
await authController.logout();
```
- Token is removed
- User data is removed
- Redirected to login screen

## 🎨 Console Log Examples

### Success Log
```
╭───────────────────────────────────────────────────────────────╮
│                                                               │
│  ✅  SUCCESS                                                  │
│                                                               │
├───────────────────────────────────────────────────────────────┤
│                                                               │
│  Login successful                                             │
│                                                               │
│  ┌─────────────────────────────────────────────────────┐    │
│  │ 📊 Data                                             │    │
│  └─────────────────────────────────────────────────────┘    │
│     {                                                         │
│       "email": "user@gmail.com",                              │
│       "token_saved": true                                     │
│     }                                                          │
│                                                               │
╰───────────────────────────────────────────────────────────────╯
```

### Error Log
```
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║  ❌  ERROR                                                    ║
║                                                               ║
╠═══════════════════════════════════════════════════════════════╣
║                                                               ║
║  Login failed                                                 ║
║                                                               ║
║  ┌─────────────────────────────────────────────────────┐    ║
║  │ 🔴 Error Details                                    │    ║
║  └─────────────────────────────────────────────────────┘    ║
║     Invalid credentials                                       ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
```

## 🔍 Debugging

### Check if token is saved
```dart
import 'core/services/storage_service.dart';

final token = StorageService.getToken();
print('Token: $token');
```

### Check if user is logged in
```dart
final isLoggedIn = StorageService.isLoggedIn();
print('Is Logged In: $isLoggedIn');
```

### Check user data
```dart
final userData = StorageService.getUserData();
print('User Data: $userData');
```

### Clear all data (for testing)
```dart
await StorageService.clearAll();
```

## ⚡ Next Steps

1. ✅ **Test the login** - Use the provided screens
2. ✅ **Test auto-login** - Restart the app
3. ✅ **Check console logs** - See beautiful colored output
4. 🔄 **Integrate with your UI** - Use AuthController in your screens
5. 🔄 **Add more features** - Forgot password, email verification, etc.

## 📚 Documentation

- **Full Auth Documentation:** `lib/features/auth/README.md`
- **API Config Documentation:** `lib/core/config/README.md`
- **Complete Example:** `lib/features/auth/auth_example.dart`
- **Logger Examples:** `lib/core/utils/logger_example.dart`

## 🆘 Troubleshooting

### Issue: Token not saving
**Solution:** Make sure `StorageService.init()` is called in `main.dart` before `runApp()`

### Issue: Auto-login not working
**Solution:** Check console logs for "User is already logged in" message

### Issue: API errors
**Solution:** 
1. Verify base URL: `http://10.10.7.41:5001/api/v1`
2. Check network connection
3. Look at console logs for detailed error

### Issue: Navigation not working
**Solution:** Make sure you're using GetX for navigation: `Get.offAllNamed('/home')`

## 🎉 You're All Set!

The authentication system is fully configured and ready to use with:
- ✅ Base URL: `http://10.10.7.41:5001/api/v1`
- ✅ Login endpoint: `/auth/login`
- ✅ Token storage in local storage
- ✅ Auto-login on app restart
- ✅ Beautiful console logs
- ✅ Complete error handling

**Start testing now!** 🚀
