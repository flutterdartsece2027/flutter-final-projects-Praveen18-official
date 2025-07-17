// Top-level build file with plugins configuration
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") version "4.4.2"
    id("com.google.firebase.crashlytics") version "2.9.9"
    id("com.google.firebase.firebase-perf") version "1.4.2"
    id("kotlin-kapt")
    id("dagger.hilt.android.plugin") version "2.50"
    id("com.google.devtools.ksp") version "1.9.22-1.0.16"
}

// Dependencies configuration
androidComponents {
    onVariants(selector().withBuildType("release")) {
        it.packaging.resources.excludes.apply {
            add("META-INF/AL2.0")
            add("META-INF/LGPL2.1")
            add("META-INF/*.kotlin_module")
            add("**/DebugProbesKt.bin")
            add("**/*.version")
            add("**/build-data.properties")
            add("**/*.proto")
            add("**/*.bin")
        }
    }
}

dependencies {
    // Core library desugaring for Java 8+ APIs
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    
    // Kotlin
    implementation(kotlin("stdlib-jdk8"))
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-play-services:1.7.3")
    
    // AndroidX Core
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("androidx.activity:activity-ktx:1.8.2")
    implementation("androidx.fragment:fragment-ktx:1.6.2")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.7.0")
    implementation("androidx.lifecycle:lifecycle-viewmodel-ktx:2.7.0")
    implementation("androidx.lifecycle:lifecycle-livedata-ktx:2.7.0")
    implementation("androidx.lifecycle:lifecycle-process:2.7.0")
    
    // UI Components
    implementation("com.google.android.material:material:1.11.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("androidx.recyclerview:recyclerview:1.3.2")
    implementation("androidx.viewpager2:viewpager2:1.0.0")
    implementation("androidx.swiperefreshlayout:swiperefreshlayout:1.1.0")
    
    // Firebase BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:33.1.0"))
    
    // Firebase Services
    implementation("com.google.firebase:firebase-analytics-ktx")
    implementation("com.google.firebase:firebase-auth-ktx")
    implementation("com.google.firebase:firebase-firestore-ktx")
    implementation("com.google.firebase:firebase-storage-ktx")
    implementation("com.google.firebase:firebase-messaging-ktx")
    implementation("com.google.firebase:firebase-crashlytics-ktx")
    implementation("com.google.firebase:firebase-perf-ktx")
    implementation("com.google.firebase:firebase-config-ktx")
    
    // Firebase UI
    implementation("com.firebaseui:firebase-ui-auth:8.0.2")
    implementation("com.firebaseui:firebase-ui-firestore:8.0.2")
    
    // Hilt for Dependency Injection
    implementation("com.google.dagger:hilt-android:2.50")
    kapt("com.google.dagger:hilt-android-compiler:2.50")
    
    // Image Loading
    implementation("io.coil-kt:coil:2.5.0")
    implementation("io.coil-kt:coil-svg:2.5.0")
    
    // Network
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")
    implementation("com.squareup.okhttp3:logging-interceptor:4.12.0")
    
    // Utils
    implementation("com.jakewharton.timber:timber:5.0.1")
    implementation("com.google.code.gson:gson:2.10.1")
    implementation("androidx.work:work-runtime-ktx:2.9.0")
    
    // Testing
    testImplementation("junit:junit:4.13.2")
    testImplementation("io.mockk:mockk:1.13.8")
    testImplementation("org.jetbrains.kotlinx:kotlinx-coroutines-test:1.7.3")
    testImplementation("androidx.arch.core:core-testing:2.2.0")
    
    androidTestImplementation("androidx.test:runner:1.5.2")
    androidTestImplementation("androidx.test:rules:1.5.0")
    androidTestImplementation("androidx.test.ext:junit:1.1.5")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
}
android {
    namespace = "com.agri.agrinova"
    compileSdk = 34
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.agri.agrinova"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
        multiDexEnabled = true
        vectorDrawables.useSupportLibrary = true
        testInstrumentationRunner = "com.agri.agrinova.HiltTestRunner"
        
        // Enable support for vector drawables
        vectorDrawables {
            useSupportLibrary = true
        }
        
        // Enable Java 8+ API desugaring support
        multiDexKeepProguard = file("multidex-config.pro")
        
        // Enable support for R8 full mode
        setProperty("android.enableR8.fullMode", true)
        
        // Enable core library desugaring
        isCoreLibraryDesugaringEnabled = true
    }

    compileOptions {
        // Flag to enable support for the new language APIs
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
        freeCompilerArgs += "-opt-in=kotlin.RequiresOptIn"
    }
    
    buildFeatures {
        viewBinding = true
        buildConfig = true
    }

    // Configure build types
    buildTypes {
        getByName("debug") {
            isDebuggable = true
            isMinifyEnabled = false
            isShrinkResources = false
            isTestCoverageEnabled = true
            
            // Enable Crashlytics for debug builds
            extra["enableCrashlytics"] = false
            extra["alwaysUpdateBuildId"] = false
            
            // Configure ProGuard
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        
        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = true
            isDebuggable = false
            isJniDebuggable = false
            isRenderscriptDebuggable = false
            isPseudoLocalesEnabled = false
            isZipAlignEnabled = true
            isCrunchPngs = true
            
            // Enable Crashlytics for release builds
            extra["enableCrashlytics"] = true
            extra["alwaysUpdateBuildId"] = true
            
            // Configure ProGuard
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            
            // Configure signing
            signingConfig = signingConfigs.getByName("debug") // Replace with your signing config
        }
        
        // Create a debug minified build type
        create("debugMinified") {
            initWith(getByName("debug"))
            isMinifyEnabled = true
            isShrinkResources = true
            matchingFallbacks += "debug"
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    
    // Configure build features
    buildFeatures {
        viewBinding = true
        buildConfig = true
        dataBinding = true
        compose = false
        aidl = false
        renderScript = false
        shaders = false
    }
    
    // Configure build variants
    flavorDimensions += "environment"
    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "AgriNova Dev")
            
            // Enable Crashlytics only for non-debug builds
            extra["enableCrashlytics"] = false
        }
        
        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
            resValue("string", "app_name", "AgriNova Staging")
        }
        
        create("production") {
            dimension = "environment"
            resValue("string", "app_name", "AgriNova")
        }
    }
    
    // Configure Java compilation
    compileOptions {
        // Flag to enable support for the new language APIs
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    // Configure Kotlin options
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
        freeCompilerArgs = freeCompilerArgs + listOf(
            "-opt-in=kotlin.RequiresOptIn",
            "-Xjvm-default=all",
            "-Xopt-in=kotlinx.coroutines.ExperimentalCoroutinesApi",
            "-Xopt-in=kotlinx.coroutines.FlowPreview"
        )
        languageVersion = "1.8"
        apiVersion = "1.8"
    }
    
    // Configure packaging options
    packagingOptions {
        resources.excludes.addAll(
            listOf(
                "META-INF/AL2.0",
                "META-INF/LGPL2.1",
                "META-INF/*.kotlin_module",
                "**/DebugProbesKt.bin",
                "**/*.version",
                "**/build-data.properties",
                "**/*.proto",
                "**/*.bin"
            )
        )
        jniLibs.useLegacyPackaging = false
        resources.pickFirsts.add("META-INF/LICENSE*")
        resources.pickFirsts.add("META-INF/AL2.0")
        resources.pickFirsts.add("META-INF/LGPL2.1")
    }
    
    // Configure test options
    testOptions {
        unitTests {
            isIncludeAndroidResources = true
            isReturnDefaultValues = true
            all {
                it.jvmArgs("-noverify")
                it.jvmArgs("--add-opens=java.base/java.lang=ALL-UNNAMED")
                it.jvmArgs("--add-opens=java.base/java.util=ALL-UNNAMED")
            }
        }
        animationsDisabled = true
        unitTests.all {
            it.useJUnitPlatform()
        }
    }
    
    // Configure lint options
    lint {
        abortOnError = true
        checkAllWarnings = true
        checkDependencies = true
        checkReleaseBuilds = false
        disable.add("InvalidPackage")
        isCheckDependencies = true
        isCheckGeneratedSources = true
        isCheckTestSources = true
        isExplainIssues = true
        isQuiet = false
        isWarningsAsErrors = true
        lintConfig = file("../lint.xml")
        textReport = true
        textOutput("stdout")
        xmlReport = true
        xmlOutput = file("build/reports/lint/lint-results.xml")
        htmlReport = true
        htmlOutput = file("build/reports/lint/lint-results.html")
    }
    
    // Configure build config fields
    defaultConfig {
        buildConfigField("String", "BUILD_TIME", "\"${System.currentTimeMillis()}\"")
        buildConfigField("String", "GIT_SHA", "\"${getGitSha()}\"")
        buildConfigField("String", "GIT_BRANCH", "\"${getGitBranch()}\"")
    }
    
    // Configure source sets
    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
            res.srcDirs("src/main/res")
            assets.srcDirs("src/main/assets")
        }
        getByName("test") {
            java.srcDirs("src/test/kotlin")
            resources.srcDirs("src/test/resources")
        }
        getByName("androidTest") {
            java.srcDirs("src/androidTest/kotlin")
            assets.srcDirs("src/androidTest/assets")
        }
    }
    
    // Configure external native build
    externalNativeBuild {
        cmake {
            path = file("src/main/cpp/CMakeLists.txt")
            version = "3.22.1"
        }
    }
    
    // Configure bundle
    bundle {
        language {
            // Enable language split for APKs
            enableSplit = true
        }
        density {
            // Enable density split for APKs
            enableSplit = true
        }
        abi {
            // Enable ABI split for APKs
            enableSplit = true
        }
    }
    
    // Configure splits
    splits {
        abi {
            isEnable = true
            reset()
            include("armeabi-v7a", "arm64-v8a", "x86", "x86_64")
            isUniversalApk = true
        }
    }
    
    // Fix for duplicate classes error
    packagingOptions {
        resources.excludes.add("META-INF/*.kotlin_module")
        resources.excludes.add("META-INF/AL2.0")
        resources.excludes.add("META-INF/LGPL2.1")
    }

    defaultConfig {
        applicationId = "com.agri.agrinova"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    defaultConfig {
        applicationId = "com.agri.agrinova"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}



flutter {
    source = "../.."
}

dependencies {
  // Import the Firebase BoM
  implementation(platform("com.google.firebase:firebase-bom:33.16.0"))

}