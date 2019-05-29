from __future__ import print_function
import rospy
import sys
sys.path.append('/home/hddxds/dong/PY-GOTURN/build/devel/lib/python2.7/dist-packages')
from goturn_ros.srv import InitRect
import os
from cv_bridge import CvBridge
import cv2
from sensor_msgs.msg import Image
from std_msgs.msg import Int32MultiArray
from goturn.ros import config

def get_rect_result(result):
    print(result)

if __name__ == "__main__":
    data_dir = "/home/hddxds/dong/PY-GOTURN/dataset/VOT/VOT2018/juggle"
    rospy.wait_for_service('init_rect')
    init_rect = rospy.ServiceProxy('init_rect', InitRect)
    try:
        init_rect(496,419,536,461)
    except:
        pass

    bridge = CvBridge()
    rospy.init_node('test_ros_goturn', anonymous=True)
    img_pub = rospy.Publisher(config.IMAGE_SUB_TOPIC, Image, queue_size=10)
    result_sub = rospy.Subscriber(config.TRACK_PUB_TOPIC, Int32MultiArray, get_rect_result)
    rate = rospy.Rate(10)
    for name in os.listdir(data_dir):
        if name.endswith('.jpg'):
            img_path = os.path.join(data_dir, name)
            img = cv2.imread(img_path)
            msg = bridge.cv2_to_imgmsg(img, "bgr8")
            img_pub.publish(msg)
            rate.sleep()

