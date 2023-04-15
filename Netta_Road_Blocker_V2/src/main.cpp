//#include <Arduino.h>
#include <Servo.h>
#include <headers.h>

#define red_led_pin 15
#define green_led_pin 12
#define servo_pin 14

#define echoPin 4 //  pin D1  of the Wemos
#define trigPin 5 //  pin D2 of the wemos


road_blocker my_blocker;

void setup() {
  Serial.begin(9600);
  Serial.print("");
  Serial.print("starting SETUP ....");
  my_blocker.Green_led.led_pin = green_led_pin;
  my_blocker.Green_led.init_led();
  my_blocker.Red_led.led_pin = red_led_pin;
  my_blocker.Red_led.init_led();
  my_blocker.gate_servo.attach(servo_pin);
  my_blocker.servo_close =  SERVO_CLOSE1;
  my_blocker.dist_sensor.init_US_sensor(trigPin,echoPin);

  //my_blocker.test_leds();
  //my_blocker.test_sensor();

 
 

/*
  while(true) {
    Serial.print(".");
    wait_millis(200);
  } // of while()
*/

  my_blocker.test_servo_full_move();
  


  //Serial.print("Open");
  //my_blocker.cng_gate_new(my_blocker.servo_close, GATE_OPEN_NEW);
  //my_blocker.cng_gate_new(GATE_OPEN_NEW,my_blocker.servo_close);
  //Serial.print("Open");
  //my_blocker.cng_gate_new(my_blocker.servo_close, GATE_OPEN_NEW);
  //Serial.print("Open");

}
void loop(){

  
  my_blocker.check_sensor();
  //Serial.println("");
  //Serial.print("// ");
  //Serial.print(my_blocker.dist_sensor.dist);
  //Serial.print(" // ");
  //Serial.print(my_blocker.change_it);

  if(my_blocker.change_it) {
    // Need to change the gate 
    //Serial.println(" changing gate. ");

    //Serial.print("my_blocker.opened: ");
    //Serial.print(my_blocker.opened);
    //Serial.print("  GATE_OPEN_NEW: ");
    //Serial.print(GATE_OPEN_NEW);
    //Serial.print("  my_blocker.servo_close: ");
    //Serial.print(my_blocker.servo_close);
    //Serial.print();
    if (my_blocker.opened) {
      //Serial.println(" if1 ");
      // gate was opened - close it
      my_blocker.cng_gate_new(GATE_OPEN_NEW,my_blocker.servo_close);
    }// of internal if()
    else {
      //Serial.println(" else1 ");
      // gate was closed - open it
      my_blocker.cng_gate_new(my_blocker.servo_close, GATE_OPEN_NEW);
    } // end else()
  my_blocker.change_it = false; 
  } // of external if()

  //Serial.println("end loop");
  wait_millis(1000);
  
}
