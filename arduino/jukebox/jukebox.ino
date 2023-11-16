#include <Arduino.h>
#include <SoftwareSerial.h>
#include <DYPlayerArduino.h>

// https://grobotronics.com/images/companies/1/datasheets/DY-SV5W%20Voice%20Playback%20ModuleDatasheet.pdf?1559812879320
// https://github.com/SnijderC/dyplayer#void-dydyplayerplayspecifieddevicepath

const int SoftRx = 10;
const int SoftTx = 11;
const int busyPin = 9;

// Initialise on software serial port.
SoftwareSerial SoftSerial(SoftRx, SoftTx);
DY::Player player(&SoftSerial);

void setup() {
  player.begin();
  Serial.begin(9600);

  pinMode(busyPin, OUTPUT);

  char path[] = "/00001.MP3";
  player.playSpecifiedDevicePath(DY::Device::Flash, path);
  
  player.setVolume(30); // 50% Volume
  //player.setVolume(15); // 50% Volume
  //player.setCycleMode(DY::PlayMode::Repeat); // Play all and repeat.
  player.play();
}

void loop() {

  // Print the number of the sound that is playing.

  Serial.print("current module play state: ");
  Serial.println((int16_t)player.checkPlayState());

  
  Serial.print("Playing sound: ");
  Serial.println((int16_t)player.getPlayingSound());

  Serial.print("busy status: ");
  Serial.println((int16_t)digitalRead(busyPin));
  
  delay(500);
}
