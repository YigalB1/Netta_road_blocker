#include <Arduino.h>
#include <Servo.h>

#define echoPin 2 // attach pin D2 Arduino to pin Echo of HC-SR04
#define trigPin 3 //attach pin D3 Arduino to pin Trig of HC-SR04
#define red_led_pin 12
#define green_led_pin 11

#define GATE_OPEN 0
#define GATE_CLOSED 1
#define CLOSE_DIST 20 // was 7

#define SERVO_OPEN   0
#define SERVO_CLOSE 90

long duration; 
int distance; 


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
      //Serial.print("init_led: ");
      //Serial.println(led_pin);
    }
    void set_led_on() {
        digitalWrite(led_pin,HIGH);
        //Serial.print("Led ON : ");
        //Serial.println(led_pin);
    }
    void set_led_off() {
        digitalWrite(led_pin,LOW);
        //Serial.print("Led OFF : ");
        //Serial.println(led_pin);
    }
}; // of class led


class road_blocker {
  public:
    Led Green_led;
    Led Red_led;
    US_sensor dist_sensor;
    Servo gate_servo;
    int gate_cng_t = 3000; // time (ms) for change gate position
    int gate_steps_n = 90;
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
      gate_servo.attach(servo_pin);
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

    void open_gate() {};

    void cng_gate(int _dir) {
    
      //Serial.println("Opening....");
      //write_servo(SERVO_CLOSE,SERVO_OPEN);
      Led cur_led;
      if (_dir==GATE_CLOSED)
        cur_led = Red_led;
      else
        cur_led = Green_led;

      int t=0; // ms
      int angle = SERVO_OPEN;
      int t_step = gate_cng_t/gate_steps_n;
      int a_step = (SERVO_CLOSE-SERVO_OPEN)/gate_steps_n;
      if (_dir==GATE_CLOSED) {
        Serial.println("Closing....");
        a_step=0-a_step;
        angle = SERVO_CLOSE;
      } // of if()
      else {
        Serial.println(" Opening....");
      }// of else()

      //Serial.print("gate_cng_t:");
      //Serial.println(gate_cng_t);
      //Serial.print("gate_steps_n:");
      //Serial.println(gate_steps_n);
      //Serial.print("t_step:");
      //Serial.println(t_step);
      //Serial.print("a_step:");
      //Serial.println(a_step);
      
      int blink_num=5;
      int blink_jmp=90/blink_num;
      while (t<gate_cng_t) {
        if (angle>0 && angle<blink_jmp) {
            cur_led.set_led_on();
        }
        else if (angle>blink_jmp && angle<blink_jmp*2) {
            cur_led.set_led_off();
        }
        else if (angle>blink_jmp*2 && angle<blink_jmp*3) {
            cur_led.set_led_on();
        }
        else if (angle>blink_jmp*3 && angle<blink_jmp*4) {
            cur_led.set_led_off();
        }
        else if (angle>blink_jmp*4 ) {
            cur_led.set_led_on();
        }

        
        //write_servo(SERVO_CLOSE,SERVO_OPEN,step);
        //Serial.print("/t: ");
        //Serial.print(t);
        //Serial.print(" a: ");
        //Serial.print(angle);
        gate_servo.write(angle);
        wait_millis(t_step);
        t+=t_step; // count towards gate_cng_t in miliseconds
        angle+=a_step;
      } // of while

      



      //digitalWrite(red_led_pin,LOW);
      //digitalWrite(green_led_pin,HIGH);
      //gate_is_opened = true;
      //wait_millis(5000); // wait 5 seconds until next op

      opened_gate = false;
    } // of open_gate()


    void close_gate() {
        // TBD open slowly, according to OpenCLoseTime
      Serial.println("Opening....");
      //write_servo(SERVO_CLOSE,SERVO_OPEN);
      
      int t=0; // ms
      int step = gate_cng_t/gate_steps_n;
      Serial.print("gate_cng_t:");
      Serial.println(gate_cng_t);
      Serial.print("gate_steps_n:");
      Serial.println(gate_steps_n);
      Serial.print("step:");
      Serial.println(step);
      while (t<gate_cng_t) {
        t+=step; // count towards gate_cng_t in miliseconds
        //write_servo(SERVO_CLOSE,SERVO_OPEN,step);
        Serial.print(" ");
        Serial.print(t);
        gate_servo.write(t);
        wait_millis(step);
      } // of while

      



      digitalWrite(red_led_pin,LOW);
      digitalWrite(green_led_pin,HIGH);
      //gate_is_opened = true;
      //wait_millis(5000); // wait 5 seconds until next op

      opened_gate = false;
    } // of close_gate()

    void close_gate1() {
      Serial.print("Closing");
      int step=0;
      write_servo(SERVO_OPEN,SERVO_CLOSE,step);
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


void write_servo(int _angle1,int _angle2,int _step) {
 //int steps = 10;
  int i;
  int inc = int((_angle2-_angle1)/_step);
  int blink_num=3;
  int blink_time = _step/blink_num;
  int blink_cnt=0;

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
    
//int blink_time = _step/blink_num;
//  int blink_cnt=0;



    for(i=_angle1;i<_angle2;i+=inc,blink_cnt++) {
        if ((blink_cnt%blink_time)==0) {
            // time to blink the led
        } 
      Serial.print("<");
      Serial.print(i);
      //Serial.print(">");
      gate_servo.write(i);
      wait_millis(100);
    } // of for()
    gate_servo.write(_angle2); // fix div & int angle
  } // of if()
  else {
    Serial.print("c");
   
    for(i=_angle1;i>_angle2;i+=inc) {
      Serial.print("<");
      Serial.print(i);
      //Serial.print(">");
      gate_servo.write(i);
      wait_millis(50);
    } // of for()
    gate_servo.write(_angle2); // fix div & int angle
  } // of else()
} // of write_servo()

void test_servo() {
    int step=0;
  write_servo(SERVO_OPEN,SERVO_CLOSE,step);
  wait_millis(300);
  write_servo(SERVO_CLOSE,SERVO_OPEN,step);
  wait_millis(300);
  write_servo(SERVO_OPEN,SERVO_CLOSE,step);
} // of test_servo

}; // of road_blocker class


