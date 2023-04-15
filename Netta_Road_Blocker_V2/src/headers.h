


#define GATE_OPEN 0
#define GATE_CLOSED 1
#define GATE_SIDE2  2

#define GATE_CLOSE1 0
#define GATE_CLOSE2 0

#define CLOSE_DIST 20 // was 7

#define SERVO_OPEN   0
#define SERVO_CLOSE 90
#define SERVO_SIDE2 180

// new 
#define GATE_OPEN_NEW 90
#define SERVO_CLOSE1 0
#define SERVO_CLOSE2 180
#define SERVO_DELAY 50


#define DIR_DOWN  -1
#define DIR_UP  1


long duration; 
int distance; 

// Position    | angle | t_stp | angle change
// Servo Open  |  0    |  +    | 0   -> 90
// Servo Close | 90    |  -    | 90  ->  0
// Servo Side2 | 180   |  -    | 180 -> 90


void wait_millis(int _period_ms) {
  unsigned long time_now = millis();
  while(millis() < time_now+_period_ms);
} // of wait_millis


class US_sensor {
    public:
    int trig_pin;
    int echo_pin;
    int dist;
    
    
    void init_US_sensor(int _trig,int _echo) {
        trig_pin = _trig;
        echo_pin = _echo;
        pinMode(trig_pin, OUTPUT);
        pinMode(echo_pin, INPUT);
    }

    void read_US_sensor(int _trig,int _echo) {           
      // Clears the trigPin condition
      digitalWrite(_trig, LOW);
      delayMicroseconds(2);
      // Sets the trigPin HIGH (ACTIVE) for 10 microseconds
      digitalWrite(_trig, HIGH);
      delayMicroseconds(10); // was 10. should be 50??
      digitalWrite(_trig, LOW);
      duration = pulseIn(_echo, HIGH,2350000UL); // for 40 cm max
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
    int gate_cng_t = 3150; // time (ms) for change gate position
    int gate_steps_n = 90;
    bool opened_gate = false; // current status of the gate
    bool change_it = false;  // chnage the gate from open to close or from close to open
    bool opened;  // the status if the gate true: opened. false: closed

  
  int servo_close = 777;



    void check_sensor() {
      dist_sensor.read_US_sensor(dist_sensor.trig_pin ,dist_sensor.echo_pin);        
      
      if (dist_sensor.dist>0 && dist_sensor.dist< CLOSE_DIST) {
        change_it = true;
        Serial.println("");
        Serial.print(" within if, change it is now true. dist_sensor.dist:  ");
        Serial.println(dist_sensor.dist);
      } // of if()
    } // of open_gate()

    //void open_gate() {};


// -------------------------------------------------
    void cng_gate_new(int _from,int _to) {
      // make sure both LEDs are off
      Green_led.set_led_off();
      Red_led.set_led_off();
      //bool opening; // opening the ggate or close it
      //Serial.println(" in cng_gate_new:");

      Led cur_led;
      if (_from==GATE_OPEN_NEW) {
        // closing
        //opening=false;
        cur_led = Red_led;
        opened = false;
      } // of if()
      else {
        // opening
        //opening=true;
        cur_led = Green_led;
        opened = true;
      } // of else()


      //Serial.print(" _from:");
      //Serial.print(_from);
      //Serial.print(" to: ");  
      //Serial.print(_to);
      //Serial.print(" opened: ");  
      //Serial.println(opened);

      int blnk_cycle = 10;
      int blnk_on = 3;
      
      if (_to>_from) {
        //Serial.print(" UP "); 
        for(int i=_from;i<= _to;i++) {
          //Serial.print(" ");
          //Serial.print(i);
          if (i%blnk_cycle<blnk_on) {
            // light the LED from 0-2
            cur_led.set_led_on();
          } // of if()
          else {
            // shut the LED
            cur_led.set_led_off();
          } // of else()
          gate_servo.write(i);
          delay(SERVO_DELAY);
        } // of for()
      } // of if()
      else{
        //Serial.print(" DOWN ");
          for(int i=_from;i>= _to;i--) {
            //Serial.print(" ");
            //Serial.print(i);
            if (i%blnk_cycle>blnk_cycle-blnk_on) {
            // light the LED, from 7-9
            cur_led.set_led_on();
          } // of if()
          else {
            // shut the LED
            cur_led.set_led_off();
          } // of else()
            gate_servo.write(i);
            delay(SERVO_DELAY);
        } // of for()
      } // of else()

    if (opened)
      Green_led.set_led_on();
    else
      Red_led.set_led_on();
      
    } // of cng_gate_new() - should replace the current

// -------------------------------------------------
    

    void test_sensor() {   
      
      for (int i=0;i<20;i++) {
        dist_sensor.read_US_sensor(dist_sensor.trig_pin,dist_sensor.echo_pin);        
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



void test_servo_full_move() {
    int i=666;
    int prev_i=0; 
    for (i=0;i<=180;i+=40) {
    cng_gate_new(prev_i, i);
    Serial.print(" ");
    Serial.print(i);
    prev_i = i;
    wait_millis(300);
  } // of for()

    prev_i = 180;
    for (i=180;i>=0;i-=40) {
    cng_gate_new(prev_i, i);
    Serial.print(" ");
    Serial.print(i);
    prev_i = i;
    wait_millis(300);
  } // of for()
  wait_millis(2000);
} // of test_servo_full_move



}; // of road_blocker class


