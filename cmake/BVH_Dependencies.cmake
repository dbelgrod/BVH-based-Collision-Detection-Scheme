# Download and update 3rd_party libraries
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
list(REMOVE_DUPLICATES CMAKE_MODULE_PATH)
include(BVH_DownloadExternal)

# JSON
if(NOT TARGET assimp)
 bvh_download_assimp()
#  set(SYSTEM_IRRXML ON)
 add_subdirectory(${BVH_EXTERNAL}/assimp)
 include_directories(${BVH_BUILD_EXTERNAL}/assimp) 
 include_directories(${BVH_BUILD_EXTERNAL}/assimp/code) 
endif()

if(NOT TARGET gProximity)
 bvh_download_gproximity()
 include_directories(${BVH_EXTERNAL}/gproximity)
endif()

if(NOT TARGET irrXML)
 bvh_download_irrXML()
#  set(SYSTEM_IRRXML ON)
 add_subdirectory(${BVH_EXTERNAL}/irrXML)
 include_directories(${BVH_EXTERNAL}/irrXML/src) 
endif()