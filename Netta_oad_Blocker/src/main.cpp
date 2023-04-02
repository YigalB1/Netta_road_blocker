#include <Arduino.h>
#include <Servo.h>
#define servo_pin 9

long duration; 
int distance; 

//#include <headers.h>




//int read_US_sensor();
//Servo myservo;  
//int pos = 0; 
//int state = GATE_CLOSED;
//bool gate_is_opened = false;
//bool change = true;

//void write_servo(int _angle1,int _angle2);

//road_blocker my_blocker;
Servo gate_servo;


void setup() {
  
  Serial.begin(9600);
  Serial.print("");
  Serial.print("starting SETUP ....");
  //my_blocker.Green_led.led_pin = green_led_pin;
  //my_blocker.Green_led.init_led();
  //my_blocker.Red_led.led_pin = red_led_pin;
  //my_blocker.Red_led.init_led();
  //my_blocker.myservo.attach(servo_pin);
  gate_servo.attach(servo_pin);
  

  Serial.println("Ending SETUP");
  //my_blocker.test_leds();
  //my_blocker.test_sensor();
   //myservo.attach(servo_pin);
  //Serial.println("setup finished");
} // of SETUP

void loop() {
  //return;

  //while (true) {  
  //my_blocker.myservo.write(0);
  //Serial.println("");
  Serial.println(".0.");
  delay(100);
  gate_servo.write(0);
    delay(500);
  //my_blocker.myservo.write(90);
  
  Serial.println(".90.");
  gate_servo.write(90);
  delay(500);
  Serial.println(".180.");
  gate_servo.write(180);
  delay(500);
  Serial.println(".90.");
  gate_servo.write(90);
  delay(500);
  //my_blocker.test_servo();

  //return;
//}
  /*

  Serial.print(".");
  my_blocker.check_sensor();
  if (my_blocker.change_it) {
    my_blocker.change_it = false; 
    if (my_blocker.opened_gate) {
      Serial.println("in loop, closing gate");
      my_blocker.close_gate(); // gate was opend - close it
    } // of inneer if
    else {
      my_blocker.open_gate(); // gate was closed - open it
      Serial.println("in loop, opening gate");
    } // if else
  } // of outer if
  //Serial.print(gate_is_opened);
  //Serial.print("$");
  //my_blocker.dist_sensor.read_US_sensor();
  //Serial.println(distance);
  //delay(500);
  return;

  

  wait_millis(50); // sample 20 times a second
*/
} // of loop()

