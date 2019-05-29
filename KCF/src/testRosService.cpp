#include "ros/ros.h"
#include "RosKCF.h"
#include "ros_kcf/InitRect.h"
#include <iostream>
#include <opencv2/opencv.hpp>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h> 
#include <sensor_msgs/image_encodings.h> 
#include "std_msgs/Int32MultiArray.h"
#include <vector>
using namespace std;

void trackResultCallback(const std_msgs::Int32MultiArray::ConstPtr& msg)
{
  cout<<msg<<endl;
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "test_ros_kcf");

  ros::NodeHandle n;
  ros::ServiceClient client = n.serviceClient<ros_kcf::InitRect>("init_rect");
  ros_kcf::InitRect srv;
  //142,125,232,164
  srv.request.xmin = 142;
  srv.request.ymin = 125;
  srv.request.xmax = 232;
  srv.request.ymax = 164;
  client.call(srv);

  //Track from video
  VideoCapture videoCapture;
  videoCapture.open("/path/to/video");
  ros::Publisher kcf_pub = n.advertise<std_msgs::String>("camera/tracking/image", 10);
  ros::Subscriber result_sub = n.subscribe("track_rect_pub", 10, trackResultCallback);
  ros::Rate loop_rate(10);
  Mat frame;
  bool tag = videoCapture.read(frame);
  while(tag == 1)
  {
    sensor_msgs::ImagePtr msg = cv_bridge::CvImage(std_msgs::Header(), "bgr8", frame).toImageMsg();
    result_sub.publish(msg);
    tag = videoCapture.read(frame);
    ros::spinOnce();
    loop_rate.sleep();
  }


  return 0;
}
