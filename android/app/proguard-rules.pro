# ML Kit ProGuard rules to prevent R8 from stripping language-specific recognizers
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.internal.mlkit_vision_text_common.** { *; }
-keep class com.google.android.gms.internal.mlkit_vision_text_chinese.** { *; }
-keep class com.google.android.gms.internal.mlkit_vision_text_devanagari.** { *; }
-keep class com.google.android.gms.internal.mlkit_vision_text_japanese.** { *; }
-keep class com.google.android.gms.internal.mlkit_vision_text_korean.** { *; }

# General ML Kit keep rules
-keep class com.google.android.gms.vision.** { *; }
-keep class com.google.android.libraries.barhopper.** { *; }
-keep class com.google.android.libraries.intelligence.** { *; }

# Suppress warnings for missing ML Kit language-specific recognizers (Chinese, Devanagari, Japanese, Korean)
# These are referenced by the core library but not necessarily included if only using standard Latin recognition.
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**
