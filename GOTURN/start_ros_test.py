from __future__ import print_function
import rospy
import sys
sys.path.append('/home/hddxds/dong/PY-GOTURN/build/devel/lib/python2.7/dist-packages')
print(sys.path)
from goturn.ros.ros_goturn import ros_goturn

if __name__ == "__main__":
    rospy.init_node('ros_goturn', anonymous=True)
    goturn = ros_goturn()
    rospy.spin()