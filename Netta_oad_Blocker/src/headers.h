

#define echoPin 2 // attach pin D2 Arduino to pin Echo of HC-SR04
#define trigPin 3 //attach pin D3 Arduino to pin Trig of HC-SR04
#define red_led_pin 12
#define green_led_pin 11


#define GATE_OPEN 0
#define GATE_CLOSED 1
#define CLOSE_DIST 20 // was 7

#define SERVO_OPEN   0
#define SERVO_CLOSE 90



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


class US_sensor {
    public:
    int trig_pin;
    int echo_pin;
    int dist;
    
    
    void init_US_sensor() {
      pinMode(trig_pin, OUTPUT);
      pinMode(echo_pin, INPUT);
    }

    void read_US_sensor() {           
      // Clears the trigPin condition
      digitalWrite(trigPin, LOW);
      delayMicroseconds(2);
      // Sets the trigPin HIGH (ACTIVE) for 10 microseconds
      digitalWrite(trigPin, HIGH);
      delayMicroseconds(10); // was 10. should be 50??
      digitalWrite(trigPin, LOW);
      duration = pulseIn(echoPin, HIGH,2350000UL); // for 40 cm max
      dist = duration * 0.034 / 2; // Speed of sound wave divided by 2 (go and back)
  } // of read_US_sensor() 
}; // of class US_sensor

class Led {
    public:
    int led_pin;
    
    void init_led() {
      pinMode(led_pin, OUTPUT);
      Serial.print("init_led: ");
      Serial.println(led_pin);
    }
    void set_led_on() {
        digitalWrite(led_pin,HIGH);
        Serial.print("Led ON : ");
        Serial.println(led_pin);
    }
    void set_led_off() {
        digitalWrite(led_pin,LOW);
        Serial.print("Led OFF : ");
        Serial.println(led_pin);
    }
}; // of class led


class road_blocker {
  public:
    Led Green_led;
    Led Red_led;
    US_sensor dist_sensor;
    Servo myservo;
    bool opened_gate = false; // current status of the gate
    bool change_it = false;  // chnage the gate from open to close or from close to open


    void init11() {
      Serial.println(" In Init ");
      Green_led.led_pin = green_led_pin;
      Green_led.init_led();
      Red_led.led_pin = red_led_pin;
      Red_led.init_led();
      dist_sensor.echo_pin = echoPin;
      dist_sensor.trig_pin = trigPin;
      dist_sensor.init_US_sensor();
      myservo.attach(servo_pin);
      opened_gate = false;
      close_gate();
    }

    void check_sensor() {
      dist_sensor.read_US_sensor();        
      
      if (dist_sensor.dist>0 && dist_sensor.dist< CLOSE_DIST) {
        change_it = true;
        Serial.println("");
        Serial.print(" within if, change it is now true. dist_sensor.dist:  ");
        Serial.println(dist_sensor.dist);
      } // of if()
    } // of open_gate()

    void open_gate() {
      Serial.print("Opening");
      write_servo(SERVO_CLOSE,SERVO_OPEN);
      digitalWrite(red_led_pin,LOW);
      digitalWrite(green_led_pin,HIGH);
      //gate_is_opened = true;
      wait_millis(5000); // wait 5 seconds until next op

      opened_gate = false;
    } // of open_gate()

    void close_gate() {
      Serial.print("Closing");
      write_servo(SERVO_OPEN,SERVO_CLOSE);
      digitalWrite(red_led_pin,HIGH);
      digitalWrite(green_led_pin,LOW);
      //gate_is_opened = false;
      wait_millis(5000); // wait 5 seconds until next op
      opened_gate = true;
    } // of open_gate()

    void test_sensor() {   
      
      for (int i=0;i<20;i++) {
        dist_sensor.read_US_sensor();        
        Serial.println(dist_sensor.dist);
        delay (250);
      }
    } // of test_sensor

    void test_leds() {
      int blink_delay = 500;
      for (int i=0;i<5;i++) {
        Green_led.set_led_on();
        Red_led.set_led_off();
        delay(blink_delay);
        Green_led.set_led_off();
        Red_led.set_led_on();
        delay(blink_delay);
      } // of for loop
    } // of test_leds()


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
} // of write_servo()

void test_servo() {
  write_servo(SERVO_OPEN,SERVO_CLOSE);
  wait_millis(300);
  write_servo(SERVO_CLOSE,SERVO_OPEN);
  wait_millis(300);
  write_servo(SERVO_OPEN,SERVO_CLOSE);
} // of test_servo

}; // of road_blocker class

