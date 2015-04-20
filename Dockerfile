# install ROS indigo
# based ubuntu 14.04 trusty
FROM ubuntu:trusty

# prepare install ROS
RUN apt-get update -q \
    && apt-get install -yq wget

# install ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
RUN wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
RUN apt-get update \
    && apt-get install -y ros-indigo-desktop-full \
    python-rosinstall \
    ros-indigo-rosserial-arduino \
    ros-indigo-rosserial

RUN rosdep init 

# vnc
RUN apt-get install -y x11vnc xvfb
# create passwd after create working user

# develop env
RUN apt-get install -y byobu \
    zsh \
    git \
    vim
    
# create user
RUN adduser --gecos '' --shell `which zsh` rosuser
RUN adduser rosuser sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER rosuser
WORKDIR /home/rosuser

# user indivisual developing env
## vnc
RUN mkdir .vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd

# ros env
RUN rosdep update
RUN echo "source /opt/ros/indigo/setup.zsh" >> ~/.zshrc

# return to root
USER root
WORKDIR /
