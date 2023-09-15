### CMakeFetchZip
* download zip and extract it.

### note
* SOURCE : uri to zip to download
* DESTINATION : destination dir to where contents expand
* WORKING_DIRECTORY : download directory for zip
* FORCE_EXTRACT : force to extract 
* FORCE_UPDATE : force to download and extract 

### example
```cmake
include(CMakeFetchZip.cmake)
CMakeFetchZip(
    SOURCE path_to_zip
    DESTINATION path_to_extract_dir
    WORKING_DIRECTORY path_to_donwload_dir
    #FORCE_EXTRACT
    #FORCE_UPDATE 
)
```