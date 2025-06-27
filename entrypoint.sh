#!/bin/bash

rm -f /tmp/.X99-lock /tmp/.X11-unix/X99

Xvfb :99 -screen 0 1920x1080x24 &
XVFB_PID=$!

for i in {1..10}; do
	if DISPLAY=:99 xdpyinfo > /dev/null 2>&1; then
		break
	fi
	sleep 0.5
done

fluxbox > /dev/null 2>&1 &
FLUXBOX_PID=$!

cd /osu-server
git pull

cd /osu-framework-server
git pull

case "$MODE" in
	warmup)
		/warmup.sh
		;;
	*)
		cd /
		bash
		;;
esac

kill $XVFB_PID $FLUXBOX_PID 2>/dev/null
wait $XVFB_PID $FLUXBOX_PID 2>/dev/null
