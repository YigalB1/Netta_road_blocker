// Arduino Wemos based
//#include <Arduino.h>
#include <Servo.h>
#include <ESP8266WiFi.h>
#include <espnow.h>

// for the ESPnow reieved from the TRafic light (Ramzor)
#define RED     1
#define YELLOW  2
#define GREEN   3

#define servo_pin 9
#include <headers.h>

road_blocker my_blocker;

//Servo tmp_servo;

// for ESPnow
typedef struct struct_message {
  // for the ESPnow communication
  // send the red/yellow/green status
  int state; 
} struct_message;

struct_message myData; 

// Callback function that will be executed when data is received
void OnDataRecv(uint8_t * mac, uint8_t *incomingData, uint8_t len) {
  memcpy(&myData, incomingData, sizeof(myData));
  Serial.print("Bytes received: ");
  Serial.println(len);
  Serial.print("Char: ");
  Serial.println(myData.state);
  Serial.println();
}





void setup() {  
  Serial.begin(9600);
  Serial.print("");
  Serial.print("starting SETUP ....");
  
  Serial.println();
  Serial.println(WiFi.macAddress());  
  
  // Set device as a Wi-Fi Station (ESP now)
  WiFi.mode(WIFI_STA);

  // Init ESP-NOW
  if (esp_now_init() != 0) {
    Serial.println("Error initializing ESP-NOW");
    return;
  }

  // Once ESPNow is successfully Init, we will register for recv CB to
  // get recv packer info
  esp_now_set_self_role(ESP_NOW_ROLE_SLAVE);
  esp_now_register_recv_cb(OnDataRecv);


  /* ***
  my_blocker.Green_led.led_pin = green_led_pin;
  my_blocker.Green_led.init_led();
  my_blocker.Red_led.led_pin = red_led_pin;
  my_blocker.Red_led.init_led();
  my_blocker.Yellow_led.led_pin = yellow_led_pin;
  my_blocker.Yellow_led.init_led();
  my_blocker.gate_servo.attach(servo_pin);
  my_blocker.dist_sensor.trig_pin = trigPin;
  my_blocker.dist_sensor.echo_pin = echoPin;
  my_blocker.dist_sensor.init_US_sensor();

  my_blocker.Yellow_led.set_led_on(); // to indicate RESET
    
  #define GATE_OPEN_NEW 90
  #define SERVO_CLOSE1 0
  #define SERVO_CLOSE2 180

  // TBD - to read from extenal switch
  // as for now:
  my_blocker.servo_close =  SERVO_CLOSE1;
  
  //my_blocker.cng_gate_new(my_blocker.servo_close, GATE_OPEN_NEW);
  //my_blocker.gate_status = GATE_OPEN_NEW;

  //my_blocker.cng_gate_new(GATE_OPEN_NEW,my_blocker.servo_close);
  //my_blocker.gate_status = my_blocker.servo_close;

  Serial.println("setup finished");
  wait_millis(1000);
  my_blocker.Yellow_led.set_led_off(); // to indicate RESET

  */ // ***
} // of SETUP

void loop() {
  
 // Serial.print(".");
  // just for ESP now debug:
  return;


  my_blocker.check_sensor();
  Serial.println(" ");
  Serial.print("----------------------------");
  Serial.print(my_blocker.dist_sensor.dist);
  Serial.print(" . ");
  Serial.print(my_blocker.change_it);
  Serial.print(" . ");
  Serial.print(my_blocker.opened_gate);
  Serial.println(" / ");
  delay(100);
  //return;



  if(my_blocker.change_it) {
    // Need to change the gate
    Serial.print("my_blocker.opened: ");
    Serial.println(my_blocker.opened);
    wait_millis(500);
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





 /*
  Serial.println("Servo up");
  for(int i=0;i<180;i+=10) {
    tmp_servo.write(i);
    wait_millis(100);
  }

Serial.println("Servo dpwn");
  wait_millis(1000);

  for(int i=180;i>0;i-=10) {
    tmp_servo.write(i);
    wait_millis(100);
  }
  wait_millis(1000);
*/

//my_blocker.test1_servo();
//wait_millis(1000);
//return;

//return;
/*
  Serial.print(" attached to servo:  ");
  Serial.println(my_blocker.gate_servo.attached());
  Serial.print(" attached to servo:  ");
  Serial.print(my_blocker.gate_servo.read());

  Serial.println(" ");
  Serial.println(" testing LEDs ");
  my_blocker.test_leds(); 
  wait_millis(500);
  //my_blocker.test_sensor();
  my_blocker.Red_led.set_led_on();
  my_blocker.Green_led.set_led_off();
  Serial.println(" testing Servo ");
  my_blocker.test_servo();
  my_blocker.Red_led.set_led_off();
  my_blocker.Green_led.set_led_on();
  wait_millis(500);
  return;
  */