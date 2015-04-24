#! /usr/bin/env python
import rospy
from std_msgs.msg import Empty

def servo_publisher():
    pub = rospy.Publisher('toggle_led', Empty)
    rospy.init_node('servo_publisher', anonymous=True)
    rate = rospy.Rate(10)
    while not rospy.is_shutdown():
        pub.publish()
        rate.sleep()

if __name__ == '__main__':
    try:
        servo_publisher()
    except rospy.RosInterruptException:
        pass
