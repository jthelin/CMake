set(CMAKE_EXPERIMENTAL_CXX_MODULE_CMAKE_API "a816ed09-43d1-40e5-bc8c-1a2824ee194e")

if (NOT EXISTS "${CMake_TEST_MODULE_COMPILATION_RULES}")
  message(FATAL_ERROR
    "The `CMake_TEST_MODULE_COMPILATION_RULES` file must be specified "
    "for these tests to operate.")
endif ()

include("${CMake_TEST_MODULE_COMPILATION_RULES}")

if (NOT CMake_TEST_CXXModules_UUID STREQUAL "a246741c-d067-4019-a8fb-3d16b0c9d1d3")
  message(FATAL_ERROR
    "The compilation rule file needs updated for changes in the test "
    "suite. Please see the history for what needs to be updated.")
endif ()

include(CTest)
enable_testing()
