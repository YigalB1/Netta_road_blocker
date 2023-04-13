
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
  my_blocker.dist_sensor.init_US_sensor();

  // TBD - to read from extenal switch
  // as for now:
  my_blocker.servo_close =  SERVO_CLOSE1;
  
  
  
  #define GATE_OPEN_NEW 90
  #define SERVO_CLOSE1 0
  #define SERVO_CLOSE2 180
  
  
  my_blocker.cng_gate_new(my_blocker.servo_close, GATE_OPEN_NEW);
  //my_blocker.gate_status = GATE_OPEN_NEW;

  my_blocker.cng_gate_new(GATE_OPEN_NEW,my_blocker.servo_close);
  //my_blocker.gate_status = my_blocker.servo_close;

  Serial.println("setup finished");
} // of SETUP

void loop() {
  my_blocker.test_sensor();
  return;
  
  my_blocker.check_sensor();
  //Serial.println(" ");
  //Serial.print("----------------------------");
  //Serial.print(my_blocker.dist_sensor.dist);
  //Serial.print(" . ");
  //Serial.print(my_blocker.change_it);
  //Serial.print(" . ");
  //Serial.print(my_blocker.opened_gate);
  //Serial.print(" / ");
  
  //delay(50);
  if(my_blocker.change_it) {
    // Need to change the gate
    Serial.print("my_blocker.opened: ");
    Serial.println(my_blocker.opened);
    Serial.print("GATE_OPEN_NEW: ");
    Serial.println(GATE_OPEN_NEW);
    Serial.print("my_blocker.servo_close");
    Serial.println(my_blocker.servo_close);
    //Serial.print();

    if (my_blocker.opened) {
      Serial.println("if1");
      // gate was opened - close it
      //my_blocker.cng_gate(GATE_CLOSED);
      //my_blocker.opened_gate = false;
      my_blocker.cng_gate_new(GATE_OPEN_NEW,my_blocker.servo_close);

    }// of if()
    else {
      Serial.println("else1");
      // gate was closed - open it
      //my_blocker.cng_gate(GATE_OPEN);
      //my_blocker.opened_gate = true;

      my_blocker.cng_gate_new(my_blocker.servo_close, GATE_OPEN_NEW);
    } // end else()
  my_blocker.change_it = false;
  } // of if()

  //Serial.println("end loop");
  wait_millis(3000);


} // of loop()

