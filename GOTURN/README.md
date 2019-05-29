# GOTURN

## Dependencies
1. caffe
2. opencv
3. rospy

## Pretrained model
1. Download the pretrained model: 
```sh
wget http://cs.stanford.edu/people/davheld/public/GOTURN/trained_model/tracker.caffemodel
```
2. Move to the right directory:
```sh
mv tracker.caffemodel /path/to/GOTURN/nets/
```

## Download dataset
[VOT18](http://www.votchallenge.net/)

## Get Start
### Build ROS service
```sh
mkdir build
cd build
cmake ..
make -j1
```
### Start ROS core
```sh
roscore
```
### Start GOTURN ROS node
Init ROS node and init tracking.
```python
import rospy
#Add ROS service to python system path.
import sys
sys.path.append('/path/to/PYSOT/build/devel/lib/python2.7/dist-packages')
from goturn.ros.ros_goturn import ros_goturn

if __name__ == "__main__":
    rospy.init_node('ros_goturn', anonymous=True)
    goturn = ros_goturn()
    rospy.spin()
```
The above code is included in `start_ros_goturn.py`.
### Init tracker and start track
1. Use ROS service to set init rect: 
```python
rospy.wait_for_service('init_rect')
init_rect = rospy.ServiceProxy('init_rect', InitRect)
init_rect([496,419,536,461]) #xmin, ymin, xmax, ymax
```
2. Use ROS Publisher publish image to tracker: 
```python
rospy.init_node('test_ros_goturn', anonymous=True)

#config.IMAGE_SUB_TOPIC: Change topic name at /path/to/GOTURN/goturn/ros/config.py
img_pub = rospy.Publisher(config.IMAGE_SUB_TOPIC, Image, queue_size=10) 
img = cv2.imread("/image/path") 
msg = bridge.cv2_to_imgmsg(img, "bgr8")
img_pub.publish(msg)
```
3. Use ROS Subscriber to recive tracking result:
```python
#config.TRACK_PUB_TOPIC: Change topic name at /path/to/GOTURN/goturn/ros/config.py
result_sub = rospy.Subscriber(config.TRACK_PUB_TOPIC, Int32MultiArray, callback) 
```
The above code is included in `test_ros_goturn.py`.

---
Thanks for [Project PY-GOTURN](https://github.com/nrupatunga/PY-GOTURN.git).