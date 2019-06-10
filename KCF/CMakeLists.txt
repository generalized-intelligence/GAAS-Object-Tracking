cmake_minimum_required(VERSION 2.8)
project(ros_kcf)

set(CMAKE_CXX_STANDARD 11)
find_package(OpenCV REQUIRED)

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

set(INC_DIR ./src)

include_directories(
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/src
    ${catkin_INCLUDE_DIRS}
)
FILE(GLOB_RECURSE sourcefiles "src/*.cpp")
add_executable( startRosService ${sourcefiles} )


target_link_libraries(
  startRosService
  ${OpenCV_LIBS}
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


