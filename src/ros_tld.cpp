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

using namespace std;
using namespace cv;

TLD *tld_ptr = NULL;
Rect rect;
Rect *initRect;
int i = 0;
int imageCallback(const sensor_msgs::ImageConstPtr &msg)
{
    cout<<"recive"<<endl;
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
            cout<<"track"<<endl;
            tld_ptr->setNextFrame(img);
            tld_ptr->track();
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
    rect = Rect(Point2d(tlx, tly), Point2d(brx, bry));
    initRect = new Rect(Point2d(tlx, tly), Point2d(brx, bry));
    return true;
}


int main(int argc, char** argv)
{
    ros::init(argc, argv, "ros_tld");
    ros::NodeHandle nodeHandle;

    //TODO:change to ros service
    ros::ServiceServer service = nodeHandle.advertiseService("init_rect", setInitRect);
    //string initFilename("/home/hddxds/dong/TLD/datasets/06_car/init.txt");
    //FILE *fin = fopen(initFilename.c_str(), "r");
    //int tlx, tly, brx, bry;
    //fscanf(fin, "%d,%d,%d,%d", &tlx, &tly, &brx, &bry);
    //rect = Rect(Point2d(tlx, tly), Point2d(brx, bry));
    //cout << rect<<endl;
    //fclose(fin);

    //ros::ServiceServer service = nodeHandle.advertiseService("set_init", set_init);

    // ros::Publisher rect_pub = n.advertise<std_msgs::int>("chatter", 1000);
    image_transport::ImageTransport it(nodeHandle);
    image_transport::Subscriber ltd_sub = it.subscribe("camera/tld/image", 1, imageCallback);
    ROS_INFO("Ready to set init rect.");
    ros::spin();
    return 0;
}
