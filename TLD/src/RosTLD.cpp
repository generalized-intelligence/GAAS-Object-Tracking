#include "RosTLD.h"
#include <ros/ros.h>
#include <iostream>
#include <opencv2/opencv.hpp>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h> 
#include <sensor_msgs/image_encodings.h> 
#include "ros_tld/InitRect.h"
#include "std_msgs/Int32MultiArray.h"
#include <vector>
#include "TLD.h"

using namespace std;

RosTLD::RosTLD()
{
    this->service = nodeHandle.advertiseService("init_rect", &RosTLD::setInitRect, this);
    this->trackPub = nodeHandle.advertise<std_msgs::Int32MultiArray>("track_rect_pub", 1000);
    image_transport::ImageTransport it(nodeHandle);
    this->imageSub = it.subscribe("camera/tracking/image", 100, &RosTLD::buildTLDAndTrack, this);
    this->initRectPtr = NULL;
    this->tldPtr = NULL;
}

bool RosTLD::setInitRect(ros_tld::InitRect::Request &req, ros_tld::InitRect::Response &res)
{
    int tlx = req.xmin;
    int tly = req.ymin;
    int brx = req.xmax;
    int bry = req.ymax;
    this->initRectPtr = new Rect(Point2d(tlx, tly), Point2d(brx, bry));
    return true;
}

void RosTLD::buildTLDAndTrack(const sensor_msgs::ImageConstPtr &msg)
{
    try{
        cv::Mat img = cv_bridge::toCvShare(msg, "bgr8")->image;
        if (initRectPtr == NULL) return;

        if (tldPtr == NULL && initRectPtr != NULL)
        {
            cout<<"Build"<<endl;
            tldPtr = new TLD(img, *initRectPtr);
            return ;
        }
        else
        {
            cout<<"Track"<<endl;
            tldPtr->setNextFrame(img);
            tldPtr->track();
            vector<int> trackResult;
            trackResult.push_back(tldPtr->getBB().tl().x);
            trackResult.push_back(tldPtr->getBB().tl().y);
            trackResult.push_back(tldPtr->getBB().br().x);
            trackResult.push_back(tldPtr->getBB().br().y);
            trackResultMsg.data = trackResult;
            trackPub.publish(trackResultMsg);
            cout<<"Get BB:"<<tldPtr->getBB()<<endl;
            return ;
        }
        
    }catch(cv_bridge::Exception &e){
        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());
    }
}