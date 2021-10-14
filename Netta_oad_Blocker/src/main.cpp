#include <Arduino.h>
#include <Servo.h>

#define echoPin 2 // attach pin D2 Arduino to pin Echo of HC-SR04
#define trigPin 3 //attach pin D3 Arduino to pin Trig of HC-SR04
#define red_led 12
#define green_led 11

#define GATE_OPEN 0
#define GATE_CLOSED 1
#define CLOSE_DIST 7

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

int p_dist = 101; // p: short for prev
int p_p_dist = 102;
int p_p_p_dist = 103;


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

   myservo.attach(9);

   myservo.write(0);
   delay(500);
   myservo.write(90);
   delay(500);
   myservo.write(0);
   delay(500);

  Serial.println("setup finished");
}

bool c1 = false; // close dist last
bool c2 = false; // close dist prev
bool c3 = false; // close dist prev prev
bool c4 = false; // close dist prev prev prev
bool f1 = false; // far dist last
bool f2 = false; // far dist prev
bool f3 = false; // far dist prev prev
bool f4 = false; // far dist prev prev prev
bool wait_period = false; // 3 readings of far to allow new change of gate state

void loop() {
  distance = read_US_sensor();

  
  //Serial.print(p_dist);
  //Serial.print(" ");
  //Serial.print(p_p_dist);
  //Serial.print(" ");
  //Serial.print(p_p_p_dist);
  //Serial.print("        // State: ");
  //Serial.println(gate_is_opened);

  c1 = distance < CLOSE_DIST;
  f1 = !c1;

  /*
  Serial.print(c1);
  Serial.print(" ");
  Serial.print(c2);
  Serial.print(" ");
  Serial.print(c3);
  Serial.print(" ");
  Serial.print(c4);
  Serial.print("  //  ");
  Serial.print(f1);
  Serial.print(" ");
  Serial.print(f2);
  Serial.print(" ");
  Serial.print(f3);
  Serial.print(" ");
  Serial.print("  //  ");
  Serial.print(wait_period);
  Serial.print(" ");
  //Serial.print(change); // change is up and down before this point
  Serial.print("  //  ");
  Serial.print(distance);
  Serial.println();
  */
  
  if (f2 && f3 && f4) {
    // last 3 readings were far, so gate can change again
    wait_period = true;
  } // of if()
  if (c1 && c2 && c3 && c4 && wait_period ) {
    gate_is_opened = !gate_is_opened;
    change = true;
    wait_period = false;
  } // of if

  //if (distance<CLOSE_DIST && p_dist<CLOSE_DIST && p_p_dist<CLOSE_DIST && p_p_p_dist>CLOSE_DIST ) {
  //  // if 3 "close" readings followed one "far" read - we treat this is a state change
  //  gate_is_opened = !gate_is_opened;
  //  change = true;
  //} // of  IF


  if (change) {
    if ( gate_is_opened ) {      
      myservo.write(SERVO_OPEN);
      digitalWrite(red_led,LOW);
      digitalWrite(green_led,HIGH);
      Serial.println("open gate");
    } // of IF
    else {
      myservo.write(SERVO_CLOSE);
      digitalWrite(red_led,HIGH);
      digitalWrite(green_led,LOW);
      Serial.println("close gate");
    } // of ELSE        
    change = false;
  }

  c4=c3;
  c3=c2;
  c2=c1;
  f4=f3;
  f3=f2;
  f2=f1;
  //p_p_p_dist = p_p_dist;
  //p_p_dist = p_dist;
  //p_dist = distance;



  /*
  //Serial.print("  ");
  //Serial.println(distance);
  if (distance <50)
    myservo.write(0);
  else
    myservo.write(180);
  */

  delay(100); 

  
  
}

int read_US_sensor() {
  int dist = 100;
  
  //ool wait_for_state_change = false;
  //bool valid_closed = false;
  //bool valid_open = false;

  // Clears the trigPin condition
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  // Sets the trigPin HIGH (ACTIVE) for 10 microseconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  dist = duration * 0.034 / 2; // Speed of sound wave divided by 2 (go and back)

  return dist;
} // of read_US_sensor()