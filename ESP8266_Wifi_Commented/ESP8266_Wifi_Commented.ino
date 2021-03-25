#include <ESP8266WiFi.h> //Including ESP8266 library

// Update these with values suitable for your network.
const char* ssid     = "wifiName"; //Wifi name
const char* password = "Password"; //Wifi password
int LED = 2; //Led pin

void setup_wifi() { //Wifi setup void
  delay(10);
  // We start by connecting to a WiFi network
  WiFi.mode(WIFI_STA); //Setting wifi mode
  WiFi.begin(ssid, password); //Start connecting wifi

  while (WiFi.status() != WL_CONNECTED) { //Do this while not connected wifi
    digitalWrite(LED, LOW); //Led off
    delay(100); //Blinking led every 200ms
    digitalWrite(LED, HIGH); //Led on
    delay(100);
  }
  digitalWrite(LED, HIGH); //Making sure led is on when connected to wifi
}

void networkStatus(){
  if(WiFi.status() != WL_CONNECTED){
    setup_wifi();
  }
}
void setup() {
  Serial.begin(115200); //Setting up the baud speed
  pinMode(LED, OUTPUT); // Setting led as output
  setup_wifi(); //Run setup_wifi function  
}

void loop() {
  networkStatus();
}
