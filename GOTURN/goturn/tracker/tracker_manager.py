# Date: Wednesday 07 June 2017 11:28:11 AM IST
# Email: nrupatunga@whodat.com
# Name: Nrupatunga
# Description: tracker manager

import cv2

opencv_version = cv2.__version__.split('.')[0]
opencv_version = '2'

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


    def trackAll(self, start_video_num):
        """Track the objects in the video
        """
        objRegressor = self.regressor
        objTracker = self.tracker
        init_rect = self.init_rect

        video_keys = videos.keys()
        for i in range(start_video_num, len(videos)):
            video_frames = videos[video_keys[i]][0]
            annot_frames = videos[video_keys[i]][1]

            num_frames = min(len(video_frames), len(annot_frames))

            # Get the first frame of this video with the intial ground-truth bounding box
            frame_0 = video_frames[0]
            bbox_0 = annot_frames[0]
            sMatImage = cv2.imread(frame_0)
            objTracker.init(sMatImage, bbox_0, objRegressor)
            for i in xrange(1, num_frames):
                frame = video_frames[i]
                sMatImage = cv2.imread(frame)
                sMatImageDraw = sMatImage.copy()
                bbox = annot_frames[i]

                if opencv_version == '2':
                    cv2.rectangle(sMatImageDraw, (int(bbox.x1), int(bbox.y1)), (int(bbox.x2), int(bbox.y2)), (255, 255, 255), 2)
                else:
                    sMatImageDraw = cv2.rectangle(sMatImageDraw, (int(bbox.x1), int(bbox.y1)), (int(bbox.x2), int(bbox.y2)), (255, 255, 255), 2)

                bbox = objTracker.track(sMatImage, objRegressor)
                if opencv_version == '2':
                    cv2.rectangle(sMatImageDraw, (int(bbox.x1), int(bbox.y1)), (int(bbox.x2), int(bbox.y2)), (255, 0, 0), 2)
                else:
                    sMatImageDraw = cv2.rectangle(sMatImageDraw, (int(bbox.x1), int(bbox.y1)), (int(bbox.x2), int(bbox.y2)), (255, 0, 0), 2)

                cv2.imshow('Results', sMatImageDraw)
                cv2.waitKey(10)
