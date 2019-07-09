;; Auto-generated. Do not edit!


(when (boundp 'ros_kcf::InitRect)
  (if (not (find-package "ROS_KCF"))
    (make-package "ROS_KCF"))
  (shadow 'InitRect (find-package "ROS_KCF")))
(unless (find-package "ROS_KCF::INITRECT")
  (make-package "ROS_KCF::INITRECT"))
(unless (find-package "ROS_KCF::INITRECTREQUEST")
  (make-package "ROS_KCF::INITRECTREQUEST"))
(unless (find-package "ROS_KCF::INITRECTRESPONSE")
  (make-package "ROS_KCF::INITRECTRESPONSE"))

(in-package "ROS")





(defclass ros_kcf::InitRectRequest
  :super ros::object
  :slots (_xmin _ymin _xmax _ymax ))

(defmethod ros_kcf::InitRectRequest
  (:init
   (&key
    ((:xmin __xmin) 0)
    ((:ymin __ymin) 0)
    ((:xmax __xmax) 0)
    ((:ymax __ymax) 0)
    )
   (send-super :init)
   (setq _xmin (round __xmin))
   (setq _ymin (round __ymin))
   (setq _xmax (round __xmax))
   (setq _ymax (round __ymax))
   self)
  (:xmin
   (&optional __xmin)
   (if __xmin (setq _xmin __xmin)) _xmin)
  (:ymin
   (&optional __ymin)
   (if __ymin (setq _ymin __ymin)) _ymin)
  (:xmax
   (&optional __xmax)
   (if __xmax (setq _xmax __xmax)) _xmax)
  (:ymax
   (&optional __ymax)
   (if __ymax (setq _ymax __ymax)) _ymax)
  (:serialization-length
   ()
   (+
    ;; int32 _xmin
    4
    ;; int32 _ymin
    4
    ;; int32 _xmax
    4
    ;; int32 _ymax
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _xmin
       (write-long _xmin s)
     ;; int32 _ymin
       (write-long _ymin s)
     ;; int32 _xmax
       (write-long _xmax s)
     ;; int32 _ymax
       (write-long _ymax s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _xmin
     (setq _xmin (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _ymin
     (setq _ymin (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _xmax
     (setq _xmax (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _ymax
     (setq _ymax (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass ros_kcf::InitRectResponse
  :super ros::object
  :slots ())

(defmethod ros_kcf::InitRectResponse
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass ros_kcf::InitRect
  :super ros::object
  :slots ())

(setf (get ros_kcf::InitRect :md5sum-) "7774db90b9f2d2e1375663d80c5c2b9e")
(setf (get ros_kcf::InitRect :datatype-) "ros_kcf/InitRect")
(setf (get ros_kcf::InitRect :request) ros_kcf::InitRectRequest)
(setf (get ros_kcf::InitRect :response) ros_kcf::InitRectResponse)

(defmethod ros_kcf::InitRectRequest
  (:response () (instance ros_kcf::InitRectResponse :init)))

(setf (get ros_kcf::InitRectRequest :md5sum-) "7774db90b9f2d2e1375663d80c5c2b9e")
(setf (get ros_kcf::InitRectRequest :datatype-) "ros_kcf/InitRectRequest")
(setf (get ros_kcf::InitRectRequest :definition-)
      "int32 xmin
int32 ymin
int32 xmax
int32 ymax
---

")

(setf (get ros_kcf::InitRectResponse :md5sum-) "7774db90b9f2d2e1375663d80c5c2b9e")
(setf (get ros_kcf::InitRectResponse :datatype-) "ros_kcf/InitRectResponse")
(setf (get ros_kcf::InitRectResponse :definition-)
      "int32 xmin
int32 ymin
int32 xmax
int32 ymax
---

")



(provide :ros_kcf/InitRect "7774db90b9f2d2e1375663d80c5c2b9e")


