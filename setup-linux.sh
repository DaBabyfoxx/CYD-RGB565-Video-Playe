#!/bin/bash
set -e
sudo apt update
sudo apt install -y git ffmpeg python3 python3-venv
python3 -m venv ~/.platformio-venv
~/.platformio-venv/bin/pip install -U platformio
~/.platformio-venv/bin/pio run
~/.platformio-venv/bin/pio run -t upload
