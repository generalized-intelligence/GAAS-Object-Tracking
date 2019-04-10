#ifndef __RosTLD__
#define __RosTLD__

#include <ros/ros.h>
#include <opencv2/opencv.hpp>
#include <sensor_msgs/image_encodings.h> 
#include "ros_tld/InitRect.h"
#include "std_msgs/Int32MultiArray.h"
#include <image_transport/image_transport.h>
#include "TLD.h"

class RosTLD
{
private:
    cv::Rect *initRectPtr;
    std_msgs::Int32MultiArray trackResultMsg;

    ros::NodeHandle nodeHandle;
    ros::Publisher trackPub;
    ros::ServiceServer service;
    image_transport::Subscriber imageSub;
    TLD *tldPtr;
public:
    RosTLD();

    //callback of service server.
    bool setInitRect(ros_tld::InitRect::Request &req, ros_tld::InitRect::Response &res);

    //callback of imageSub.
    void buildTLDAndTrack(const sensor_msgs::ImageConstPtr &msg);

};

#endif