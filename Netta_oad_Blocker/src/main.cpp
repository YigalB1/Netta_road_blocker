#include <Arduino.h>
#include <Servo.h>

#define echoPin 2 // attach pin D2 Arduino to pin Echo of HC-SR04
#define trigPin 3 //attach pin D3 Arduino to pin Trig of HC-SR04
#define red_led 12
#define green_led 11
#define servo_pin 9

#define GATE_OPEN 0
#define GATE_CLOSED 1
#define CLOSE_DIST 20 // was 7

#define SERVO_OPEN   0
#define SERVO_CLOSE 90

long duration; 
int distance; 
int read_US_sensor();
Servo myservo;  
int pos = 0; 
//int state = GATE_CLOSED;
bool gate_is_opened = false;
bool change = true;

void write_servo(int _angle1,int _angle2);
void wait_millis(int _period_ms);

void setup() {
  Serial.begin(9600);
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin, INPUT); 
  pinMode(red_led, OUTPUT);
  pinMode(green_led, OUTPUT);
  // light leds as a sanity check
  digitalWrite(red_led,HIGH);
  digitalWrite(green_led,HIGH);
  delay(500);
  digitalWrite(red_led,LOW);
  digitalWrite(green_led,LOW);

   myservo.attach(servo_pin);

  write_servo(SERVO_OPEN,SERVO_CLOSE);
  wait_millis(300);
  write_servo(SERVO_CLOSE,SERVO_OPEN);
  wait_millis(300);
  write_servo(SERVO_OPEN,SERVO_CLOSE);

  //Serial.println("setup finished");
}


void loop() {
  /*
  Serial.println("close to open");
  write_servo(SERVO_CLOSE,SERVO_OPEN);
  wait_millis(2000);
  Serial.println("open to close");
  write_servo(SERVO_OPEN,SERVO_CLOSE);
  wait_millis(20000);
  return;
*/

  Serial.print(".");
  //Serial.print(gate_is_opened);
  //Serial.print("$");
  distance = read_US_sensor();
  //Serial.println(distance);
  //delay(500);
  //return;

  

  if (distance>0 && distance< CLOSE_DIST) {
    Serial.print(distance);
    Serial.print("...");
    
    if(gate_is_opened) {
      Serial.print("Closing");
      write_servo(SERVO_OPEN,SERVO_CLOSE);
      digitalWrite(red_led,HIGH);
      digitalWrite(green_led,LOW);
      gate_is_opened = false;
      wait_millis(5000); // wait 5 seconds until next op
    } else {
      Serial.print("Opening");
      write_servo(SERVO_CLOSE,SERVO_OPEN);
      digitalWrite(red_led,LOW);
      digitalWrite(green_led,HIGH);
      gate_is_opened = true;
      wait_millis(5000); // wait 5 seconds until next op
    }
  wait_millis(500);

  } // of if() 
  wait_millis(50); // sample 20 times a second

} // of loop()

int read_US_sensor() {
  int dist;
  
  //ool wait_for_state_change = false;
  //bool valid_closed = false;
  //bool valid_open = false;

  // Clears the trigPin condition
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  // Sets the trigPin HIGH (ACTIVE) for 10 microseconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10); // was 10. should be 50??
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH,2350000UL); // for 40 cm max
  //Serial.print("...");
  //Serial.print(duration);
  dist = duration * 0.034 / 2; // Speed of sound wave divided by 2 (go and back)
  //Serial.print(".....");
  //Serial.println(dist);

  return dist;
} // of read_US_sensor()

void write_servo(int _angle1,int _angle2) {
  int steps = 10;
  int i;
  int inc = int((_angle2-_angle1)/steps);

  Serial.print(_angle1);
  Serial.print("/");
  Serial.print(_angle2);
  Serial.print("/");
  Serial.println(inc);

  if (_angle1==_angle2) {
    Serial.print("a");
    return;
  }
  if (_angle2>_angle1) {
    Serial.print("b");
    
    for(i=_angle1;i<_angle2;i+=inc) {
      Serial.print("<");
      Serial.print(i);
      //Serial.print(">");
      myservo.write(i);
      wait_millis(100);
    } // of for()
    myservo.write(_angle2); // fix div & int angle
  } // of if()
  else {
    Serial.print("c");
   
    for(i=_angle1;i>_angle2;i+=inc) {
      Serial.print("<");
      Serial.print(i);
      //Serial.print(">");
      myservo.write(i);
      wait_millis(50);
    } // of for()
    myservo.write(_angle2); // fix div & int angle
  } // of else()

} // of write_servo

void wait_millis(int _period_ms) {
  unsigned long time_now = millis();
  //Serial.print(" # "); 
  //Serial.print(time_now); 
  //Serial.print(" # "); 
  //Serial.print(_period_ms); 
  //Serial.print("#"); 

  while(millis() < time_now+_period_ms);
  //Serial.print(millis()); 
  //Serial.println("#"); 
} // of wait_millis

