#!/bin/bash

cd "$(dirname "$(readlink -f "$0")")"


term_handler() {
  sudo /etc/init.d/dbus stop
}
trap 'kill $!; term_handler' SIGINT SIGKILL SIGTERM SIGQUIT SIGTSTP SIGSTOP SIGHUP

sudo /etc/init.d/dbus start

# Without these, startx won't work when run as non root
sudo chmod -R 777 /dev/tty0
sudo chmod -R 777 /dev/tty1
sudo chmod -R 777 /dev/tty2
sudo chmod -R 777 /dev/snd
sudo chmod -R 777 /dev/input
sudo chmod -R 777 /dev/fb0

# Configure VNC password
PASSWD="$(dd if=/dev/urandom bs=512 count=1 2>/dev/null | sha256sum | base64 | head -c 32)"
mkdir -p "$HOME/.vnc"
x11vnc -storepasswd "$PASSWD" "$HOME/.vnc/passwd"

# Start desktop environment and VNC
/usr/bin/startx &
sleep 12
/usr/bin/x11vnc -usepw -forever -display :0 -bg
/usr/bin/unclutter -idle 1 -root -display :0 &


# Show VNC password in Balena's log
echo "************************************************"
echo "VNC password: $PASSWD"
echo "************************************************"

# This script is PID 1, keep it running
sleep infinity &
wait $!
