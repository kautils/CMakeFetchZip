### CMakeFetchZip
* download zip and extract it.

### example
```cmake
include(CMakeFetchZip.cmake)
CMakeFetchZip(
    SOURCE path_to_zip
    DESTINATION path_to_extract_dir
    WORKING_DIRECTORY path_to_donwload_dir
    CLEAN
)
```