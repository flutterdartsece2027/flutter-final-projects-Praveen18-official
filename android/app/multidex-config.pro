# Keep application class and its direct dependencies
-keep public class com.agri.agrinova.Application { *; }
-keep public class com.agri.agrinova.MainActivity { *; }

# Keep Flutter initialization
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Firebase classes
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Keep Hilt
-keep class dagger.hilt.** { *; }
-keep class * extends dagger.hilt.android.Hilt_* { *; }
-keep @dagger.hilt.android.AndroidEntryPoint class * { *; }

# Keep ViewModels
-keepclassmembers class * extends androidx.lifecycle.ViewModel {
    <init>(...);
}

# Keep annotated methods in Activities and Fragments
-keepclassmembers class * extends androidx.fragment.app.Fragment {
    @androidx.lifecycle.ViewModelInject <init>();
    @dagger.hilt.android.AndroidEntryPoint <init>();
}

-keepclassmembers class * extends android.app.Activity {
    @androidx.lifecycle.ViewModelInject <init>();
    @dagger.hilt.android.AndroidEntryPoint <init>();
}

# Keep Parcelables
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Keep Serializable classes
-keepnames class * implements java.io.Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep Retrofit interfaces
-keepattributes Signature
-keepattributes *Annotation*
-keep class retrofit2.** { *; }
-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}

# Keep OkHttp
-keepattributes Signature
-keepattributes *Annotation*
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**

# Keep Coroutines
-keepclassmembernames class kotlinx.** {
    volatile <fields>;
}

# Keep Glide
-keep public class * implements com.bumptech.glide.module.AppGlideModule
-keep class * extends com.bumptech.glide.module.AppGlideModule {
    <init>();
}
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
    **[] $VALUES;
    public *;
}

# Keep WorkManager
-keep class androidx.work.** { *; }
-keep class * implements androidx.work.Worker
-keep class * extends androidx.work.Worker
-keepclassmembers class * extends androidx.work.Worker {
    <init>(...);
}

# Keep Room
-keep class * extends androidx.room.RoomDatabase
-keep class * extends androidx.room.Entity
-keep class * {
    @androidx.room.* <methods>;
}
-keepclassmembers class * {
    @androidx.room.* <fields>;
}
-keepclassmembers class * {
    @androidx.room.* <methods>;
}

# Keep ViewBinding
-keepclassmembers class * {
    @butterknife.BindView *;
    @butterknife.BindViews *;
    @butterknife.BindBitmap *;
    @butterknife.BindBool *;
    @butterknife.BindDimen *;
    @butterknife.BindDrawable *;
    @butterknife.BindInt *;
    @butterknife.BindString *;
    @butterknife.BindView *;
    @butterknife.BindViews *;
    @butterknife.Optional *;
    @butterknife.BindColor *;
    @butterknife.BindDimen *;
    @butterknife.BindDrawable *;
    @butterknife.BindInt *;
    @butterknife.BindString *;
}

# Keep Kotlin metadata
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Keep Gson
-keep class com.google.gson.** { *; }
-keep class com.google.gson.stream.** { *; }
-keep class com.google.gson.annotations.** { *; }
-keep class com.google.gson.reflect.** { *; }
-keep class com.google.gson.internal.** { *; }
-keep class com.google.gson.internal.bind.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep Timber
-keep class timber.log.Timber { *; }
-keep class timber.log.Timber$* { *; }
-keep class timber.log.Timber$Tree { *; }
-keep class timber.log.Timber$DebugTree { *; }

# Keep Kotlin coroutines
-keepclassmembernames class kotlinx.** {
    volatile <fields>;
}

# Keep Kotlin reflection
-keep class kotlin.Metadata { *; }
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Keep BuildConfig
-keep class com.agri.agrinova.BuildConfig { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep custom views
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
}

# Keep onClick handlers
-keepclassmembers class * extends android.app.Activity {
    public void *(android.view.View);
}

# Keep menu bindings
-keepclassmembers class * {
    @android.view.MenuRes <fields>;
}

# Keep custom views with custom constructors
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

# Keep the special static methods that are required in all enumeration classes.
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep RPC framework methods.
-keepclassmembers class * {
    @com.google.gwt.user.client.rpc.* <methods>;
}

