#!/bin/bash

echo "🚀 Building One QR App..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build for Android
echo "🤖 Building Android APK..."
flutter build apk --release

# Build for iOS (if on macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Building iOS app..."
    flutter build ios --release
else
    echo "⚠️  iOS build skipped (requires macOS)"
fi

echo "✅ Build complete!"
echo ""
echo "📱 Android APK location: build/app/outputs/flutter-apk/app-release.apk"
echo "🍎 iOS build location: build/ios/archive/Runner.xcarchive"
echo ""
echo "To install on Android device:"
echo "adb install build/app/outputs/flutter-apk/app-release.apk" 