#!/bin/bash

# Build script for iOS release
echo "Building iOS release..."

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build iOS release
flutter build ios --release

echo "iOS build completed successfully!"
echo "You can now archive and upload to TestFlight from Xcode"