# Keep Parcelable classes required by the Android framework.
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Keep Serializable classes that are serialized with Gson.
-keep class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep the custom Parcelable classes that are used as return types of the service interface methods.
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Keep the service interface methods in the .service package.
-keepclassmembers class * {
    @com.google.gwt.user.client.rpc.* <methods>;
}

# Keep the R classes that are used as return types of the service interface methods.
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Keep the source file names, line numbers, and method names for debugging.
-keepattributes SourceFile,LineNumberTable,EnclosingMethod

# Keep the annotations that are used by the GWT compiler.
-keepattributes *Annotation*

# Keep the custom serializers that are used by the GWT compiler.
-keepclassmembers class * {
    @com.google.gwt.user.client.rpc.* <methods>;
}

# Keep the service interfaces.
-keep public interface * extends java.rmi.Remote {
    public <methods>;
}

# Keep the service implementation classes.
-keep class * implements java.rmi.Remote {
    <init>(...);
}

# Keep the RPC serialization classes.
-keep class com.google.gwt.user.client.rpc.** { *; }

# Keep the GWT module classes.
-keep class * extends com.google.gwt.core.client.EntryPoint { *; }

# Keep the GWT JRE emulation classes.
-keep class com.google.gwt.core.client.JavaScriptObject { *; }

# Keep the GWT JSNI methods.
-keepclassmembers class * {
    @com.google.gwt.core.client.JavaScriptInterface <methods>;
}

# Keep the GWT JSNI methods that are used for JNI.
-keepclassmembers class * {
    @com.google.gwt.core.client.JsMethod <methods>;
}

# Keep the GWT JSNI methods that are used for JSOs.
-keepclassmembers class * {
    @com.google.gwt.core.client.JsType <methods>;
}

# Keep the GWT JSNI methods that are used for JsInterop.
-keepclassmembers class * {
    @jsinterop.annotations.JsMethod <methods>;
    @jsinterop.annotations.JsProperty <methods>;
    @jsinterop.annotations.JsType <methods>;
}

# Keep the GWT JSNI methods that are used for JsInterop exports.
-keepclassmembers class * {
    @jsinterop.annotations.JsOverlay <methods>;
    @jsinterop.annotations.JsPackage <methods>;
}

# Keep the GWT JSNI methods that are used for JsInterop imports.
-keepclassmembers class * {
    @jsinterop.annotations.JsIgnore <methods>;
    @jsinterop.annotations.JsIgnoreType <methods>;
}

# Keep the GWT JSNI methods that are used for JsInterop packages.
-keepclassmembers class * {
    @jsinterop.annotations.JsPackage <fields>;
}

# Keep the GWT JSNI methods that are used for JsInterop types.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <methods>;
}

# Keep the GWT JSNI methods that are used for JsInterop constructors.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <init>(...);
}

# Keep the GWT JSNI methods that are used for JsInterop properties.
-keepclassmembers @jsinterop.annotations.JsType class * {
    *;
}

# Keep the GWT JSNI methods that are used for JsInterop namespaces.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <fields>;
}

# Keep the GWT JSNI methods that are used for JsInterop callbacks.
-keepclassmembers @jsinterop.annotations.JsFunction interface * {
    *;
}

# Keep the GWT JSNI methods that are used for JsInterop constructors.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <init>();
}

# Keep the GWT JSNI methods that are used for JsInterop constructors with parameters.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <init>(...);
}

# Keep the GWT JSNI methods that are used for JsInterop static methods.
-keepclassmembers @jsinterop.annotations.JsType class * {
    static <methods>;
}

# Keep the GWT JSNI methods that are used for JsInterop instance methods.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <methods>;
}

# Keep the GWT JSNI methods that are used for JsInterop static fields.
-keepclassmembers @jsinterop.annotations.JsType class * {
    static <fields>;
}

# Keep the GWT JSNI methods that are used for JsInterop instance fields.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <fields>;
}

# Keep the GWT JSNI methods that are used for JsInterop constructors with parameters.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <init>(...);
}

# Keep the GWT JSNI methods that are used for JsInterop constructors.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <init>();
}

# Keep the GWT JSNI methods that are used for JsInterop constructors with parameters.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <init>(...);
}

# Keep the GWT JSNI methods that are used for JsInterop constructors.
-keepclassmembers @jsinterop.annotations.JsType class * {
    <init>();
}
