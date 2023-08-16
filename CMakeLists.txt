cmake_minimum_required (VERSION 3.12)
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.12" CACHE STRING "Minimum OS X deployment version" FORCE)
set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
set(CMAKE_CXX_STANDARD 17)

project ("JoyShockLibrary" CXX)

set(CMAKE_CXX_STANDARD 17)

include (cmake/LinuxConfig.cmake)
include (cmake/WindowsConfig.cmake)
include (cmake/MacConfig.cmake)

if (BUILD_SHARED_LIBS)
    set (JSL_PLATFORM_DEPENDENCY_VISIBILITY PRIVATE)
else ()
    set (JSL_PLATFORM_DEPENDENCY_VISIBILITY PUBLIC)
endif ()

add_subdirectory (JoyShockLibrary)
