#include <WiFiNINA.h>
#include <FirebaseArduino.h>

#define FIREBASE_HOST "traffic-light-f4a2e-default-rtdb.asia-southeast1.firebasedatabase.app"
#define FIREBASE_AUTH "AIzaSyAcCjgQssCY4CiMKmQK2r0IS146dH2H4HA"
#define WIFI_SSID "Agam's iPhone"
#define WIFI_PASSWORD "AgamAgarwal"

const int redLED = 5;
const int greenLED = 6;
const int yellowLED = 7;

void setup() {
  Serial.begin(9600);
  pinMode(redLED, OUTPUT);
  pinMode(greenLED, OUTPUT);
  pinMode(yellowLED, OUTPUT);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("Connected to WiFi");

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.setString("/leds/red", "off");
  Firebase.setString("/leds/green", "off");
  Firebase.setString("/leds/yellow", "off");
}

void loop() {
  String redState = Firebase.getString("/leds/red");
  String greenState = Firebase.getString("/leds/green");
  String yellowState = Firebase.getString("/leds/yellow");

  digitalWrite(redLED, redState == "on" ? HIGH : LOW);
  digitalWrite(greenLED, greenState == "on" ? HIGH : LOW);
  digitalWrite(yellowLED, yellowState == "on" ? HIGH : LOW);

  delay(100);
}
