cmake_minimum_required(VERSION 2.8.3)
project(goturn_ros)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_BUILD_TYPE "Release")

find_package(OpenCV 3.4.2 REQUIRED)
MESSAGE("OPENCV PATH: ${OpenCV_INCLUDE_DIRS}")

find_package(catkin REQUIRED)
find_package(catkin REQUIRED COMPONENTS 
                    roscpp
                    rospy
                    cv_bridge
                    image_transport
                    sensor_msgs
                    std_msgs
                    message_generation
            )

include_directories(
    ${catkin_INCLUDE_DIRS}
)

add_service_files(
  FILES
  InitRect.srv
)
generate_messages(
  DEPENDENCIES
  std_msgs
)
