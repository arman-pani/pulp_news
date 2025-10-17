#!/bin/bash

# Build script for Android release
echo "Building Android release APK..."

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build release APK
flutter build apk --release

echo "Android APK built successfully!"
echo "APK location: build/app/outputs/flutter-apk/app-release.apk"
