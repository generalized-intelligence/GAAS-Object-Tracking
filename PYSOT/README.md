# PYSOT

## Dependencies
1. pyTorch
2. opencv

## Pretrained model
Download the [PySOT Pretrained Model](https://github.com/STVIR/pysot/blob/master/MODEL_ZOO.md)

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
### Install requirements
```sh
pip install requirements.txt
```

### Start ROS core
```sh
roscore
```
### Choose algorithm
PYSOT implements three single object tracking algorithms. You can change the algorithm used by changing the `TRACK_TYPE` in `ros/config.py` , default: SiamRPN.

### Start GOTURN ROS node
Init ROS node and init tracking.
```python
import rospy
#Add ROS service to python system path.
import sys
sys.path.append('/path/to/PYSOT/build/devel/lib/python2.7/dist-packages')
from ros.ros_pysot import ros_pysot

if __name__ == "__main__":
    rospy.init_node('ros_pysot', anonymous=True)
    ros_pysot()
    rospy.spin()
```
The above code is included in `start_ros_pysot.py`.
### Init tracker and start track
1. Use ROS service to set init rect: 
```python
rospy.wait_for_service('init_rect')
init_rect = rospy.ServiceProxy('init_rect', InitRect)
init_rect([496,419,536,461]) #xmin, ymin, xmax, ymax
```
2. Use ROS Publisher publish image to tracker: 
```python
rospy.init_node('test_ros_pysot', anonymous=True)

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
4. PYSOT implements three single object tracking algorithms. You can change the algorithm used by changing the `TRACK_TYPE` in `ros/config.py`.

The above code is included in `test_ros_pysot.py`.
---
Thanks for [Project PYSOT](https://github.com/STVIR/pysot.git).