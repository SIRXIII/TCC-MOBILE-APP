# Prevent R8 from removing Stripe Push Provisioning classes
-keep class com.stripe.android.pushProvisioning.** { *; }
-dontwarn com.stripe.android.pushProvisioning.**
# SLF4J
-keep class org.slf4j.** { *; }
-dontwarn org.slf4j.**