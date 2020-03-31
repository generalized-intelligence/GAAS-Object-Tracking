from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import rospy
import cv2
from cv_bridge import CvBridge,CvBridgeError
from sensor_msgs.msg import Image
from std_msgs.msg import String
from std_msgs.msg import Int32MultiArray
import ros.config as config

import os
import argparse
import torch
import numpy as np
from glob import glob

from pysot_ros.srv import InitRect

from pysot.core.config import cfg
from pysot.models.model_builder import ModelBuilder
from pysot.tracker.tracker_builder import build_tracker

torch.set_num_threads(1)

class ros_pysot:
    def __init__(self):
        self.init_rect = None
        self.bridge = CvBridge()

        self.pysot_pub = rospy.Publisher(config.TRACK_PUB_TOPIC, Int32MultiArray, queue_size=10)
        self.img_sub = rospy.Subscriber(config.IMAGE_SUB_TOPIC, Image, self.receive_frame_and_track)
        self.service = rospy.Service("init_rect", InitRect, self.set_init_rect)
        
        cfg.TRACK.TYPE = config.TRACK_TYPE
        cfg.merge_from_file(config.CONFIG_PATH)
        cfg.CUDA = torch.cuda.is_available()
        device = torch.device('cuda' if cfg.CUDA else 'cpu')
        model = ModelBuilder()
        model.load_state_dict(torch.load(config.MODEL_PATH,
            map_location=lambda storage, loc: storage.cpu()))
        model.eval().to(device)

        self.tracker = build_tracker(model)

    def receive_frame_and_track(self, msg):

        # import pdb;pdb.set_trace()
        if self.init_rect==None:
            return
        try:

            cv2_img = self.bridge.imgmsg_to_cv2(msg)
            if self.init_rect is not None and (not hasattr(self.tracker, "center_pos")):
                self.tracker.init(cv2_img, self.init_rect)
                return
            else:
                outputs = self.tracker.track(cv2_img)
                bbox = list(map(int, outputs['bbox']))
                bbox_msg = Int32MultiArray()
                bbox_msg.data = [int(bbox[0]), int(bbox[1]), int(bbox[0]+bbox[2]), int(bbox[1]+bbox[3])]
                print(bbox)
                self.pysot_pub.publish(bbox_msg)
        except Exception as e:
            print(e)
            

    def set_init_rect(self, req):
        self.init_rect = (req.xmin, req.ymin, req.xmax-req.xmin, req.ymax-req.ymin)
        print("Init rect received.")
        return True