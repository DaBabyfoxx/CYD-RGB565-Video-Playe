# CYD RGB565 Video Player

A simple RGB565 video player for the ESP32 CYD 2.8" (ESP32-2432S028).

## 1. What you need
- ESP32 CYD 2.8" (ESP32-2432S028)
- microSD card
- USB data cable
- Computer
- A video file

## 2. Download the project
git clone https://github.com/DaBabyfoxx/CYD-RGB565-Video-Playe.git

## 3. Install PlatformIO
Install Visual Studio Code and the PlatformIO IDE extension.

## 4. Open and upload
Open the project in Visual Studio Code, connect the CYD with a USB data cable, then click Upload in PlatformIO.

## 5. Convert your video
Install FFmpeg:

sudo apt update && sudo apt install ffmpeg

Convert your video:

ffmpeg -i "video.mp4" -vf "fps=30,scale=320:240" -pix_fmt rgb565le -f rawvideo "video.rgb565"

## 6. Copy the video to the SD card
Copy the resulting .rgb565 file directly to the root of the microSD card. Do not put it inside a folder.

## 7. Start the player
Insert the microSD card into the CYD and power it on. The player automatically searches for the first .rgb565 file and starts playback.

## 8. Video requirements
- Resolution: 320x240
- Frame rate: 30 FPS
- Pixel format: RGB565
- Format: RAW RGB565

## 9. Built-in SD pins
| Function | GPIO |
|---|---:|
| CS | 5 |
| SCK | 18 |
| MISO | 19 |
| MOSI | 23 |

## 10. TFT pins
| Function | GPIO |
|---|---:|
| SCK | 14 |
| MOSI | 13 |
| MISO | 12 |
| CS | 15 |
| DC | 2 |
| Backlight | 21 |

## Limitations
MP4/H.264 is not decoded directly. Videos must be converted to RAW RGB565 first.

## License
Free to use and modify.
