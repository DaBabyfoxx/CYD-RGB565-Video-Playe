Write-Host "Installing PlatformIO..."
py -m pip install --user platformio
Write-Host "Building project..."
pio run
Write-Host "Connect the CYD and press ENTER to upload."
Read-Host
pio run -t upload
