# Google Mobile Ads starts WorkManager at launch. WorkManager's Room database
# is created by reflection, so the release shrinker (R8) must keep the
# generated implementation classes, or the app crashes on start with
# "Failed to create an instance of androidx.work.impl.WorkDatabase".
-keep class * extends androidx.room.RoomDatabase { <init>(); }
-keep class androidx.work.impl.WorkDatabase_Impl { *; }
-keep class androidx.work.** { *; }
-dontwarn androidx.work.**
