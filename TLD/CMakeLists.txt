cmake_minimum_required(VERSION 2.8.3)
project(ros_tld)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_BUILD_TYPE "Release")
##set(CMAKE_BUILD_TYPE "Debug")

find_package(OpenCV 3.4.2 REQUIRED)
MESSAGE("OPENCV PATH: ${OpenCV_INCLUDE_DIRS}")

find_package(catkin REQUIRED)
find_package(catkin REQUIRED COMPONENTS 
                    roscpp
                    cv_bridge
                    image_transport
                    sensor_msgs
                    std_msgs
                    message_generation
            )



include_directories(
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/src
    ${PROJECT_SOURCE_DIR}/include
    ${catkin_INCLUDE_DIRS}
)


## Declare cpp executables
add_executable(
  startRosService
  src/startRosService.cpp
  src/VideoController.cpp
  src/Detector.cpp
  src/Learner.cpp
  src/MedianFlow.cpp 
  src/NNClassifier.cpp
  src/OpticalFlow.cpp
  src/PatchGenerator.cpp
  src/RandomFernsClassifier.cpp
  src/TLD.cpp
  src/VarClassifier.cpp
  src/ViewController.cpp
  src/RosTLD.cpp
)

target_link_libraries(
  startRosService
  ${OpenCV_LIBS}
  ${catkin_LIBRARIES}
)

add_executable(
  testRosService
  src/testRosService.cpp
)
target_link_libraries(
  testRosService
  ${catkin_LIBRARIES}
)

add_service_files(
  FILES
  InitRect.srv
)
generate_messages(
  DEPENDENCIES
  std_msgs
)