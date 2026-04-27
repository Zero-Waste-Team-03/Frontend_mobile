-keep class io.flutter.app.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }

-keep class org.maplibre.** { *; }
-keep class com.mapbox.** { *; }

-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

-keep class io.socket.** { *; }

-keepattributes Signature
-keepattributes RuntimeVisibleAnnotations
-keepattributes RuntimeVisibleParameterAnnotations
-keepattributes EnclosingMethod
-keepattributes InnerClasses