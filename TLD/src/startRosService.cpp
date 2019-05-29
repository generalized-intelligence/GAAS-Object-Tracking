#include <ros/ros.h>
#include "RosTLD.h"



int main(int argc, char** argv)
{
    ros::init(argc, argv, "ros_tld");
    RosTLD rosTLD;
    std::cout<<"Started."<<std::endl;
    ros::spin();
    return 0;
}
