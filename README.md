# ffmpeg-binaries

Create [FFmpeg](https://ffmpeg.org/) binaries(ffmpeg, ffprobe, ffplay) for all platforms(Windows, macOS, Linux)

## Getting Started

### How to build

Run the shell script `make.sh` with specified platform: `win64`, `macos64`, `linux64`.

To build Windows binaries:

```bash
./make.sh win64
```

The binary files will output to `./binaries` path:

- `./binaries/win64` Binary files
- `./binaries/win64.zip` Binary files package

## Credits

- Windows binaries from [https://www.gyan.dev/ffmpeg/](https://www.gyan.dev/ffmpeg/)
- macOS binaries from [https://evermeet.cx/ffmpeg/](https://evermeet.cx/ffmpeg/)
