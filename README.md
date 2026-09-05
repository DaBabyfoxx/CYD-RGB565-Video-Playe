# CYD RGB565 Video Player

A simple RGB565 video player for the **ESP32 CYD 2.8" (ESP32-2432S028)**.

It plays `320x240` RGB565 video files directly from the board's built-in microSD card slot.

## Features

- ESP32 CYD 2.8" display
- ILI9341 TFT — 320x240
- Built-in microSD card slot
- Automatically finds the first `.rgb565` video file
- Continuous video playback
- No external SD card module required

## SD Card

Place your RGB565 video directly in the root of the microSD card:

    /video.rgb565

The file does not have to be named `video.rgb565`. The player automatically searches for the first file ending in `.rgb565`.

## Convert MP4 to RGB565

Install FFmpeg:

    sudo apt install ffmpeg

Convert a video to the format required by the player:

    ffmpeg -i "video.mp4" -vf "fps=30,scale=320:240" -pix_fmt rgb565le -f rawvideo "video.rgb565"

Then copy `video.rgb565` directly to the root of the microSD card.

## PlatformIO

Open the project with PlatformIO and upload the firmware to your ESP32.

Main source file:

    src/main.cpp

## Pin Configuration

### ILI9341 TFT

| Function | GPIO |
|---|---:|
| SCK | 14 |
| MOSI | 13 |
| MISO | 12 |
| CS | 15 |
| DC | 2 |
| Backlight | 21 |

### Built-in microSD

| Function | GPIO |
|---|---:|
| CS | 5 |
| SCK | 18 |
| MISO | 19 |
| MOSI | 23 |

## Compatible Hardware

Tested on:

**ESP32-2432S028 CYD 2.8"**

Display:

**ILI9341 — 320x240**

## Limitations

The video must be converted to RAW RGB565 before playback.

This project does not directly decode MP4/H.264 files on the ESP32.

The display resolution is 320x240.

## License

This project is provided for free use and modification.
