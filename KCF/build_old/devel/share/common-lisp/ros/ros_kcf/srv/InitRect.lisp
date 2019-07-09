; Auto-generated. Do not edit!


(cl:in-package ros_kcf-srv)


;//! \htmlinclude InitRect-request.msg.html

(cl:defclass <InitRect-request> (roslisp-msg-protocol:ros-message)
  ((xmin
    :reader xmin
    :initarg :xmin
    :type cl:integer
    :initform 0)
   (ymin
    :reader ymin
    :initarg :ymin
    :type cl:integer
    :initform 0)
   (xmax
    :reader xmax
    :initarg :xmax
    :type cl:integer
    :initform 0)
   (ymax
    :reader ymax
    :initarg :ymax
    :type cl:integer
    :initform 0))
)

(cl:defclass InitRect-request (<InitRect-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <InitRect-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'InitRect-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_kcf-srv:<InitRect-request> is deprecated: use ros_kcf-srv:InitRect-request instead.")))

(cl:ensure-generic-function 'xmin-val :lambda-list '(m))
(cl:defmethod xmin-val ((m <InitRect-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_kcf-srv:xmin-val is deprecated.  Use ros_kcf-srv:xmin instead.")
  (xmin m))

(cl:ensure-generic-function 'ymin-val :lambda-list '(m))
(cl:defmethod ymin-val ((m <InitRect-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_kcf-srv:ymin-val is deprecated.  Use ros_kcf-srv:ymin instead.")
  (ymin m))

(cl:ensure-generic-function 'xmax-val :lambda-list '(m))
(cl:defmethod xmax-val ((m <InitRect-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_kcf-srv:xmax-val is deprecated.  Use ros_kcf-srv:xmax instead.")
  (xmax m))

(cl:ensure-generic-function 'ymax-val :lambda-list '(m))
(cl:defmethod ymax-val ((m <InitRect-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_kcf-srv:ymax-val is deprecated.  Use ros_kcf-srv:ymax instead.")
  (ymax m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <InitRect-request>) ostream)
  "Serializes a message object of type '<InitRect-request>"
  (cl:let* ((signed (cl:slot-value msg 'xmin)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ymin)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'xmax)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ymax)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <InitRect-request>) istream)
  "Deserializes a message object of type '<InitRect-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'xmin) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ymin) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'xmax) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ymax) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<InitRect-request>)))
  "Returns string type for a service object of type '<InitRect-request>"
  "ros_kcf/InitRectRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'InitRect-request)))
  "Returns string type for a service object of type 'InitRect-request"
  "ros_kcf/InitRectRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<InitRect-request>)))
  "Returns md5sum for a message object of type '<InitRect-request>"
  "7774db90b9f2d2e1375663d80c5c2b9e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'InitRect-request)))
  "Returns md5sum for a message object of type 'InitRect-request"
  "7774db90b9f2d2e1375663d80c5c2b9e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<InitRect-request>)))
  "Returns full string definition for message of type '<InitRect-request>"
  (cl:format cl:nil "int32 xmin~%int32 ymin~%int32 xmax~%int32 ymax~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'InitRect-request)))
  "Returns full string definition for message of type 'InitRect-request"
  (cl:format cl:nil "int32 xmin~%int32 ymin~%int32 xmax~%int32 ymax~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <InitRect-request>))
  (cl:+ 0
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <InitRect-request>))
  "Converts a ROS message object to a list"
  (cl:list 'InitRect-request
    (cl:cons ':xmin (xmin msg))
    (cl:cons ':ymin (ymin msg))
    (cl:cons ':xmax (xmax msg))
    (cl:cons ':ymax (ymax msg))
))
;//! \htmlinclude InitRect-response.msg.html

(cl:defclass <InitRect-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass InitRect-response (<InitRect-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <InitRect-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'InitRect-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_kcf-srv:<InitRect-response> is deprecated: use ros_kcf-srv:InitRect-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <InitRect-response>) ostream)
  "Serializes a message object of type '<InitRect-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <InitRect-response>) istream)
  "Deserializes a message object of type '<InitRect-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<InitRect-response>)))
  "Returns string type for a service object of type '<InitRect-response>"
  "ros_kcf/InitRectResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'InitRect-response)))
  "Returns string type for a service object of type 'InitRect-response"
  "ros_kcf/InitRectResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<InitRect-response>)))
  "Returns md5sum for a message object of type '<InitRect-response>"
  "7774db90b9f2d2e1375663d80c5c2b9e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'InitRect-response)))
  "Returns md5sum for a message object of type 'InitRect-response"
  "7774db90b9f2d2e1375663d80c5c2b9e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<InitRect-response>)))
  "Returns full string definition for message of type '<InitRect-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'InitRect-response)))
  "Returns full string definition for message of type 'InitRect-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <InitRect-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <InitRect-response>))
  "Converts a ROS message object to a list"
  (cl:list 'InitRect-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'InitRect)))
  'InitRect-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'InitRect)))
  'InitRect-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'InitRect)))
  "Returns string type for a service object of type '<InitRect>"
  "ros_kcf/InitRect")