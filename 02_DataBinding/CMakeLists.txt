cmake_minimum_required(VERSION 3.16)

project(curl_demo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(QT_VERSION_MAJOR 6)

find_package(CURL REQUIRED)
find_package(QT NAMES Qt6 COMPONENTS Core Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED)

set(PROJECT_SOURCES
        main.cpp
        curlhelper.h
        curlhelper.cpp
        qml.qrc
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(curl_downloader
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
endif()

target_compile_definitions(curl_downloader
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(curl_downloader PRIVATE
  Qt${QT_VERSION_MAJOR}::Core
  Qt${QT_VERSION_MAJOR}::Quick
  CURL::libcurl
  )

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(curl_downloader)
    qt_finalize_executable(curl_downloader)
endif()
