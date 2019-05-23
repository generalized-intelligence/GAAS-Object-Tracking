from __future__ import print_function
import rospy
import rosbag
from cv_bridge import CvBridge
import cv2
from sensor_msgs.msg import Image
from std_msgs.msg import String
from std_msgs.msg import Int32MultiArray
from goturn.logger.logger import setup_logger
from goturn.network.regressor import regressor
from goturn.loader.loader_vot import loader_vot
from goturn.tracker.tracker import tracker
from goturn.tracker.tracker_manager import tracker_manager
from goturn.ros import config
from goturn_ros.srv import InitRect
from goturn.helper.BoundingBox import BoundingBox

class ros_goturn:
    def __init__(self):
        self.init_rect = None
        self.bridge = CvBridge()
        self.goturn_pub = rospy.Publisher(config.TRACK_PUB_TOPIC, Int32MultiArray, queue_size=10)
        self.img_sub = rospy.Subscriber(config.IMAGE_SUB_TOPIC, Image, self.recive_frame_and_track)
        self.service = rospy.Service("init_rect", InitRect, self.set_init_rect)
        self.regressor = regressor(config.PROTOTXT_PATH, config.MODEL_PATH, config.GPUID, 1)
        self.tracker = tracker(False)
        self.tracker_manager = None
        print('go')


    def recive_frame_and_track(self, msg):
        if self.init_rect==None:
            return
        if True:
            cv2_img = self.bridge.imgmsg_to_cv2(msg, "bgr8")
            if self.init_rect is not None and self.tracker_manager is None:
                self.tracker_manager = tracker_manager(self.init_rect, cv2_img, self.regressor, self.tracker)
                return
            else:
                bbox = self.tracker_manager.track_frame(cv2_img)
                bbox_msg = Int32MultiArray()
                bbox_msg.data = [int(bbox.x1), int(bbox.y1), int(bbox.x2), int(bbox.y2)]
                self.goturn_pub.publish(bbox_msg)
            

    def set_init_rect(self, req):
        try:
            print(req)
            self.init_rect = BoundingBox(req.xmin, req.ymin, req.xmax, req.ymax)
            print('Set init rect.')
            return True
        except Exception as e:
            print(e)
            print('Set init rect wrong.')
            return False
