// #include <opencv2/opencv.hpp>
// #include "ros/ros.h"
// #include "ros_kcf/InitRect.h"
// #include <iostream>
// #include <image_transport/image_transport.h>
// #include <cv_bridge/cv_bridge.h> 
// #include <sensor_msgs/image_encodings.h> 
// #include "std_msgs/Int32MultiArray.h"
// #include <vector>


// using namespace std;


// string resultPath("result.txt");
// string videoPath("/path/of/video");
// FILE *fout = fopen(resultPath.c_str(), "w");

// void trackResultCallback(const std_msgs::Int32MultiArray::ConstPtr& msg)
// {
//   int x1 = msg->data[0];
//   int y1 = msg->data[1];
//   int x2 = msg->data[2];
//   int y2 = msg->data[3];
//   fprintf(fout, "%d,%d,%d,%d\n", x1, y1, x2, y2);
// }

// int main(int argc, char **argv)
// {
//   ros::init(argc, argv, "test_ros_kcf");

//   ros::NodeHandle n;
//   ros::ServiceClient client = n.serviceClient<ros_kcf::InitRect>("init_rect");
//   ros_kcf::InitRect srv;

//   //142,125,232,164 from TLD Dataset 06_car.
//   srv.request.xmin = 142;
//   srv.request.ymin = 125;
//   srv.request.xmax = 232;
//   srv.request.ymax = 164;
//   client.call(srv);

//   fprintf(fout, "%d,%d,%d,%d\n", 142, 125, 232, 164);

//   //Track from video
//   cv::VideoCapture *videoCapture;
//   videoCapture = new cv::VideoCapture(videoPath);
//   ros::Publisher kcf_pub = n.advertise<sensor_msgs::Image>("camera/tracking/image", 10);
//   ros::Subscriber result_sub = n.subscribe("track_rect_pub", 10, trackResultCallback);
//   ros::Rate loop_rate(10);
//   cv::Mat frame;
//   bool tag = videoCapture->read(frame);
//   while(tag == 1)
//   {
//     sensor_msgs::ImagePtr msg = cv_bridge::CvImage(std_msgs::Header(), "bgr8", frame).toImageMsg();
//     kcf_pub.publish(msg);
//     tag = videoCapture->read(frame);
//     ros::spinOnce();
//     loop_rate.sleep();
//   }

//   return 0;
// }
