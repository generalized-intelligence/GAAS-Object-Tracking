from __future__ import print_function
import rospy
#Add ROS service to python system path.
import sys
sys.path.append('/path/to/PYSOT/build/devel/lib/python2.7/dist-packages')
from ros.ros_pysot import ros_pysot

if __name__ == "__main__":
    rospy.init_node('ros_pysot', anonymous=True)
    ros_pysot()
    rospy.spin()