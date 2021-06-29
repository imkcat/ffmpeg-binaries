#!/bin/bash
docker build -t ffmpeg:linux64 -f Dockerfile.linux64 .
docker run --name ffmpeg-container -d ffmpeg:linux64
mkdir -p ./build/linux64
docker cp ffmpeg-container:/opt/ffmpeg/ffmpeg-4.4/ffplay ./build/linux64/ffplay
docker cp ffmpeg-container:/opt/ffmpeg/ffmpeg-4.4/ffmpeg ./build/linux64/ffmpeg
docker cp ffmpeg-container:/opt/ffmpeg/ffmpeg-4.4/ffprobe ./build/linux64/ffprobe
docker kill ffmpeg-container && docker rm ffmpeg-container
