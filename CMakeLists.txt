cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
# set(CMAKE_CUDA_COMPILER "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v10.1\\bin")
project(BVH LANGUAGES CXX CUDA)
set(CMAKE_CXX_STANDARD 17)

find_package(CUDA  REQUIRED)
include_directories("${CUDA_INCLUDE_DIRS}")

set(DEPENDENCIES "${PROJECT_SOURCE_DIR}/Source/Project/Mine" )
# include_directories("C:/ProgramData/NVIDIA Corporation/CUDA Samples/v10.1/common/inc")
set (SAMPLE_HEADERS "/usr/local/cuda/samples/common/inc")

include_directories(${DEPENDENCIES} ${SAMPLE_HEADERS})

set(BVH_EXTERNAL "${CMAKE_CURRENT_SOURCE_DIR}/external")
set(BVH_BUILD_EXTERNAL "${CMAKE_CURRENT_BINARY_DIR}/external")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(Warnings)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  set(BVH_TOPLEVEL_PROJECT ON)
else()
  set(BVH_TOPLEVEL_PROJECT OFF)
endif()

include(${PROJECT_NAME}_Dependencies)


file(GLOB SRC_MAIN
       ${PROJECT_SOURCE_DIR}/*.cpp
       ${PROJECT_SOURCE_DIR}/Source/*.cpp
       ${PROJECT_SOURCE_DIR}/*.cu
       ${PROJECT_SOURCE_DIR}/Source/*.cu
       ${PROJECT_SOURCE_DIR}/*.h
       ${PROJECT_SOURCE_DIR}/Source/*.h
       ${PROJECT_SOURCE_DIR}/*.cuh
       ${PROJECT_SOURCE_DIR}/Source/*.cuh)

file(GLOB_RECURSE SRC_NESTED
       ${PROJECT_SOURCE_DIR}/*.cpp
       ${PROJECT_SOURCE_DIR}/Source/*.cpp
       ${PROJECT_SOURCE_DIR}/*.cu
       ${PROJECT_SOURCE_DIR}/Source/*.cu
       ${PROJECT_SOURCE_DIR}/*.h
       ${PROJECT_SOURCE_DIR}/Source/*.h
       ${PROJECT_SOURCE_DIR}/*.cuh
       ${PROJECT_SOURCE_DIR}/Source/*.cuh)   

set(SRC ${SRC_MAIN} ${SRC_NESTED})

add_library( ${PROJECT_NAME} STATIC ${SRC})


set_target_properties( ${PROJECT_NAME}
                       PROPERTIES CUDA_SEPARABLE_COMPILATION ON
                      )
                      
# Nvidia RTX8000 -> compute_75
# Nvidia V100 -> compute_70
# Nvidia 1080/1080Ti -> compute_61                 
set_property(TARGET ${PROJECT_NAME} PROPERTY CUDA_ARCHITECTURES 61 70 75)

target_compile_definitions(${PROJECT_NAME} PUBLIC USE_EPSILON_TEST=FALSE)
add_definitions(-DUSE_EPSILON_TEST=FALSE -DEPSILON=0 -DASSIMP_BUILD_NO_C4D_IMPORTER)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive ")
# set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -fpermissive")

# To have add_subdirectory take effect, need to link targets assimp -> B
target_link_libraries(${PROJECT_NAME} assimp)