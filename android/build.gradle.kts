allprojects {
    repositories {
        google()
        mavenCentral()
        // kakao_map_view 플러그인이 쓰는 카카오맵 SDK 저장소. 앱이 최종 의존성을 내려받으므로 여기에도 필요하다.
        maven("https://devrepo.kakao.com/nexus/repository/kakaomap-releases/")
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
