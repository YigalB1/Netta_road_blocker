
#define servo_pin 9
#include <headers.h>

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
  
  
  //my_blocker.test_leds();
  //my_blocker.test_sensor();

  my_blocker.cng_gate(GATE_OPEN);
  wait_millis(400);
  my_blocker.cng_gate(GATE_CLOSED);
  wait_millis(400);
  my_blocker.cng_gate(GATE_SIDE2);
  wait_millis(400);

  
  
  Serial.println("setup finished");
  
} // of SETUP

void loop() {
  
  my_blocker.check_sensor();
  Serial.println(" ");
  Serial.print("----------------------------");
  Serial.print(my_blocker.dist_sensor.dist);
  Serial.print(" . ");
  Serial.print(my_blocker.change_it);
  Serial.print(" . ");
  Serial.print(my_blocker.opened_gate);
  Serial.print(" / ");
  
  delay(300);
  if(my_blocker.change_it) {
    // Time to change the gate
    if (my_blocker.opened_gate) {
      // gate was opened - close it
      my_blocker.cng_gate(GATE_CLOSED);
      my_blocker.opened_gate = false;
    }// of if()
    else {
      // gate was closed - open it
      my_blocker.cng_gate(GATE_OPEN);
      my_blocker.opened_gate = true;
    } // end else()
  my_blocker.change_it = false;
  } // of if()

  //Serial.println("end loop");
  wait_millis(3000);

  //my_blocker.cng_gate(GATE_OPEN);
  //wait_millis(2000);
  //my_blocker.cng_gate(GATE_CLOSED);
  //wait_millis(2000);
  //return;

  //while (true) {  
  //my_blocker.myservo.write(0);
  //Serial.println("");
  
  /*
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
*/
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

