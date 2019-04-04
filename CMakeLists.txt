cmake_minimum_required(VERSION 2.8.3)
project(visualize_rosbag)

set(CMAKE_CXX_STANDARD 11)
## set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_BUILD_TYPE "Debug")

find_package(OpenCV 3.4.2 REQUIRED)
MESSAGE("OPENCV PATH: ${OpenCV_INCLUDE_DIRS}")

find_package(catkin REQUIRED)
find_package(catkin REQUIRED COMPONENTS 
                    roscpp
                    cv_bridge
                    image_transport
                    sensor_msgs
                    std_msgs)

include_directories(
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/src
    ${PROJECT_SOURCE_DIR}/include
    ${catkin_INCLUDE_DIRS}
)



## Declare cpp executables
add_executable(
  ros_tld
  src/ros_tld.cpp
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
)
target_link_libraries(
  ros_tld
  ${OpenCV_LIBS}
  ${catkin_LIBRARIES}
)