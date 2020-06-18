#!/bin/bash
echo "Using Servant Account Playlists"
cd
cd ~/OneDrive/Music/20162
spotdl -f ~/OneDrive/Music/20162 -p https://open.spotify.com/playlist/7jcNg4LorExM9wNfSzudKL?si=JcP34ALDQVqaol_3ZJXdLA
spotdl -f ~/OneDrive/Music/20162 --overwrite skip -l 2016_2.txt
cd
cd ~/OneDrive/Music/20171
spotdl -f ~/OneDrive/Music/20171 -p https://open.spotify.com/playlist/2gNeZyvZUNwgRR8RZ0TJhf?si=m_c8BE5NTgm0Vt4E_kFNvw
spotdl -f ~/OneDrive/Music/20171 --overwrite skip -l 2017_1.txt
cd
cd ~/OneDrive/Music/20172
spotdl -f ~/OneDrive/Music/20172 -p https://open.spotify.com/playlist/3dXOOhV0630KUbv03QB1p7?si=xVRupPAiQH60UxXUOh7zNA
spotdl -f ~/OneDrive/Music/20172 --overwrite skip -l 2017_2.txt
cd
cd ~/OneDrive/Music/20181
spotdl -f ~/OneDrive/Music/20181 -p https://open.spotify.com/playlist/2A6uTYGNd4epkW9BfvlnEq?si=WyaZan9nSZuF2GaZuxkCkA
spotdl -f ~/OneDrive/Music/20181 --overwrite skip -l 2018_1.txt
cd
rm ~/20162
rm ~/20171
rm ~/20172
rm ~/20181
# So on and so forth
