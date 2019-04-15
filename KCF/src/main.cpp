#include <ros/ros.h>
#include "RosKCF.h"


int main(int argc, char** argv)
{
    ros::init(argc, argv, "ros_kcf");
    RosKCF rosKCF;
    ros::spin();
    return 0;
}
