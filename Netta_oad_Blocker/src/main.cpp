#include <Arduino.h>

void setup() {
  Serial.begin(9600);
}
int cnt = 0;
void loop() {
  Serial.println(cnt);
  delay(1000); 

  // put your main code here, to run repeatedly:
}