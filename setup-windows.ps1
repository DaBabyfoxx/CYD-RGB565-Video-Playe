$ErrorActionPreference = "Stop"

Write-Host "=== CYD RGB565 VIDEO PLAYER ==="

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget nu este disponibil."
    Write-Host "Instaleaza Git, Python si FFmpeg, apoi ruleaza scriptul din nou."
    exit 1
}

Write-Host "Instalez Git..."
winget install --id Git.Git -e --source winget --accept-source-agreements --accept-package-agreements

Write-Host "Instalez Python..."
winget install --id Python.Python.3.13 -e --source winget --accept-source-agreements --accept-package-agreements

Write-Host "Instalez FFmpeg..."
winget install --id Gyan.FFmpeg -e --source winget --accept-source-agreements --accept-package-agreements

Write-Host "Instalez PlatformIO..."

if (-not (Test-Path ".pio-venv")) {
    py -m venv .pio-venv
}

.\.pio-venv\Scripts\python.exe -m pip install -U pip platformio

Write-Host ""
Write-Host "=== BUILD ==="

.\.pio-venv\Scripts\pio.exe run

Write-Host ""
Write-Host "Conecteaza CYD prin USB."
Read-Host "Apasa ENTER pentru upload"

.\.pio-venv\Scripts\pio.exe run -t upload

Write-Host ""
Write-Host "=== CONVERSIE VIDEO ==="

$Video = Read-Host "Scrie calea catre fisierul MP4"

if (-not (Test-Path $Video)) {
    Write-Host "Fisierul nu exista."
    exit 1
}

ffmpeg -y -i "$Video" -vf "fps=30,scale=320:240" -pix_fmt rgb565le -f rawvideo video.rgb565

Write-Host ""
Write-Host "GATA!"
Write-Host "Fisier creat: video.rgb565"

$SD = Read-Host "Scrie litera cardului SD, exemplu E: (ENTER pentru a sari)"

if ($SD -ne "") {
    Copy-Item "video.rgb565" "$SD\"
    Write-Host "video.rgb565 a fost copiat pe SD."
}

Write-Host ""
Write-Host "=== TERMINAT ==="
