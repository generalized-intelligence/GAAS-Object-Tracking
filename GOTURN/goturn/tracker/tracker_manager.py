# Date: Wednesday 07 June 2017 11:28:11 AM IST
# Email: nrupatunga@whodat.com
# Name: Nrupatunga
# Description: tracker manager

import cv2


class tracker_manager:

    """Docstring for tracker_manager. """

    def __init__(self, init_rect, first_frame, regressor, tracker):
        """This is

        :videos: list of video frames and annotations
        :regressor: regressor object
        :tracker: tracker object
        :returns: list of video sub directories
        """
        self.tracker = tracker
        self.regressor = regressor
        self.tracker.init(first_frame, init_rect, self.regressor)

    def track_frame(self, frame):
        obj_tracker = self.tracker
        obj_regressor = self.regressor
        bbox = obj_tracker.track(frame, obj_regressor)
        return bbox

