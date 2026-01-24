# Debug Checklist - Popular Movies Not Showing

## Step 1: Deploy the App
```bash
scripts\quick_deploy.bat
```

## Step 2: Check Logs
```bash
scripts\view_logs.bat
```

## Step 3: Look for These Log Messages

### ✅ Expected Logs (Success):
```
Loading popular movies from API...
API Endpoint: /movies/popular
API Response Status: 200
Response is Map/List with X items
Popular movies fetched: X movies
Popular movies loaded: X movies
Building Popular Movies Section with X movies
```

### ❌ Error Logs (Failure):
```
Failed to fetch popular movies: [error message]
API Response Status: 404/500
Popular movies loaded: 0 movies
Popular Movies (Empty - No Data)
```

## Step 4: Verify in UI

### If Data Exists:
- Movies tab should show "Popular Movies" section
- Cards should display like Trending Movies
- Horizontal scrollable list

### If Data Empty:
- Section shows: "Popular Movies (Empty - No Data)"
- Gray placeholder box
- Orange text color

## Step 5: Common Issues & Solutions

### Issue 1: Section Not Visible
**Cause:** App not rebuilt
**Solution:** Run `scripts\quick_deploy.bat` again

### Issue 2: "Empty - No Data" Showing
**Cause:** API returning empty list or failing
**Solution:** Check logs for API error

### Issue 3: API Call Failing
**Possible Causes:**
- Backend not running
- Wrong API endpoint
- Network permission missing (already added)
- Token missing/invalid

**Check:**
```
API Endpoint: /movies/popular
Base URL: [check ApiConfig.baseUrl]
```

### Issue 4: Response Format Mismatch
**Expected Formats:**

Format 1 (with wrapper):
```json
{
  "success": true,
  "data": [
    { "id": 1, "title": "Movie 1", ... }
  ]
}
```

Format 2 (direct array):
```json
[
  { "id": 1, "title": "Movie 1", ... }
]
```

**Check logs for:**
```
Response is Map, keys: [...]
Response is List with X items
```

## Step 6: Manual API Test

Test API directly:
```bash
# Check if API is accessible
curl http://YOUR_BASE_URL/movies/popular

# Or use Postman/Thunder Client
GET http://YOUR_BASE_URL/movies/popular
```

## Step 7: Temporary Mock Data (If API Not Ready)

If API not ready yet, you can temporarily use mock data:

In `lib/features/home/services/movie_service.dart`:
```dart
Future<List<Movie>> getPopularMovies() async {
  // Temporary: Return mock data
  Logger.info('Using MOCK data for popular movies');
  return _getMockMovies();
}
```

## Current Code Status

### ✅ Completed:
- [x] API endpoint configured (`/movies/popular`)
- [x] Service method created (`getPopularMovies()`)
- [x] Controller method created (`_loadPopularMovies()`)
- [x] UI section added in Movies tab
- [x] Debug logging added
- [x] Empty state handling added
- [x] Internet permission added to manifest

### 🔄 Needs Verification:
- [ ] API is running and accessible
- [ ] API returns correct data format
- [ ] Data displays in UI
- [ ] Cards render properly

## Next Actions

1. **Deploy:** `scripts\quick_deploy.bat`
2. **Open app** on TV emulator
3. **Go to Movies tab**
4. **Check logs:** `scripts\view_logs.bat`
5. **Share logs** to debug further

## Log Commands

### View all Flutter logs:
```bash
adb -s emulator-5554 logcat -s flutter:I
```

### Search for specific logs:
```bash
# Popular movies logs
adb -s emulator-5554 logcat -d | findstr "Popular movies"

# API logs
adb -s emulator-5554 logcat -d | findstr "API"

# Error logs
adb -s emulator-5554 logcat -d | findstr "error"
```

## Expected Result

After successful deployment, Movies tab should show:

```
┌─────────────────────────────────┐
│  Featured Content (Banner)      │
└─────────────────────────────────┘

Popular Movies
┌────┐ ┌────┐ ┌────┐ ┌────┐
│ 🎬 │ │ 🎬 │ │ 🎬 │ │ 🎬 │  ← API Data
└────┘ └────┘ └────┘ └────┘

Trending Movies
┌────┐ ┌────┐ ┌────┐ ┌────┐
│ 🎬 │ │ 🎬 │ │ 🎬 │ │ 🎬 │  ← Mock Data
└────┘ └────┘ └────┘ └────┘

Top Rated
┌────┐ ┌────┐ ┌────┐ ┌────┐
│ 🎬 │ │ 🎬 │ │ 🎬 │ │ 🎬 │  ← Mock Data
└────┘ └────┘ └────┘ └────┘
```

All sections use the same `MovieSection` widget, so cards will look identical!
