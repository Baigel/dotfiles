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
    sleep 1s
    runningLine=$(pacmd list-sink-inputs | grep -n "state: RUNNING")
    testSourceLine=$((${runningLine:0:1} + 16))
    isSpotifyPlaying=$(pacmd list-sink-inputs | sed -n ${testSourceLine}p | grep -c "Spotify")
    numberOfSources=$(pacmd list-sink-inputs | grep -c "index")

    if (( "$isSpotifyPlaying" == $threshold )); then
        echo "Spotify is Playing"
        if (( "$numberOfSources" > $threshold )); then
            echo "Multiple Sources are Playing"
            playerctl pause
        else playerctl play
        fi
    else
        if (( "$numberOfSources" > $threshold )); then
            echo "Something other than Spotify is Playing"
            playerctl pause
        else playerctl play
    fi fi
done
