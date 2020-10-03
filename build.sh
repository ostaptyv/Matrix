# Script for packaging .xcframework
# This script will work only if BUILD_LIBRARY_FOR_DISTRIBUTION in 'Build settings' set to YES

# Build platform specific frameworks:

# iOS devices
xcodebuild archive \
    -scheme Matrix \
    -archivePath "./Products/ios.xcarchive" \
    -sdk iphoneos \
    SKIP_INSTALL=NO
    
# iOS simulator
xcodebuild archive \
    -scheme Matrix \
    -archivePath "./Products/ios-simulator.xcarchive" \
    -sdk iphonesimulator \
    SKIP_INSTALL=NO

# Package .xcframework:
xcodebuild -create-xcframework \
    -framework "./Products/ios.xcarchive/Products/Library/Frameworks/Matrix.framework" \
    -framework "./Products/ios-simulator.xcarchive/Products/Library/Frameworks/Matrix.framework" \
    -output "./Products/Matrix.xcframework"

# Clean 'Products' folder after packaging
rm -rf ./Products/ios.xcarchive
rm -rf ./Products/ios-simulator.xcarchive

# Delete 'Matrix.' prefix in all .swiftinterface files of Matrix.xcframework
cd ./Products/Matrix.xcframework
find . -name "*.swiftinterface" -exec sed -i -e 's/Matrix\.//g' {} \;

