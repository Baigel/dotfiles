#!/bin/bash
echo "Using Master Account Playlists"
cd
cd ~/OneDrive/Music/Baigels_Tunes
rm baigels_tunes.txt
spotdl -f ~/OneDrive/Music/Baigels_Tunes -p https://open.spotify.com/playlist/4rru4z2JcnQXI8CpbFT00j?si=XnKh-IYiSk20vPK_udz8RQ # Get playlist and pass into baigels_tunes.txt
touch downloadedSongs.txt # In case it does not exist
diff -e downloadedSongs.txt baigels_tunes.txt | grep "https" > newSongLinks.txt # Get new songs
cat newSongLinks.txt >> downloadedSongs.txt # Keep a record of all songs in downloadedSongs.txt
spotdl -f ~/OneDrive/Music/Baigels_Tunes --overwrite skip -l newSongLinks.txt # Download songs
rm newSongLinks.txt
cd
onedrive --synchronize
