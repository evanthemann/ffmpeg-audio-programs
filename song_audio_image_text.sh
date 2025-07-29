#!/bin/bash

# Ask for user input
read -p "Enter the path to the audio file: " audio_file
read -p "Enter the path to the image file: " image_file
read -p "Enter the song title: " song_title
output_file="${audio_file%.*}_waveform.mp4"

# Escape apostrophes in the song title
safe_title=$(echo "$song_title" | sed "s/'/'\\\\''/g")

echo $safe_title

# Create a temporary file for the song title
echo "$song_title" > safetitle.txt

# Get the duration of the audio file
duration=$(ffprobe -i "$audio_file" -show_entries format=duration -v quiet -of csv="p=0")
# duration=${duration%.*}  # Convert to integer

# Run ffmpeg
ffmpeg -y -i "$audio_file" -loop 1 -t "$duration" -i "$image_file" -filter_complex "
[0:a]showwaves=s=1920x1080:colors=cyan[v1];
[v1]format=rgba,geq=r='p(X,Y)':g='p(X,Y)':b='p(X,Y)':a='255'[v2];


color=c=black:s=1920x1080:d=$duration[bg];

[1:v]scale=-1:400[art];
[bg][v2]overlay=0:300:shortest=1[v3];
[v3][art]overlay=(W-w)/2:(H-h)/2-100:shortest=1[v4];

[v4]drawtext=fontfile='/System/Library/Fonts/Supplemental/Arial Black.ttf':textfile='safetitle.txt':fontcolor=white:fontsize=50:x=(w-text_w)/2:y=820[v]
" -map "[v]" -map "0:a" -c:v libx264 -c:a aac -pix_fmt yuv420p -profile:v high -level:v 4.0 "$output_file"

# Remove the temporary title file
rm safetitle.txt

echo "✅ Video saved as: $output_file"
