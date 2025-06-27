#!/bin/bash

set -e

cd /osu-server
output_file=$(mktemp)
dotnet run --project osu.Desktop > "$output_file" &
pid=$!

while read line; do
	echo "$line"
	if [[ "$line" =~ "[LocalCachedBeatmapMetadataSource] Local cache fetch completed successfully" ]]; then
		echo "Stopping in 10s..."
		sleep 10
		kill -INT $pid
		break
	fi
done < <(stdbuf -oL tail -f "$output_file")
