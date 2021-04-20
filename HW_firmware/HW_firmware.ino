#include <ESP8266WiFi.h> //Including ESP8266 library

const char* ssid     = "DNA-WLAN-2G-B2B0"; //Wifi name
const char* password = "Vekkuli12"; //Wifi password
int LED = 14; //Led pin

unsigned long myTime = 0;
unsigned long oldTime = 0;
unsigned long newTime = 0;
int avg = 0;
int amplitude = 0;
int beat = 0;
float iirNew,iirOld,iirFiltered;
bool situation = true;
float threshold = 0;
float minData = 0;
float maxData = 0;
float x = 0;
float y = 0;
unsigned long testi;

void setup_wifi() { //Wifi setup void
  delay(10);  
  WiFi.mode(WIFI_STA); //Setting wifi mode
  WiFi.begin(ssid, password); //Start connecting wifi

  while (WiFi.status() != WL_CONNECTED) { //Do this while not connected to wifi
   // Serial.println("not connected...");
    digitalWrite(LED, LOW); //Led off
    delay(100); //Blinking led every 200ms
    digitalWrite(LED, HIGH); //Led on
    delay(100);
  }
  //Serial.println("Connected!!");
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: "); // print your WiFi shield's IP address:
  Serial.println(ip);
  digitalWrite(LED, HIGH); //Making sure led is on when connected wifi
}

int bpm(float data){
  if(situation == true){
    if(data >= threshold){
      if(data > maxData){ 
        maxData = data;
        newTime = myTime;
      }}
    else{
      x = maxData;
      testi = newTime - oldTime;
      beat = round(60/((newTime - oldTime)*10^-3));
      Serial.print("aika1: ");
      Serial.print(newTime);
      Serial.print("aika2: ");
      Serial.print(oldTime);
      Serial.print("lasketaan: ");  
      Serial.println(testi);
      oldTime = newTime;
      maxData = 0;
      situation = false;
    }}
  else if(situation == false){
    if(data <= threshold){
      if(data < minData){
        minData = data;
      }
    }
    else{
      y = minData;
      minData = 0;
      situation = true;
    }
  }
  amplitude = (x-y)/2;
  threshold = amplitude/3;
  return beat;
}

float iir_filter(int data){
  avg = 0;
  for(int i=0;i<64;i++){    // 
    avg+=data;
  }
  avg = avg/64;
  iirNew = avg;
  if(iirOld != 0){  
    iirNew = iirOld*0.99+iirNew*0.01;
    iirOld = iirNew;
  }
  else{
    iirOld = iirNew;
  }
  iirFiltered = avg-iirNew;
  return iirFiltered;
}

void setup() {
  Serial.begin(115200); //Setting up the baud speed
  pinMode(LED, OUTPUT); // Setting led as output
  setup_wifi(); //Start setup_wifi void
  
}

void loop() {
  
  myTime = millis();
  bpm(iir_filter(analogRead(A0)));
//  Serial.print(myTime);
//  Serial.print(" ");
//  Serial.println(testi);
  delay(5);
}
