# One QR App

A fast, lightweight Flutter app that displays a single QR code image immediately when opened. Perfect for coworking spaces, supermarkets, events, or any situation where you need instant QR code access.

## Features

- ⚡ **Ultra-fast loading** - Displays QR code in less than 0.5 seconds
- 📱 **Cross-platform** - Works on Android and iOS
- 🔒 **Offline-first** - No internet connection required
- 🎨 **Clean design** - Simple, professional appearance
- 📦 **Lightweight** - Minimal dependencies for maximum speed

## Customization

You can choose any image (for example, a QR code image) from your device to display in the app. The app will always show the last image you picked, even after you close and reopen the app.

- Tap the upload button in the app to select an image from your gallery.
- The selected image will be displayed and remembered for future launches.

No code changes are needed—just pick your image in the app!

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Performance Optimizations

- Minimal UI components
- No network requests on startup
- Optimized for immediate display

## Requirements

- Flutter 3.8.1 or higher
- Dart 3.0 or higher
- Android SDK (for Android builds)
- Xcode (for iOS builds)

## Getting Started

1. Clone this repository
2. Run `flutter pub get`
3. Run `flutter run` to test
4. Build for production with `flutter build apk` or `flutter build ios`

When you open the app, tap the upload button to pick any image (such as a QR code) from your device. The app will always display the last image you picked, even after closing and reopening.
