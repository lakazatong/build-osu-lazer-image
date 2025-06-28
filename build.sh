#!/bin/bash

set -e

IMAGE_NAME=osu-server
WARMUP=false

function show_help() {
	echo "Usage: $0 [options]"
	echo ""
	echo "Options:"
	echo "  --name <image_name>    Set the name of the Docker image (default: osu-server)"
	echo "  -w, --warmup           Also builds <image_name>:prewarmed"
	echo "  -f, --no-cache         Force Docker to build without cache"
	echo "  -h, --help             Show this help message"
	echo ""
	echo "Example usage:"
	echo "  $0 --name custom-image-name -w -f"
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
		-f|--no-cache)
			NO_CACHE=true
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

BUILD_ARGS=()
if [ "$NO_CACHE" == true ]; then
	BUILD_ARGS+=(--no-cache)
fi

docker build "${BUILD_ARGS[@]}" -t "$IMAGE_NAME" .

if [ "$WARMUP" == true ]; then
	docker rm -f temp-osu 2>/dev/null || true
	echo "running the container..."
	docker run -e MODE=warmup --name temp-osu "$IMAGE_NAME"
	echo "committing..."
	docker commit temp-osu "$IMAGE_NAME":prewarmed
	docker rm temp-osu
fi
