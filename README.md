# CYD RGB565 Video Player

ESP32-2432S028 (CYD) RGB565 video player using the built-in microSD card.

## Linux

Run:

    ./setup-linux.sh

## Windows

Open PowerShell in the project folder and run:

    Set-ExecutionPolicy -Scope Process Bypass
    .\setup-windows.ps1

## Convert MP4 to RGB565

Linux and Windows:

    ffmpeg -i input.mp4 -vf "fps=30,scale=320:240" -pix_fmt rgb565le -f rawvideo video.rgb565

Copy video.rgb565 to the root of the microSD card.

## Video

- Resolution: 320x240
- FPS: 30
- Format: RGB565

The ESP32 automatically finds a .rgb565 file on the SD card and plays it repeatedly.

## Hardware

TFT: SCK GPIO14, MOSI GPIO13, MISO GPIO12, CS GPIO15, DC GPIO2, BL GPIO21

Built-in SD: SCK GPIO18, MISO GPIO19, MOSI GPIO23, CS GPIO5

No external SD module is required.
