//Pins on board
int ecgRaw = 0;

/*--------------------------------*/
unsigned long onTime = 0; //time setup
unsigned long time_last = 0;
/*--------------------------------*/
int beat = 0;
bool tila = false;
float raja = 0;

void setup() {
  Serial.begin(115200);
}

float ecg_data(){
  ecgRaw = analogRead(A0);  
  float voltage = (ecgValue * (5.0 / 1023.0));
  return voltage;
}

int heartbeat(){
  if(!tila){
    if(raja > 0.6){
      beat = 60 / ((onTime - time_last)*(10^-3));
      time_last = onTime;
      tila = true;
    }    
  }
  if(tila){
    tila = false;
  }
  return beat;
}

void send_data(float ecg, int bpm){
  Serial.print(onTime);
  Serial.print(" ");
  Serial.print(ecg);
  Serial.print(" ");
  Serial.println(bpm);
}

void loop() {
  onTime = millis();
  send_data(ecg_data(), heartbeat());
  delay(1);
}
