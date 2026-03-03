# ffmpeg-audio-programs

A collection of shell scripts for common audio and video tasks using FFmpeg. Each script is interactive and prompts for input files and parameters.

## Scripts

- **audioCoverArt.sh** -- Converts an M4A audio file to MP3 and embeds cover art from an image file.
- **fade_audio.command** -- Applies fade-in and fade-out effects to an audio file. Prompts for fade durations in seconds.
- **generate_avectorscope_video.sh** -- Generates a 1920x1080 MP4 video from an MP3 file with an audio vectorscope visualization.
- **generate_waveform_video.sh** -- Generates a 1920x1080 MP4 video from an MP3 file with a scrolling waveform visualization.
- **song_audio_image_text.sh** -- Creates a music video combining an audio file, a background image, a waveform overlay, and a song title. Outputs a 1920x1080 MP4.
- **trim_audio.command** -- Trims an audio file by specifying a start time and end time in HH:MM:SS format. Preserves the original format.

## Requirements

- FFmpeg and FFprobe
- Bash or a POSIX-compatible shell
- `bc` (used by fade_audio.command for arithmetic)
