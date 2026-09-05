#!/bin/bash
set -e

echo "=== CYD RGB565 VIDEO PLAYER ==="

sudo apt update
sudo apt install -y git ffmpeg python3 python3-venv

if [ ! -d ".pio-venv" ]; then
    python3 -m venv .pio-venv
fi

./.pio-venv/bin/python -m pip install -U pip platformio

echo
echo "=== BUILD ==="
./.pio-venv/bin/pio run

echo
echo "Conecteaza CYD prin USB."
read -r -p "Apasa ENTER pentru upload..."

./.pio-venv/bin/pio run -t upload

echo
echo "=== CONVERSIE VIDEO ==="
read -r -p "Scrie calea catre fisierul MP4: " VIDEO

if [ ! -f "$VIDEO" ]; then
    echo "Fisierul nu exista."
    exit 1
fi

ffmpeg -y -i "$VIDEO" \
-vf "fps=30,scale=320:240" \
-pix_fmt rgb565le \
-f rawvideo video.rgb565

echo
echo "GATA!"
echo "Fisier creat: video.rgb565"
echo
read -r -p "Calea cardului SD (ENTER pentru a sari): " SD

if [ -n "$SD" ]; then
    cp video.rgb565 "$SD/"
    echo "video.rgb565 a fost copiat pe SD."
fi

echo
echo "=== TERMINAT ==="
