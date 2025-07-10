#!/bin/bash

# 1. Open a terminal for xhost +
gnome-terminal -- bash -c "xhost +; exec bash"

# 2. List of commands to run in Docker
commands=(
    "rgazebo input_file:=/home/colcon_ws/src/social_navigation/social_navigation_py/social_navigation_py/robot_setup_2.json"
    "rnav2"
    "rsfm"
    "ros2 launch aws_robomaker_hospital_world main.launch.py input_file:=/home/colcon_ws/src/social_navigation/social_navigation_py/social_navigation_py/robot_setup_2.json"
    "rcplan --ros-args -p 'robots:=[\"robot1\", \"robot2\"]'"
    "rqueues"
    "rcdis -p input_file:=/home/colcon_ws/src/social_navigation/social_navigation_py/social_navigation_py/robot_setup_2.json"
)

# 3. For each command, open a new terminal and run the setup inside the Docker container
for cmd in "${commands[@]}"
do
    gnome-terminal -- bash -c "docker exec -it docker-ros-ubuntu-1 bash -ilc 'cd /home/colcon_ws && source install/local_setup.bash && $cmd; exec bash'"
done