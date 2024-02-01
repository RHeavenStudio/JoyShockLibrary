if (APPLE)
	enable_language (C)

    set (MAC ON)
    set_property (GLOBAL PROPERTY USE_FOLDERS ON)

    include (cmake/CPM.cmake)
    
    add_library (
        jsl_platform_dependencies INTERFACE
    )

    CPMAddPackage (
        NAME hidapi
        GITHUB_REPOSITORY libusb/hidapi
        VERSION 0.14.0
        GIT_TAG d3013f0af3f4029d82872c1a9487ea461a56dee4
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
