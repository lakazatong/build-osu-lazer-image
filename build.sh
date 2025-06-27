#!/bin/bash

set -e

IMAGE_NAME=osu-server
WARMUP=false

function show_help() {
	echo "Usage: $0 [options]"
	echo ""
	echo "Options:"
	echo "  --name <image_name>    Set the name of the Docker image (default: osu-server)"
	echo "  -w, --warmup           Build and warm up the container"
	echo "  -h, --help             Show this help message"
	echo ""
	echo "Example usage:"
	echo "  $0 --name custom-image-name -w"
}

while [[ "$1" =~ ^- ]]; do
	case "$1" in
		--name)
			IMAGE_NAME=$2
			shift 2
			;;
		-w|--warmup)
			WARMUP=true
			shift
			;;
		-h|--help)
			show_help
			exit 0
			;;
		*)
			echo "Unknown option: $1"
			exit 1
			;;
	esac
done

docker build -t "$IMAGE_NAME" .

if [ "$WARMUP" == true ]; then
	docker rm -f temp-osu 2>/dev/null || true
	docker run -e MODE=warmup --name temp-osu "$IMAGE_NAME"
	docker commit temp-osu "$IMAGE_NAME":prewarmed
	docker rm temp-osu
fi
