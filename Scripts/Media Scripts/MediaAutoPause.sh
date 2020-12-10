#!/bin/bash

echo "Starting Chrome-Mute"

if [[ $# -le 0 ]]; then
	threshold=1
	echo "Setting default threshold to $threshold"
else
	threshold=$1
	echo "Setting threshold to $threshold"
fi

while :
do
	# Add busy wait (reduce computational load)
	sleep 1s

	# Use pacmd to find numgber of sources currently playing
	echo "Detecting number of sources"
	runningLine=$(pacmd list-sink-inputs | grep -n "state: RUNNING")
	testSourceLine=$((${runningLine:0:1} + 16))]
	numberOfSources=$(pacmd list-sink-inputs | grep -c "index")
	echo "$numberOfSources sources found"
	# Legacy code used to detect if spotify was playing
	#isSpotifyPlaying=$(pacmd list-sink-inputs | sed -n ${testSourceLine}p | grep -c "Spotify")

	if (( "$numberOfSources" > $threshold )); then
		echo "Threshold limit exceeded (number of sources > $threshold)"
		echo "Sending pause"
		playerctl pause
	else
		echo "Sending play"
		playerctl play
	fi
done
