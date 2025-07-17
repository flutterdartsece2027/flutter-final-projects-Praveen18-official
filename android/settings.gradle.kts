// Configure plugin management at the beginning of the file
pluginManagement {
    // Get Flutter SDK path from local.properties
    val flutterSdkPath = run {
        val properties = java.util.Properties().apply {
            file("local.properties").inputStream().use { load(it) }
        }
        properties.getProperty("flutter.sdk") ?: 
            throw GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
    }

    // Include Flutter's Gradle plugin
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    // Configure repositories for plugin management
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        maven { url = uri("https://storage.googleapis.com/download.flutter.io") }
    }
    
    // Configure resolution strategy for plugins
    resolutionStrategy {
        eachPlugin {
            // Handle Kotlin plugin version
            if (requested.id.namespace == "org.jetbrains.kotlin") {
                useVersion("1.9.22") // Match Kotlin version with build.gradle.kts
            }
            // Handle Android Gradle Plugin version
            if (requested.id.namespace == "com.android" || requested.id.name == "com.android.application") {
                useModule("com.android.tools.build:gradle:${requested.version}")
            }
        }
    }
}

// Configure dependency resolution for all projects
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://storage.googleapis.com/download.flutter.io") }
        maven { url = uri("https://www.jitpack.io") }
    }
    
    // Enable version catalogs (if needed in the future)
    // versionCatalogs {
    //     create("libs") {
    //         from(files("../gradle/libs.versions.toml"))
    //     }
    // }
}

// Configure build cache
buildCache {
    // Use local build cache
    local {
        directory = File(rootDir, "build-cache")
        removeUnusedEntriesAfterDays = 30
    }
}

// Apply common plugins and configurations
plugins {
    // Flutter plugin loader
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    
    // Android application plugin
    id("com.android.application") version "8.2.2" apply false
    
    // Kotlin Android plugin
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false
    
    // Google Services plugin
    id("com.google.gms.google-services") version "4.4.2" apply false
    
    // Firebase Crashlytics Gradle plugin
    id("com.google.firebase.crashlytics") version "2.9.9" apply false
    
    // Firebase Performance Monitoring plugin
    id("com.google.firebase.firebase-perf") version "1.4.2" apply false
}

// Include the app module
include(":app")

// Configure all projects
gradle.projectsLoaded {
    rootProject.allprojects {
        // Common configurations for all projects
        repositories {
            google()
            mavenCentral()
            maven { url = uri("https://storage.googleapis.com/download.flutter.io") }
            maven { url = uri("https://www.jitpack.io") }
        }
        
        // Configure all projects to use the same build directory
        buildDir = File(rootDir, "build/${project.name}")
    }
}
