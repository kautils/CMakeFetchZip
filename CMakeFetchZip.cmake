
macro(CMakeFetchZip)
    
    set(${PROJECT_NAME}_m_evacu ${m})
    set(m CMakeFetchZip)
    cmake_parse_arguments(${m} "CLEAN" "DESTINATION;SOURCE;WORKING_DIRECTORY" "" ${ARGV})
    list(APPEND ${m}_unsetter ${m}_DESTINATION ${m}_SOURCE ${m}_WORKING_DIRECTORY ${m}_CLEAN_WARKING_DIRECTORY )
    
    list(APPEND ${m}_unsetter ${m}_want_src ${m}_dest ${m}_download_dir ${m}_clean)
    set(${m}_want_src ${${m}_SOURCE})
    set(${m}_dest ${${m}_DESTINATION})
    set(${m}_clean ${${m}_CLEAN})
    
    if(DEFINED ${m}_WORKING_DIRECTORY AND (EXISTS ${${m}_WORKING_DIRECTORY}))
        set(${m}_download_dir "${${m}_WORKING_DIRECTORY}")
    else()
        set(${m}_download_dir "${CMAKE_BINARY_DIR}/CMakeFetchZip/download")
    endif()
    
    list(APPEND ${m}_unsetter ${m}_name ${m}_want)
    get_filename_component(${m}_name ${${m}_want_src} NAME)
    set(${m}_want "${${m}_download_dir}/${${m}_name}")
    file(MAKE_DIRECTORY "${${m}_dest}")
    if(NOT DEFINED KAUTIL_JDK_ROOT OR NOT EXISTS "${KAUTIL_JDK_ROOT}")
        if(${MINGW})
            if( (NOT DEFINED CACHE{${${m}_want}}))
                file(DOWNLOAD "${${m}_want_src}" "${${m}_want}")
                set(${${m}_want} TRUE CACHE STRING "")
            endif()
            
            if((NOT DEFINED CACHE{${${m}_dest}.${${m}_name}}) OR (NOT EXISTS "${${m}_dest}"))
                execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf "${${m}_want}" WORKING_DIRECTORY ${${m}_dest})
                set(${${m}_dest}.${${m}_name} TRUE CACHE STRING "")
            endif()
        endif()
    endif()
    
    if(${${m}_clean})
        message(${${m}_want})
        file(REMOVE_RECURSE "${${m}_want}")
    endif()
    
    foreach(__v ${${m}_unsetter})
        unset(${__v})
    endforeach()
    unset(${m}_unsetter)
    set(m ${${PROJECT_NAME}_m_evacu})
    
endmacro()
