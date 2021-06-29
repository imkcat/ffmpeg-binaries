#!/bin/bash
function install_requirements() {
    sudo apt install p7zip-full curl
}

function win64() {
    rm -rf ./downloads/win64*
    curl https://www.gyan.dev/ffmpeg/builds/packages/ffmpeg-${ffmpeg_version}-full_build.7z -o ./downloads/win64.7z
    7z x ./downloads/win64.7z -o./downloads/win64
    rm -rf ./binaries/win64
    mkdir -p ./binaries/win64
    cp ./downloads/win64/ffmpeg-${ffmpeg_version}-full_build/bin/* ./binaries/win64/
}

function macos64() {
    rm -rf ./downloads/macos64-*
    curl https://evermeet.cx/ffmpeg/ffmpeg-${ffmpeg_version}.7z -o ./downloads/macos64-ffmpeg.7z
    curl https://evermeet.cx/ffmpeg/ffprobe-${ffmpeg_version}.7z -o ./downloads/macos64-ffprobe.7z
    curl https://evermeet.cx/ffmpeg/ffplay-${ffmpeg_version}.7z -o ./downloads/macos64-ffplay.7z
    7z x ./downloads/macos64-ffmpeg.7z -o./downloads/macos64-ffmpeg
    7z x ./downloads/macos64-ffprobe.7z -o./downloads/macos64-ffprobe
    7z x ./downloads/macos64-ffplay.7z -o./downloads/macos64-ffplay
    rm -rf ./binaries/macos64
    mkdir -p ./binaries/macos64
    cp ./downloads/macos64-ffmpeg/ffmpeg ./binaries/macos64/ffmpeg
    cp ./downloads/macos64-ffprobe/ffprobe ./binaries/macos64/ffprobe
    cp ./downloads/macos64-ffplay/ffplay ./binaries/macos64/ffplay
}

function linux64() {
    docker build -t ffmpeg:linux64 -f Dockerfile.linux64 .
    docker run --name ffmpeg-container -d ffmpeg:linux64
    rm -rf ./binaries/linux64
    mkdir -p ./binaries/linux64
    docker cp ffmpeg-container:/opt/ffmpeg/ffmpeg-${ffmpeg_version}/ffplay ./binaries/linux64/ffplay
    docker cp ffmpeg-container:/opt/ffmpeg/ffmpeg-${ffmpeg_version}/ffmpeg ./binaries/linux64/ffmpeg
    docker cp ffmpeg-container:/opt/ffmpeg/ffmpeg-${ffmpeg_version}/ffprobe ./binaries/linux64/ffprobe
    docker kill ffmpeg-container && docker rm ffmpeg-container
}

platform=$1
ffmpeg_version=`cat ffmpeg-version`

if [[ $platform != "win64" && $platform != "macos64" && $platform != "linux64" ]]; then
    echo "Invalid input"
    exit
fi

mkdir -p ./downloads

if [[ $platform = "win64" ]]; then
    win64
elif [[ $platform = "macos64" ]]; then
    macos64
elif [[ $platform = "linux64" ]]; then
    linux64
fi
