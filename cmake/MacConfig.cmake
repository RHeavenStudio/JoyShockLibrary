if (APPLE)
	enable_language (C)

    set (MAC ON)
    set_property (GLOBAL PROPERTY USE_FOLDERS ON)

    include (cmake/CPM.cmake)

    if (MSVC)
        # Statically link the runtime libraries
		#set (CMAKE_C_FLAGS "/DWIN32 /D_WINDOWS /W3")
		#set (CMAKE_C_FLAGS_DEBUG "/MTd /Zi /Ob0 /Od /RTC1")
		#set (CMAKE_C_FLAGS_RELEASE "/MT /O2 /Ob2 /DNDEBUG")

        set (
            MSVC_COMPILE_FLAGS
            CMAKE_CXX_FLAGS
            CMAKE_CXX_FLAGS_DEBUG
            CMAKE_CXX_FLAGS_RELEASE
            CMAKE_C_FLAGS
            CMAKE_C_FLAGS_DEBUG
            CMAKE_C_FLAGS_RELEASE
        )
        foreach (FLAG ${MSVC_COMPILE_FLAGS})
            string (REPLACE "/MD" "/MT" ${FLAG} "${${FLAG}}")
        endforeach ()
    endif ()

    add_library (
        jsl_platform_dependencies INTERFACE
    )

    CPMAddPackage (
        NAME hidapi
        GITHUB_REPOSITORY signal11/hidapi
        VERSION 0
        GIT_TAG a6a622ffb680c55da0de787ff93b80280498330f
        DOWNLOAD_ONLY YES
    )

    if (hidapi_ADDED)
        add_library (
            hidapi STATIC
            ${hidapi_SOURCE_DIR}/mac/hid.c
        )

        target_include_directories (
            hidapi PUBLIC
            $<BUILD_INTERFACE:${hidapi_SOURCE_DIR}/hidapi>
        )

        target_link_libraries (
            hidapi PUBLIC
	    PRIVATE "-framework IOKit" "-framework CoreFoundation" "-framework AppKit"
        )
    endif()

    target_link_libraries (
        jsl_platform_dependencies INTERFACE
        hidapi
    )

    add_library (JSL_Platform::Dependencies ALIAS jsl_platform_dependencies)
endif ()
