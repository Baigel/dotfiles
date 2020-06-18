#!/bin/bash
echo "Using Master Account Playlists"
cd
cd ~/OneDrive/Music/Baigels_Tunes
spotdl -f ~/OneDrive/Music/Baigels_Tunes -p https://open.spotify.com/playlist/4rru4z2JcnQXI8CpbFT00j?si=t-liaCq1RFi68k-zawH-Ww
spotdl -f ~/OneDrive/Music/Baigels_Tunes --overwrite skip -l baigels_tunes.txt
cd
cd ~/OneDrive/Music/Old_School_Goodies
spotdl -f ~/OneDrive/Music/Old_School_Goodies -p https://open.spotify.com/playlist/1yRCUzdzPxtDFPotpt9EBb?si=ePtEq6z-Sxa1hpzzU2gwDw
spotdl -f ~/OneDrive/Music/Old_School_Goodies --overwrite skip -l old-school-goodies.txt
cd
cd ~/OneDrive/Music/2000s
spotdl -f ~/OneDrive/Music/2000s -p https://open.spotify.com/playlist/02xlb0sEJBjOrydLU7N1NC?si=NQ4-4w67Rj2opGt0rlbGXw
spotdl -f ~/OneDrive/Music/2000s --overwrite skip -l 2000s.txt
onedrive
rm ~/20162
rm ~/20171
rm ~/20172
rm ~/20181
