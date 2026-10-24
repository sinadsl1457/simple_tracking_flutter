import groovy.json.JsonSlurper
import java.util.Base64

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Android Studio의 ▶(app)는 flutter 도구를 거치지 않고 Gradle을 직접 불러서 --dart-define-from-file이 붙지 않는다.
// 그럴 때만 env/dev.json을 읽어 flutter 도구와 같은 형식(base64("KEY=VALUE")를 쉼표로 이음)의 dart-defines로 넘긴다.
// flutter run / VS Code는 -Pdart-defines를 직접 넘기므로 이 블록은 아무 일도 하지 않는다. 키는 파일에서 읽기만 한다.
if (!project.hasProperty("dart-defines")) {
    val envFile = rootProject.file("../env/dev.json")
    if (envFile.exists()) {
        @Suppress("UNCHECKED_CAST")
        val env = JsonSlurper().parse(envFile) as Map<String, Any?>
        project.extra["dart-defines"] = env.entries.joinToString(",") { (key, value) ->
            Base64.getEncoder().encodeToString("$key=$value".toByteArray())
        }
    }
}

android {
    namespace = "com.sintaek.simple_tracking"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.sintaek.simple_tracking"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
