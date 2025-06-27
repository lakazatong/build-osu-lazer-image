#!/bin/bash

rm -f /tmp/.X99-lock /tmp/.X11-unix/X99
Xvfb :99 -screen 0 1920x1080x24 &
fluxbox &

cd /osu-server
git pull

cd /osu-framework-server
git pull
