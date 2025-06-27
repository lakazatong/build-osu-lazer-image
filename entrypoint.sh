#!/bin/bash

chmod +x /init.sh /warmup.sh

/init.sh

case "$MODE" in
	warmup)
		/warmup.sh
		;;
	*)
		;;
esac

exec bash
