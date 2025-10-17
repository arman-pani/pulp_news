# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Firebase rules
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Google Play Core rules (fixes missing classes error)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Hive rules
-keep class * extends com.hive.hive_flutter.HiveObject
-keep class * extends com.hive.hive_flutter.TypeAdapter

# Keep model classes
-keep class com.pulpnews.app.models.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep Parcelable classes
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Keep Serializable classes
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Additional rules for Flutter and third-party libraries
-keep class androidx.** { *; }
-dontwarn androidx.**
-keep class com.google.** { *; }
-dontwarn com.google.**

# Keep all classes that might be referenced by reflection
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep URL launcher classes
-keep class androidx.browser.** { *; }
-dontwarn androidx.browser.**

# Keep share plus classes
-keep class androidx.core.content.** { *; }
-dontwarn androidx.core.content.**

# Keep cached network image classes
-keep class com.bumptech.glide.** { *; }
-dontwarn com.bumptech.glide.**

# Keep intl classes
-keep class com.ibm.icu.** { *; }
-dontwarn com.ibm.icu.**