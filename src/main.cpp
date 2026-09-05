#include <Arduino.h>
#include <SPI.h>
#include <SD.h>
#include <Adafruit_GFX.h>
#include <Adafruit_ILI9341.h>

#define TFT_CS 15
#define TFT_DC 2
#define TFT_RST -1

SPIClass lcdSPI(HSPI);
Adafruit_ILI9341 tft(&lcdSPI, TFT_DC, TFT_CS, TFT_RST);

uint16_t line[320];

String findVideo() {
  File root = SD.open("/");
  if (!root) return "";

  File f = root.openNextFile();

  while (f) {
    if (!f.isDirectory()) {
      String name = f.name();
      name.toLowerCase();

      if (name.endsWith(".rgb565")) {
        String result = f.name();
        f.close();
        root.close();
        return result;
      }
    }

    f.close();
    f = root.openNextFile();
  }

  root.close();
  return "";
}

void playVideo(String filename) {
  File video = SD.open(String("/") + filename, FILE_READ);
  if (!video) return;

  tft.startWrite();
  tft.setAddrWindow(0, 0, 320, 240);

  while (video.available()) {
    for (int y = 0; y < 240; y++) {
      size_t got = video.read((uint8_t*)line, 640);

      if (got != 640) {
        video.seek(0);
        break;
      }

      tft.writePixels(line, 320, true);
    }
  }

  tft.endWrite();
  video.close();
}

void setup() {
  Serial.begin(115200);

  pinMode(21, OUTPUT);
  digitalWrite(21, HIGH);

  lcdSPI.begin(14, 12, 13, 15);
  tft.begin(40000000);
  tft.setRotation(1);
  tft.fillScreen(ILI9341_BLACK);

  SPI.begin(18, 19, 23, 5);

  if (!SD.begin(5, SPI, 20000000)) {
    tft.setTextColor(ILI9341_RED);
    tft.setTextSize(2);
    tft.setCursor(10, 20);
    tft.println("SD FAIL");
    return;
  }

  String video = findVideo();

  if (video == "") {
    tft.setTextColor(ILI9341_RED);
    tft.setTextSize(2);
    tft.setCursor(10, 20);
    tft.println("NU AM GASIT VIDEO");
    return;
  }

  Serial.print("VIDEO: ");
  Serial.println(video);

  playVideo(video);
}

void loop() {
  String video = findVideo();

  if (video != "") {
    playVideo(video);
  }
}
