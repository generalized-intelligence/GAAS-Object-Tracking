#include <ros/ros.h>
#include <iostream>
#include <opencv2/opencv.hpp>
#include "ViewController.h"
#include "VideoController.h"
#include "RandomFernsClassifier.h"
#include "NNClassifier.h"
#include "Detector.h"
#include "TLD.h"
#include "TLDSystemStruct.h"
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h> 
#include <sensor_msgs/image_encodings.h> 
#include "ros_tld/InitRect.h"
#include "std_msgs/Int32MultiArray.h"
#include <vector>

using namespace std;
using namespace cv;

TLD *tld_ptr = NULL;
Rect *initRect;
ros::Publisher *tld_pub_p;
int i = 0;
int trackFrame(const sensor_msgs::ImageConstPtr &msg)
{
    cout<<"Recive"<<endl;
    try{
        Mat img = cv_bridge::toCvShare(msg, "bgr8")->image;
        if (initRect == NULL) return 0;

        if (tld_ptr == NULL && initRect != NULL)
        {
            cout<<"Build"<<endl;
            tld_ptr = new TLD(img, *initRect);
            return 0;
        }
        else
        {
            cout<<"Track"<<endl;
            tld_ptr->setNextFrame(img);
            tld_ptr->track();
            vector<int> trackResult;
            trackResult.push_back(tld_ptr->getBB().tl().x);
            trackResult.push_back(tld_ptr->getBB().tl().y);
            trackResult.push_back(tld_ptr->getBB().br().x);
            trackResult.push_back(tld_ptr->getBB().br().y);
            std_msgs::Int32MultiArray msg;
            msg.data = trackResult;
            tld_pub_p->publish(msg);
            cout<<"Get BB:"<<tld_ptr->getBB()<<endl;
            return 1;
        }
        
    }catch(cv_bridge::Exception &e){
        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());
    }
    return 0;
}

bool setInitRect(ros_tld::InitRect::Request &req, ros_tld::InitRect::Response &res)
{
    int tlx = req.xmin;
    int tly = req.ymin;
    int brx = req.xmax;
    int bry = req.ymax;
    initRect = new Rect(Point2d(tlx, tly), Point2d(brx, bry));
    cout<<"TL point: "<<tlx<<", "<<tly<<endl;
    return true;
}


int main(int argc, char** argv)
{
    ros::init(argc, argv, "ros_tld");
    ros::NodeHandle nodeHandle;

    ros::ServiceServer service = nodeHandle.advertiseService("init_rect", setInitRect);

    // ros::Publisher ltd_pub = n.advertise<std_msgs::int>("chatter", 1000);
    ros::Publisher ltd_pub =  nodeHandle.advertise<std_msgs::Int32MultiArray>("tracking_pub", 100);
    tld_pub_p = &ltd_pub;
    image_transport::ImageTransport it(nodeHandle);
    image_transport::Subscriber ltd_sub = it.subscribe("camera/tld/image", 1, trackFrame);
    ROS_INFO("Ready to set init rect.");
    ros::spin();
    return 0;
}
