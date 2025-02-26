cmake_minimum_required(VERSION 3.24)
project(cxx_modules_library NONE)

set(CMAKE_EXPERIMENTAL_CXX_MODULE_CMAKE_API "a816ed09-43d1-40e5-bc8c-1a2824ee194e")

find_package(export_interfaces REQUIRED)

if (NOT TARGET CXXModules::export_interfaces)
  message(FATAL_ERROR
    "Missing imported target")
endif ()

get_property(file_sets TARGET CXXModules::export_interfaces
  PROPERTY INTERFACE_CXX_MODULE_SETS)
if (NOT file_sets STREQUAL "modules")
  message(FATAL_ERROR
    "Incorrect exported file sets in CXXModules::export_interfaces:\n  ${file_sets}")
endif ()

get_property(file_set_files TARGET CXXModules::export_interfaces
  PROPERTY CXX_MODULE_SET_modules)
set(expected_file_set_files
  "${expected_source_dir}/importable.cxx"
  "${expected_source_dir}/subdir/importable.cxx"
  )
if (NOT file_set_files STREQUAL "${expected_file_set_files}")
  message(FATAL_ERROR
    "Incorrect exported file set paths in CXXModules::export_interfaces:\n  ${file_set_files}")
endif ()

get_property(imported_modules TARGET CXXModules::export_interfaces
  PROPERTY IMPORTED_CXX_MODULES_DEBUG)
set(expected_imported_modules
  "importable=${expected_source_dir}/importable.cxx,${expected_binary_dir}/CMakeFiles/export_interfaces.dir(/Debug)?/importable.(gcm|pcm|ifc)"
  "subdir_importable=${expected_source_dir}/subdir/importable.cxx,${expected_binary_dir}/CMakeFiles/export_interfaces.dir(/Debug)?/subdir_importable.(gcm|pcm|ifc)"
  )
if (NOT imported_modules MATCHES "^${expected_imported_modules}$")
  message(FATAL_ERROR
    "Incorrect exported modules in CXXModules::export_interfaces:\n"
    "  ${imported_modules}\n"
    "does not match:\n"
    "  ${expected_imported_modules}"
  )
endif ()
