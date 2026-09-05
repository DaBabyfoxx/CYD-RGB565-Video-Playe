# CYD RGB565 Video Player

Un player video simplu pentru **ESP32 CYD 2.8" (ESP32-2432S028)**.

Redă videoclipuri `RGB565` de **320×240** direct de pe cardul microSD integrat al plăcii.

## Caracteristici

- ESP32 CYD 2.8"
- Display ILI9341 320×240
- Card microSD integrat
- Caută automat primul fișier `.rgb565` de pe card
- Redare continuă în buclă
- Nu este nevoie de un modul SD extern

## Structura cardului SD

Pune videoclipul direct în rădăcina cardului:

    /video.rgb565

Numele nu trebuie neapărat să fie `video.rgb565`. Playerul caută automat primul fișier care se termină în `.rgb565`.

## Conversie MP4 → RGB565

Instalează FFmpeg:

    sudo apt install ffmpeg

Pentru un videoclip 320×240:

    ffmpeg -i "video.mp4" -vf "fps=30,scale=320:240" -pix_fmt rgb565le -f rawvideo "video.rgb565"

Apoi copiază `video.rgb565` direct pe cardul microSD.

## PlatformIO

Deschide proiectul în PlatformIO și încarcă firmware-ul pe ESP32.

Fișierul principal este:

    src/main.cpp

## Pinii folosiți

### TFT ILI9341

| Funcție | GPIO |
|---|---:|
| SCK | 14 |
| MOSI | 13 |
| MISO | 12 |
| CS | 15 |
| DC | 2 |
| Backlight | 21 |

### microSD integrat

| Funcție | GPIO |
|---|---:|
| CS | 5 |
| SCK | 18 |
| MISO | 19 |
| MOSI | 23 |

## Compatibilitate

Testat pe:

**ESP32-2432S028 CYD 2.8"**

Display:

**ILI9341 — 320×240**

## Limitări

Videoclipul trebuie convertit înainte în format RAW RGB565.

ESP32-ul nu decodează direct videoclipuri MP4/H.264 în acest proiect.

Rezoluția afișată este 320×240.

## Licență

Acest proiect este oferit pentru utilizare și modificare liberă.
