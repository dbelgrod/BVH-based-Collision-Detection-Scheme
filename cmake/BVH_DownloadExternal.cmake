
include(DownloadProject)
include(FetchContent)

if(NOT (${CMAKE_VERSION} VERSION_LESS "3.8.0"))
set(BVH_EXTRA_OPTIONS "GIT_CONFIG advice.detachedHead=false")
else()
set(BVH_EXTRA_OPTIONS "")
endif()

function(bvh_download_project name)
download_project(
    PROJ         ${name}
    SOURCE_DIR   ${BVH_EXTERNAL}/${name}
    DOWNLOAD_DIR ${BVH_EXTERNAL}/.cache/${name}
    QUIET
    ${BVH_EXTRA_OPTIONS}
    ${ARGN}
)
endfunction()

function(bvh_download_assimp)
bvh_download_project(assimp
GIT_REPOSITORY https://github.com/assimp/assimp.git
GIT_TAG        v5.0.1
)
endfunction()

function(bvh_download_gproximity)
FetchContent_Declare(gproximity
GIT_REPOSITORY https://github.com/robert-schmidtke/gProximity.git
GIT_TAG        master
)
endfunction()