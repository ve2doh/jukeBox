#include <Arduino.h>
#include <SoftwareSerial.h>
#include <DYPlayerArduino.h>

const int SoftRx = 10;
const int SoftTx = 11;
const int busyPin = 9;

#define BUF_LENGTH 128
#define PLAY_LIST_LENGTH 100

static bool do_echo = true;
unsigned int playlist[PLAY_LIST_LENGTH];
int currentSong = 0;
int lastSong = 0;

void readAndExecuteCommand();
void exec(char *cmdline);
void status();
void addSong(int songNumber);
void startNextSong();
void monitorPlayList();

// Initialise on software serial port.
SoftwareSerial SoftSerial(SoftRx, SoftTx);
DY::Player player(&SoftSerial);

void setup() {
  player.begin();
  Serial.begin(9600);

  pinMode(busyPin, OUTPUT);
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, LOW);

  player.setVolume(30); // 50% Volume
}

void loop() {
  readAndExecuteCommand();
  monitorPlayList();

  if(player.checkPlayState()==DY::PlayState::Playing)
    digitalWrite(LED_BUILTIN, HIGH);
  else
    digitalWrite(LED_BUILTIN, LOW);

  delay(500);
  
}

void readAndExecuteCommand(){
    while (Serial.available()) {
        static char buffer[BUF_LENGTH];
        static int length = 0;

        int data = Serial.read();
        if (data == '\b' || data == '\177') {  // BS and DEL
            if (length) {
                length--;
                if (do_echo) Serial.write("\b \b");
            }
        }
        else if (data == '\r') {
            if (do_echo) Serial.write("\r\n");    // output CRLF
            buffer[length] = '\0';
            if (length) exec(buffer);
            length = 0;
        }
        else if (length < BUF_LENGTH - 1) {
            buffer[length++] = data;
            if (do_echo) Serial.write(data);
        }
    }
}

/* Execute a complete command. */
void exec(char *cmdline) {
    char *command = strsep(&cmdline, " ");

    if (strcmp_P(command, PSTR("help")) == 0) {
        Serial.println(F(
            "status: current status\r\n"
            "playsong <id>: Play a sound file by number\r\n"
            "stop: stop playing\r\n"
            "add <number>: add song at end of play list\r\n"
            "next: play next song\r\n"
            "echo <value>: set echo off (0) or on (1)"));
    } else if (strcmp_P(command, PSTR("status")) == 0) {

        status();

    } else if (strcmp_P(command, PSTR("stop")) == 0) {

      player.stop();
      
    } else if (strcmp_P(command, PSTR("playsong")) == 0) {

      int songNumber = atoi(cmdline);
      Serial.print("play song number: ");
      Serial.println(songNumber);      
      player.playSpecified(songNumber);

    } else if (strcmp_P(command, PSTR("add")) == 0) {

            int songNumber = atoi(cmdline);
            addSong(songNumber);
                  
      
    } else if (strcmp_P(command, PSTR("next")) == 0) {

      startNextSong();

    } else if (strcmp_P(command, PSTR("echo")) == 0) {
        do_echo = atoi(cmdline);
    } else {
        Serial.print(F("Error: Unknown command: "));
        Serial.println(command);
    }
}

void status(){
  Serial.print("current module play state: ");
  Serial.println((int16_t)player.checkPlayState());

  
  Serial.print("Playing sound: ");
  Serial.println((int16_t)player.getPlayingSound());

  Serial.print("busy status: ");
  Serial.println((int16_t)digitalRead(busyPin));

  Serial.println("play list status: ");
  
  Serial.print("current song: ");
  Serial.println(currentSong);
  Serial.print("last song: ");
  Serial.println(lastSong);
  
  Serial.println("--------------------------------");
  
  Serial.print("  ");
  for(int incr=0; incr<PLAY_LIST_LENGTH ;incr++) {
    if(incr==currentSong) Serial.print("C");
    if(incr==lastSong) Serial.print("L");
    Serial.print((int16_t)playlist[incr]);
    Serial.print("   ");
  }
  Serial.println("");
  
  Serial.println("--------------------------------");
  
}

void startNextSong(){
      if(currentSong==lastSong) {
        Serial.println("no next song");
      } else {
        currentSong = (currentSong+1)%PLAY_LIST_LENGTH;
        unsigned songNumber = playlist[currentSong];
        player.playSpecified(songNumber);
  
        Serial.print("play song number: ");
        Serial.println(songNumber);      
      
        Serial.print("new current song: ");
        Serial.println(currentSong);      
      }  
}

void addSong(int songNumber){
      lastSong=(lastSong+1)%PLAY_LIST_LENGTH;
      playlist[lastSong]=songNumber;

      Serial.print("new last song number: ");
      Serial.println(lastSong);  
}

void monitorPlayList(){
 DY::play_state_t playState = player.checkPlayState();
 bool song2Play =  currentSong!=lastSong;
 if(playState!=DY::PlayState::Playing && song2Play) startNextSong();
}
