#!/bin/bash

# PLAYLIST_URL must be set (can get url by right clicking spotify playlist -> Share -> Copy Playlist Link
# Should also replace playlist_name.txt with a meaningful name (or not; its up to you)

PLAYLIST_URL=""

cd ~/Music
spotdl -f ~/Music/playlist_name -p PLAYLIST_URL # Get playlist and pass into playlist_name.txt
touch downloadedSongs.txt # In case it does not exist
diff -e downloadedSongs.txt playlist_name.txt | grep "https" > newSongLinks.txt # Get new songs
cat newSongLinks.txt >> downloadedSongs.txt # Keep a record of all songs in downloadedSongs.txt
spotdl -f ~/Music/playlist_name.txt --overwrite skip -l newSongLinks.txt # Download songs
rm newSongLinks.txt
cd
