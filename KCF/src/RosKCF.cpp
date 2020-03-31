#include "RosKCF.h"
#include <ros/ros.h>
#include <iostream>
#include <opencv2/opencv.hpp>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h> 
#include <sensor_msgs/image_encodings.h> 
#include "ros_kcf/InitRect.h"
#include "std_msgs/Int32MultiArray.h"
#include <vector>
#include "kcftracker.hpp"

using namespace std;
using namespace cv;

RosKCF::RosKCF()
{
    this->service = nodeHandle.advertiseService("init_rect", &RosKCF::setInitRect, this);
    this->trackPub = nodeHandle.advertise<std_msgs::Int32MultiArray>("track_rect_pub", 1000);
    image_transport::ImageTransport it(nodeHandle);
    this->imageSub = it.subscribe("/gi/simulation/left/image_raw", 100, &RosKCF::buildAndTrack, this);
    this->initRectPtr = NULL;
    this->kcfPtr = NULL;
}

bool RosKCF::setInitRect(ros_kcf::InitRect::Request &req, ros_kcf::InitRect::Response &res)
{
    int tlx = req.xmin;
    int tly = req.ymin;
    int brx = req.xmax;
    int bry = req.ymax;
    this->initRectPtr = new cv::Rect(Point2d(tlx, tly), Point2d(brx, bry));
    std::cout<<"Init rect received."<<std::endl;
    return true;
}

void RosKCF::buildAndTrack(const sensor_msgs::ImageConstPtr &msg)
{
    try{
        cv::Mat img = cv_bridge::toCvShare(msg, "bgr8")->image;
        if (initRectPtr == NULL) return;

        if (kcfPtr == NULL && initRectPtr != NULL)
        {
            cout<<"Build"<<endl;
            kcfPtr = new KCFTracker(HOG, FIXEDWINDOW, MULTISCALE, LAB);
            kcfPtr->init(*initRectPtr, img);

            return ;
        }
        else
        {
            
            cv::Rect result = kcfPtr->update(img);

            int x1 = result.tl().x;
            int y1 = result.tl().y;
            int x2 = result.br().x;
            int y2 = result.br().y;
            cout<<"Track rect: (("<< x1 << "," << y1 << "), ("<< x2 << ", "<< y2 <<"))"<<endl;

            vector<int> trackResult;
            trackResult.push_back(result.tl().x);
            trackResult.push_back(result.tl().y);
            trackResult.push_back(result.br().x);
            trackResult.push_back(result.br().y);
            trackResultMsg.data = trackResult;
            trackPub.publish(trackResultMsg);
            return ;
        }
        
    }catch(cv_bridge::Exception &e){
        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());
    }
}
