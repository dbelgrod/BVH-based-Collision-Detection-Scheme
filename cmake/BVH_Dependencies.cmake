# Download and update 3rd_party libraries
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
list(REMOVE_DUPLICATES CMAKE_MODULE_PATH)
include(BVH_DownloadExternal)

# JSON
if(NOT TARGET assimp)
 bvh_download_assimp()
 add_subdirectory(${BVH_EXTERNAL}/assimp) 
endif()

if(NOT TARGET gProximity)
 bvh_download_gproximity()
 include_directories(${BVH_EXTERNAL}/gProximity)
endif()