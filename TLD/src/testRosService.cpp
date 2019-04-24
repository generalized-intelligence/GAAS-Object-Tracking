#include "ros/ros.h"
#include "ros_tld/InitRect.h"
#include <iostream>
using namespace std;

int main(int argc, char **argv)
{
  ros::init(argc, argv, "test_ros_tld");

  ros::NodeHandle n;
  ros::ServiceClient client = n.serviceClient<ros_tld::InitRect>("init_rect");
  ros_tld::InitRect srv;
  //142,125,232,164
  srv.request.xmin = 142;
  srv.request.ymin = 125;
  srv.request.xmax = 232;
  srv.request.ymax = 164;
  if (client.call(srv))
  {
    cout<<"True";
  }
  else
  {
    ROS_ERROR("Failed to call service add_two_ints");
    return 1;
  }

  return 0;
}
