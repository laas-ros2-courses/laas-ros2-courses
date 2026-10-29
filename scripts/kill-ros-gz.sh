#!/usr/bin/env bash
# Tue tous les processus ROS 2 / Gazebo encore en cours (utile quand un TD/TP
# plante ou qu'une fenêtre reste bloquée) : ros2, rviz2, gz sim, component
# container, et les bridges ros_gz.
set -euo pipefail

PATTERN='ros2 |rviz2|gz sim|gz-sim|gzserver|gzclient|component_container|ros_gz_image|ros_gz_bridge'

PIDS=$(pgrep -f "$PATTERN" || true)

if [ -z "$PIDS" ]; then
  echo "Rien à tuer."
  exit 0
fi

echo "Processus trouvés :"
pgrep -af "$PATTERN"

# shellcheck disable=SC2086
kill -9 $PIDS

echo "Tués : $PIDS"
