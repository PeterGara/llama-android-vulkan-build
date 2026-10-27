# Wrapper around the Android NDK toolchain.
#
# The NDK toolchain sets CMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY, so
# find_package(<X> CONFIG) only looks inside the NDK sysroot. The Vulkan
# backend requires SPIRV-Headers, which is a *host* CMake config package and
# is not present in the NDK sysroot. Switch PACKAGE mode to BOTH so host
# config packages are found, while LIBRARY/INCLUDE stay restricted to the
# NDK sysroot (so we still link the Android libvulkan, not the host one).

if(NOT DEFINED ENV{ANDROID_NDK})
  message(FATAL_ERROR "ANDROID_NDK environment variable is not set")
endif()

include($ENV{ANDROID_NDK}/build/cmake/android.toolchain.cmake)

set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)
