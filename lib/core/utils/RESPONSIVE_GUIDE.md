# 📐 Responsive Scaling System

Complete guide for building fully responsive UIs that scale perfectly across **mobile, tablet, desktop, and TV screens**.

## 🎯 Overview

The `ResponsiveScale` system automatically scales **all UI elements** based on screen size:
- ✅ Text sizes
- ✅ Icons
- ✅ Spacing & Padding
- ✅ Images & Cards
- ✅ Border radius
- ✅ Grid columns
- ✅ Everything!

## 🚀 Quick Start

### 1. Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:your_app/core/utils/responsive_scale.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize responsive system
    ResponsiveScale.init(context);
    
    return Container(
      width: ResponsiveScale.width(200),      // Scales width
      height: ResponsiveScale.height(100),    // Scales height
      padding: EdgeInsets.all(
        ResponsiveScale.spacing(16),          // Scales padding
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          ResponsiveScale.radius(12),         // Scales radius
        ),
      ),
      child: Text(
        'Hello',
        style: TextStyle(
          fontSize: ResponsiveScale.fontSize(16), // Scales font
        ),
      ),
    );
  }
}
```

### 2. Using Context Extensions (Shorter Syntax)

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sw(200),              // Scale width
      height: context.sh(100),             // Scale height
      padding: EdgeInsets.all(context.sp(16)), // Scale spacing
      child: Text(
        'Hello',
        style: TextStyle(
          fontSize: context.sf(16),        // Scale font
        ),
      ),
      child: Icon(
        Icons.star,
        size: context.si(24),              // Scale icon
      ),
    );
  }
}
```

## 📱 Device Detection

```dart
// Check device type
if (context.isMobile) {
  // Mobile specific UI
} else if (context.isTablet) {
  // Tablet specific UI
} else if (context.isDesktop) {
  // Desktop specific UI
} else if (context.isTV) {
  // TV specific UI
}

// Or use responsive values
final columns = ResponsiveScale.responsive(
  mobile: 2,
  tablet: 3,
  desktop: 4,
  tv: 6,
);
```

## 🎨 Scaling Methods

### Width & Height Scaling
```dart
// Scale based on screen width
double scaledWidth = ResponsiveScale.width(100);
double scaledWidth = context.sw(100);  // Short form

// Scale based on screen height
double scaledHeight = ResponsiveScale.height(100);
double scaledHeight = context.sh(100);  // Short form
```

### Proportional Scaling (Recommended)
```dart
// Scales using the smaller dimension (maintains aspect ratio)
double scaled = ResponsiveScale.scale(50);
double scaled = context.sp(50);  // Short form

// Best for: padding, margins, card sizes
```

### Font Size Scaling
```dart
// Automatically adjusts for device type
// Mobile: 1x, Tablet: 1.1x, Desktop: 1.15x, TV: 1.5x
double fontSize = ResponsiveScale.fontSize(16);
double fontSize = context.sf(16);  // Short form
```

### Icon Size Scaling
```dart
// Automatically adjusts for device type
// Mobile: 1x, Tablet: 1.15x, Desktop: 1.2x, TV: 1.8x
double iconSize = ResponsiveScale.iconSize(24);
double iconSize = context.si(24);  // Short form
```

### Spacing & Radius
```dart
// For padding, margins, gaps
double spacing = ResponsiveScale.spacing(16);

// For border radius
double radius = ResponsiveScale.radius(12);
```

## 🧩 Responsive Widgets

### ResponsiveBuilder
```dart
ResponsiveBuilder(
  builder: (context, deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return MobileLayout();
      case DeviceType.tablet:
        return TabletLayout();
      case DeviceType.desktop:
        return DesktopLayout();
      case DeviceType.tv:
        return TVLayout();
    }
  },
)
```

### ResponsivePadding
```dart
ResponsivePadding(
  all: 16,  // Automatically scaled
  child: Text('Hello'),
)

ResponsivePadding(
  horizontal: 20,
  vertical: 10,
  child: Text('Hello'),
)
```

### ResponsiveSizedBox
```dart
ResponsiveSizedBox(
  width: 200,   // Automatically scaled
  height: 100,  // Automatically scaled
  child: Image.asset('...'),
)
```

### ResponsiveText
```dart
ResponsiveText(
  'Hello World',
  fontSize: 16,  // Automatically scaled
  fontWeight: FontWeight.bold,
  color: Colors.black,
)
```

