import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // استخدم الأقواس بدل الاقتباس المفرد لأن هذا Kotlin DSL
        classpath("com.android.tools.build:gradle:8.6.0")
        // يمكنك إضافة باقي الكلاسباث حسب حاجتك هنا
        // classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.10")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ضبط مجلد البناء ليكون خارج المشروع (حسب رغبتك)
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

// تعريف مهمة clean
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
