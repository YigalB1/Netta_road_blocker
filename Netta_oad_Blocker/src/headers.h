
#define echoPin 2 //  pin D2 to pin Echo of HC-SR04
#define trigPin 3 //  pin D3 to pin Trig of HC-SR04
#define red_led_pin 12
#define yellow_led_pin 11
#define green_led_pin 10


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
    } // of init_US_sensor()

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
        digitalWrite(led_pin,LOW);
        //Serial.print("Led ON : ");
        //Serial.println(led_pin);
    }
    void set_led_off() {
        digitalWrite(led_pin,HIGH);
        //Serial.print("Led OFF : ");
        //Serial.println(led_pin);
    }
}; // of class led


class road_blocker {
  public:
    Led Green_led;
    Led Red_led;
    Led Yellow_led;
    US_sensor dist_sensor;
    Servo gate_servo;
    int gate_cng_t = 3150; // time (ms) for change gate position
    int gate_steps_n = 90;
    bool opened_gate = false; // current status of the gate
    bool change_it = false;  // chnage the gate from open to close or from close to open
    bool opened;  // the status if the gate true: opened. false: closed
  int servo_close = 777;


void test1_servo() {

  Serial.println("Servo up");
  for(int i=0;i<180;i+=10) {
    gate_servo.write(i);
    wait_millis(100);
  }

  Serial.println("Servo down");
  wait_millis(500);

  for(int i=180;i>0;i-=10) {
    gate_servo.write(i);
    wait_millis(100);
  }
  wait_millis(500);

} // of test1_servo

    void check_sensor() {
      dist_sensor.read_US_sensor();        
      
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

      Serial.print(" in cng_gate_new. From: ");
      Serial.print(_from);
      Serial.print("   to:   ");
      Serial.println(_to);

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


      int blnk_cycle = 10;
      int blnk_on = 3;
      
      if (_to>_from) {
        //Serial.print(" UP  "); 
        for(int i=_from;i<= _to;i++) {
          
          if (i%blnk_cycle<blnk_on) {
            // light the LED from 0-2
            cur_led.set_led_on();
          } // of if()
          else {
            // shut the LED
            cur_led.set_led_off();
          } // of else()
//          Serial.print("  writing to servo:  ");
//          Serial.print(i);  
          gate_servo.write(i);
          delay(SERVO_DELAY);
        } // of for()
      } // of if()
      else{
        Serial.print(" DOWN ");
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

    if (opened) {
      Green_led.set_led_on();
    }
    else {
      Red_led.set_led_on();
    }
      

      Serial.print("   Ending cng_gate_new()    ");
    } // of cng_gate_new() - should replace the current

// -------------------------------------------------


    void cng_gate(int _dir) {
    
        // make sure both LEDs are off
        Green_led.set_led_off();
        Red_led.set_led_off();
      //Serial.println("Opening....");
      //write_servo(SERVO_CLOSE,SERVO_OPEN);
      Led cur_led;
      if (_dir==GATE_CLOSED)
        cur_led = Red_led;
      else
        cur_led = Green_led;

      Serial.print("_dir:");
      Serial.println(_dir);
      Serial.print("cur_led pin: ");  
      Serial.println(cur_led.led_pin);  

      //int t=0; // ms
      int angle = SERVO_OPEN;
      int t_step = gate_cng_t/gate_steps_n;
      //int a_step = gate_steps_n/(SERVO_CLOSE-SERVO_OPEN);
      int servo_step = 1;

      if (_dir==GATE_CLOSED) {
        Serial.println("Closing....");
        //a_step=0-a_step;
        angle = SERVO_CLOSE;
        servo_step = -1;
      } // of if()
      else if (_dir==GATE_OPEN) {
        Serial.println(" Opening 1....");
        angle = SERVO_OPEN;
      }// of else if()
      else {
        Serial.println(" Opening 2....");
        angle = SERVO_SIDE2;
        //a_step=0-a_step;
        servo_step = -1;
      } // of else()

      //Serial.print("gate_cng_t:");
      //Serial.println(gate_cng_t);
      //Serial.print("gate_steps_n:");
      //Serial.println(gate_steps_n);
      //Serial.print("t_step:");
      //Serial.println(t_step);

      
      int blink_num=4;
      int blink_jmp=90/blink_num;
      Serial.print(" xxx ");
      Serial.print(angle);
      Serial.println("  ");
      //Serial.println(a_step);
      
      //t=0; // ms
      int cnt=0;
      //int stp = gate_cng_t/blink_num;
      //bool cng = true;
      int i=0;

      Serial.print("xx: t_step ");
      Serial.print(t_step);
      Serial.print(" gate_cng_t: ");
      Serial.println(gate_cng_t);
      Serial.print(" angle: ");
      Serial.println(angle);

      
      
      while (cnt<gate_cng_t) {
        gate_servo.write(angle);

        i=cnt/blink_jmp;
        if (i%2==0)
        {
          cur_led.set_led_on();
        } // of if()
        else {
          cur_led.set_led_off();
        } // of else()
        
        //cnt+=blink_jmp;
        wait_millis(50);

        //Serial.print("... angle: ");
        //Serial.print(angle);
        //Serial.print(" . cnt: ");
        //Serial.print(cnt);

        angle+=servo_step;
        cnt+=t_step; // count towards gate_cng_t in miliseconds
      } // of while(


      Serial.print(" final angle: ");
      Serial.println(angle);
        
       // make sure both LEDs are off
        Green_led.set_led_off();
        Red_led.set_led_off();
        // light the current LED
        cur_led.set_led_on();
    } // of cng_gate()

    void test_sensor() {         
      for (int i=0;i<20;i++) {
        dist_sensor.read_US_sensor();        
        Serial.println(dist_sensor.dist);
        delay (250);
      }// of for() loop 
    } // of test_sensor

    void test_leds() {
      int blink_delay = 500;
      for (int i=0;i<5;i++) {
        Green_led.set_led_on();
        Red_led.set_led_off();
        Yellow_led.set_led_on();
        delay(blink_delay);
        Green_led.set_led_off();
        Red_led.set_led_on();
        Yellow_led.set_led_off();
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

  Serial.print("... GATE_OPEN_NEW: ");
  Serial.print(GATE_OPEN_NEW);
  Serial.print("   ... servo_close: ");
  Serial.println(servo_close);
  cng_gate_new(GATE_OPEN_NEW,servo_close);
  wait_millis(500);
  cng_gate_new(servo_close,GATE_OPEN_NEW);
  wait_millis(500);

  return;


    int step=30; // Must be non-Zero
  write_servo(SERVO_OPEN,SERVO_CLOSE,step);
  wait_millis(1000);
  write_servo(SERVO_CLOSE,SERVO_OPEN,step);
  wait_millis(1000);
  write_servo(SERVO_OPEN,SERVO_CLOSE,step);
  wait_millis(1000);
} // of test_servo

}; // of road_blocker class