## 📊 Grid Columns

```dart
// Get responsive column count
int columns = ResponsiveScale.gridColumns(
  mobile: 2,
  tablet: 3,
  desktop: 4,
  tv: 6,
);

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: columns,
    childAspectRatio: ResponsiveScale.aspectRatio(
      mobile: 2/3,
      tablet: 2/3,
      desktop: 2/3,
      tv: 16/9,
    ),
  ),
  itemBuilder: (context, index) => MovieCard(),
)
```

## 🎯 Responsive Values

```dart
// Return different values based on device
final padding = ResponsiveScale.responsive<double>(
  mobile: 16,
  tablet: 24,
  desktop: 32,
  tv: 48,
);

final layout = ResponsiveScale.responsive<Widget>(
  mobile: ListView(),
  tablet: GridView(),
  desktop: GridView(),
  tv: GridView(),
);
```

## 📐 Device Breakpoints

| Device | Width Range | Scale Multiplier |
|--------|-------------|------------------|
| **Mobile** | < 600px | 1.0x |
| **Tablet** | 600px - 1024px | 1.1x (fonts), 1.15x (icons) |
| **Desktop** | 1024px - 1920px | 1.15x (fonts), 1.2x (icons) |
| **TV** | > 1920px | 1.5x (fonts), 1.8x (icons) |

## 💡 Best Practices

### ✅ DO

```dart
// Use responsive scaling
Container(
  padding: EdgeInsets.all(context.sp(16)),
  child: Text(
    'Hello',
    style: TextStyle(fontSize: context.sf(16)),
  ),
)

// Use responsive values for different devices
final columns = ResponsiveScale.gridColumns(
  mobile: 2,
  tablet: 3,
  desktop: 4,
  tv: 6,
);
```

### ❌ DON'T

```dart
// Don't use hardcoded values
Container(
  padding: EdgeInsets.all(16),  // ❌ Not responsive
  child: Text(
    'Hello',
    style: TextStyle(fontSize: 16),  // ❌ Not responsive
  ),
)
```

## 🎬 Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:your_app/core/utils/responsive_scale.dart';
import 'package:your_app/core/constants/app_colors.dart';

class MovieCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sw(150),
      height: context.sh(225),
      margin: EdgeInsets.all(context.sp(8)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(context.sp(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: context.sp(8),
            offset: Offset(0, context.sp(4)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(context.sp(12)),
            ),
            child: Image.network(
              'https://example.com/poster.jpg',
              width: context.sw(150),
              height: context.sh(200),
              fit: BoxFit.cover,
            ),
          ),
          
          ResponsivePadding(
            all: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                ResponsiveText(
                  'Movie Title',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                ResponsiveSizedBox(height: 4),
                
                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: context.si(16),
                      color: Colors.amber,
                    ),
                    ResponsiveSizedBox(width: 4),
                    ResponsiveText(
                      '8.5',
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🔧 Advanced Usage

### Custom Device Breakpoints
```dart
// Modify breakpoints in responsive_scale.dart
static const double mobileMax = 600.0;
static const double tabletMax = 1024.0;
static const double desktopMax = 1920.0;
```

### Custom Scale Multipliers
```dart
// Modify scale factors for different devices
case DeviceType.tv:
  return scaled * 2.0;  // Make TV text even larger
```

### Max Content Width (Center on Large Screens)
```dart
Container(
  width: ResponsiveScale.maxContentWidth,
  child: YourContent(),
)
```

## 📱 Orientation Support

```dart
if (ResponsiveScale.isLandscape) {
  // Landscape layout
} else {
  // Portrait layout
}
```

## 🎯 Integration with Existing Code

### Update AppSizes Constants
```dart
// In app_sizes.dart
import '../utils/responsive_scale.dart';

// Use responsive scaling
static double paddingMD(BuildContext context) => context.sp(16);
static double radiusMD(BuildContext context) => context.sp(12);
```

### Update Widgets
```dart
// Before
Text('Hello', style: TextStyle(fontSize: 16))

// After
Text('Hello', style: TextStyle(fontSize: context.sf(16)))
```

---

## 🎉 Result

Your app will now **automatically scale perfectly** on:
- 📱 Small phones (iPhone SE)
- 📱 Large phones (iPhone 14 Pro Max)
- 📱 Tablets (iPad)
- 💻 Desktops (MacBook, Windows)
- 📺 TVs (4K displays)

**No manual adjustments needed!** 🚀
