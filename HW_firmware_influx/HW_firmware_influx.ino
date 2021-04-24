#include <ESP8266WiFi.h> //Including ESP8266 library
#include <InfluxDbClient.h>

#define DEVICE "ESP8266"
// WiFi AP SSID
#define WIFI_SSID "DNA-WLAN-2G-B2B0"
// WiFi password
#define WIFI_PASSWORD "Vekkuli12"
//const char* ssid     = "DNA-WLAN-2G-B2B0"; //Wifi name
//const char* password = "Vekkuli12"; //Wifi password
// InfluxDB v2 server url, e.g. https://eu-central-1-1.aws.cloud2.influxdata.com (Use: InfluxDB UI -> Load Data -> Client Libraries)
#define INFLUXDB_URL "http://192.168.1.101:8086"
// InfluxDB v2 server or cloud API authentication token (Use: InfluxDB UI -> Data -> Tokens -> <select token>)
#define INFLUXDB_TOKEN "lpdGK1n0Mdce9t9auJ9nvPH4YSDSlnFLGTUESkxe6HosLjHGIsadzakVhHgTtPHOGqRMwHqdgqHWHv0SFPblpg=="
// InfluxDB v2 organization id (Use: InfluxDB UI -> User -> About -> Common Ids )
#define INFLUXDB_ORG "intproject"
// InfluxDB v2 bucket name (Use: InfluxDB UI ->  Data -> Buckets)
#define INFLUXDB_BUCKET "ecgdb"

//  Central Europe: "CET-1CEST,M3.5.0,M10.5.0/3"
#define TZ_INFO "CET-1CEST,M3.5.0,M10.5.0/3"

// InfluxDB client instance with preconfigured InfluxCloud certificate
InfluxDBClient client(INFLUXDB_URL, INFLUXDB_ORG, INFLUXDB_BUCKET, INFLUXDB_TOKEN);

// Data point
Point sensor("heart_rate");

int LED = 14; //Led pin

unsigned long myTime = 0;
unsigned long firstPeak = 0;
unsigned long secondPeak = 0;
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
bool calc = true;

void setup_wifi() { //Wifi setup void
  delay(10);  
  WiFi.mode(WIFI_STA); //Setting wifi mode
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD); //Start connecting wifi

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

void setup_influx(){
      // Add tags, these are constant fields in database
  sensor.addTag("device", DEVICE);
  //sensor.addTag("SSID", WiFi.SSID());

  timeSync(TZ_INFO, "pool.ntp.org", "time.nis.gov");
  
  if (client.validateConnection()) {
    Serial.print("Connected to InfluxDB: ");
    Serial.println(client.getServerUrl());
  } else {
    Serial.print("InfluxDB connection failed: ");
    Serial.println(client.getLastErrorMessage());
  }
}

int bpm(float data, unsigned long aika){
  
  if(situation){
    if(data >= threshold && data > maxData){
        maxData = data; 
        if(calc){
          firstPeak = aika;}
        if(!calc){
          secondPeak = aika;}}    
    else{
      x = maxData;
      if(calc){
        beat = round(60/((firstPeak - secondPeak)*10^-3));
        calc = false;
      }
      if(calc == false){
        beat = round(60/((secondPeak - firstPeak)*10^-3));
        calc = true;
      }
      maxData = 0;
      situation = false;
    }}
  if(!situation){
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
  return 12;
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

void send_data(float piezo, unsigned long timeStamp/*, int bpm*/){
  // Clear fields for reusing the point. Tags will remain untouched
  sensor.clearFields();

  // Store measured value into point
  sensor.addField("ecgValue", piezo);
  //sensor.addField("bpm", bpm)
  sensor.addField("timeValue", timeStamp);

  // Print what are we exactly writing
  Serial.print("Writing: ");
  Serial.println(sensor.toLineProtocol());

  // If no Wifi signal, try to reconnect it
//  while (WiFi.status() != WL_CONNECTED) {
//    Serial.println("Wifi connection lost");
//  }

  // Write point
  if (!client.writePoint(sensor)) {
    Serial.print("InfluxDB write failed: ");
    Serial.println(client.getLastErrorMessage());
  }
}

void setup() {
  Serial.begin(115200); //Setting up the baud speed
  pinMode(LED, OUTPUT); // Setting led as output
  setup_wifi(); //Start setup_wifi void
  setup_influx(); // influx connection
}

void loop() {
  
  myTime = millis();
  Serial.print(myTime);
  //bpm(iir_filter(analogRead(A0)), myTime);
  //Serial.print(myTime);
  Serial.print(" ");
  Serial.println(iir_filter(analogRead(A0)));
  send_data(iir_filter(analogRead(A0)), myTime);
  delay(78);
}
