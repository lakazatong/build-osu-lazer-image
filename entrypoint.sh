#!/bin/bash

/init.sh

case "$MODE" in
	warmup)
		/warmup.sh
		;;
	*)
		;;
esac

exec bash
