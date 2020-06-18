#!/bin/bash

echo "Starting Chrome-Mute"

while :
do
    sleep 3s
    runningLine=$(pacmd list-sink-inputs | grep -n "state: RUNNING")
    testSourceLine=$((${runningLine:0:1} + 16))
    isSpotifyPlaying=$(pacmd list-sink-inputs | sed -n ${testSourceLine}p | grep -c "Spotify")
    numberOfSources=$(pacmd list-sink-inputs | grep -c "index")

    if (( "$isSpotifyPlaying" == 1 )); then
        echo "Spotify is Playing"
        if (( "$numberOfSources" > 1 )); then
            echo "Multiple Sources are Playing"
            playerctl pause
        else playerctl play
        fi
    else
        if (( "$numberOfSources" > 1 )); then
            echo "Something other than Spotify is Playing"
            playerctl pause
        else playerctl play
    fi fi
done
