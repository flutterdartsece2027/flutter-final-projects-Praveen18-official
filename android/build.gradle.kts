import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

// Top-level build file where you can add configuration options common to all sub-projects/modules.
buildscript {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
    
    dependencies {
        // Keep this version in sync with the FlutterFire setup
        classpath("com.android.tools.build:gradle:8.2.2")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.22")
        classpath("com.google.gms:google-services:4.4.2")
        classpath("com.google.firebase:firebase-crashlytics-gradle:2.9.9")
        classpath("com.google.firebase:perf-plugin:1.4.2")
        
        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}

// Configure all projects with common settings
allprojects {
    // Configure all projects to use the same build directory structure
    buildDir = File("${rootProject.buildDir}/${project.name}")
    
    // Common repositories for all projects
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://maven.google.com") }
        maven { url = uri("https://www.jitpack.io") }
    }
    
    // Common configurations for Java and Kotlin compilation
    tasks.withType<JavaCompile> {
        options.encoding = "UTF-8"
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        options.isDeprecation = true
        options.isWarnings = true
        options.compilerArgs.addAll(listOf("-Xlint:unchecked", "-Xlint:deprecation"))
    }

    tasks.withType<KotlinCompile> {
        kotlinOptions {
            jvmTarget = "11"
            freeCompilerArgs = listOf(
                "-Xjvm-default=all",
                "-Xopt-in=kotlin.RequiresOptIn",
                "-Xopt-in=kotlinx.coroutines.ExperimentalCoroutinesApi",
                "-Xopt-in=kotlinx.coroutines.FlowPreview"
            )
            languageVersion = "1.8"
            apiVersion = "1.8"
        }
    }
    
    // Configure all projects to use the same build directory
    afterEvaluate {
        tasks.withType<AbstractArchiveTask> {
            // Ensure consistent archive naming
            archiveBaseName.set(project.name)
            archiveVersion.set(project.version.toString())
        }
    }
}

// Configure subprojects
subprojects {
    // Apply common plugins
    plugins.withId("com.android.application") {
        configure<com.android.build.gradle.internal.dsl.BaseAppModuleExtension> {
            // Common Android configurations for application modules
            buildToolsVersion = "34.0.0"
            
            defaultConfig {
                minSdk = 21
                targetSdk = 34
                versionCode = 1
                versionName = "1.0.0"
                
                testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
                vectorDrawables.useSupportLibrary = true
                
                // Enable multi-dex support
                multiDexEnabled = true
            }
            
            buildTypes {
                getByName("debug") {
                    isMinifyEnabled = false
                    isDebuggable = true
                    proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
                }
                
                getByName("release") {
                    isMinifyEnabled = true
                    isShrinkResources = true
                    proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
                }
            }
            
            compileOptions {
                sourceCompatibility = JavaVersion.VERSION_11
                targetCompatibility = JavaVersion.VERSION_11
                isCoreLibraryDesugaringEnabled = true
            }
            
            buildFeatures {
                viewBinding = true
                buildConfig = true
            }
            
            packagingOptions {
                resources.excludes.add("META-INF/*.kotlin_module")
                resources.excludes.add("META-INF/AL2.0")
                resources.excludes.add("META-INF/LGPL2.1")
            }
        }
    }
}

// Clean task to remove all build directories
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
