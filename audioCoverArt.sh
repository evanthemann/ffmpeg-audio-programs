#!/bin/bash

# Ask for audio file
read -p "Enter path to audio file (.m4a): " audio

# Ask for image file
read -p "Enter path to image file (cover art): " image

# Ask for output file name (without extension)
read -p "Enter desired output file name (no extension): " outputname

# Get the directory of the input audio file
outputdir=$(dirname "$audio")

# Set full path for output MP3
outputpath="$outputdir/$outputname.mp3"

# Run ffmpeg
ffmpeg -i "$audio" -i "$image" \
  -map 0:a -map 1 \
  -c:a libmp3lame -b:a 192k \
  -id3v2_version 3 \
  -metadata:s:v title="Album cover" \
  -metadata:s:v comment="Cover (front)" \
  "$outputpath"

echo "Saved MP3 with cover art to: $outputpath"
