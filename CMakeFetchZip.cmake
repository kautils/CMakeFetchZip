
macro(CMakeFetchZip)
    
    
    
    set(${PROJECT_NAME}_m_evacu ${m})
    set(m CMakeFetchZip)
    cmake_parse_arguments(${m} "FORCE_UPDATE;FORCE_EXTRACT" "DESTINATION;SOURCE;WORKING_DIRECTORY" "" ${ARGV})
    list(APPEND ${m}_unsetter ${m}_DESTINATION ${m}_SOURCE ${m}_WORKING_DIRECTORY ${m}_CLEAN_WARKING_DIRECTORY ${m}_FORCE_UPDATE ${m}_FORCE_EXTRACT)
    
    list(APPEND ${m}_unsetter ${m}_want_src ${m}_dest ${m}_download_dir ${m}_clean)
    set(${m}_want_src ${${m}_SOURCE})
    set(${m}_clean ${${m}_CLEAN})
    set(${m}_force ${${m}_FORCE_UPDATE})
    set(${m}_force_extract ${${m}_FORCE_EXTRACT})
    
    if(DEFINED ${m}_DESTINATION)
        set(${m}_dest ${${m}_DESTINATION})
    else()
        set(${m}_dest ${CMAKE_BINARY_DIR}/CMakeFetchZip/extract)
    endif()
    
    
    if(DEFINED ${m}_WORKING_DIRECTORY AND (EXISTS ${${m}_WORKING_DIRECTORY}))
        set(${m}_download_dir "${${m}_WORKING_DIRECTORY}")
    else()
        set(${m}_download_dir "${CMAKE_BINARY_DIR}/CMakeFetchZip/download")
    endif()
    
    list(APPEND ${m}_unsetter ${m}_name ${m}_want)
    get_filename_component(${m}_name ${${m}_want_src} NAME)
    set(${m}_want "${${m}_download_dir}/${${m}_name}")
    file(MAKE_DIRECTORY "${${m}_dest}")
    
    if(${${m}_force})
        unset(${${m}_want} CACHE)
        unset(${${m}_dest}.${${m}_name} CACHE)
    endif()
    
    if(${${m}_force_extract})
        unset(${${m}_dest}.${${m}_name} CACHE)
    endif()
    
        
    if( (NOT DEFINED CACHE{${${m}_want}}) OR NOT EXISTS "${${m}_want}")
        file(DOWNLOAD "${${m}_want_src}" "${${m}_want}")
        set(${${m}_want} TRUE CACHE STRING "")
    endif()
    
    if(NOT DEFINED CACHE{${${m}_dest}.${${m}_name}})
        execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf "${${m}_want}" WORKING_DIRECTORY ${${m}_dest})
        set(${${m}_dest}.${${m}_name} TRUE CACHE STRING "")
    endif()
    
    foreach(__v ${${m}_unsetter})
        unset(${__v})
    endforeach()
    unset(${m}_unsetter)
    set(m ${${PROJECT_NAME}_m_evacu})
    
endmacro()
