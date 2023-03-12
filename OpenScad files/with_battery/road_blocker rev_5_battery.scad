$fn=90;

use <bat18650_holder_rev2.scad>
use <sg90_servo.scad>
use <screw_holder.scad>
use <US-025A_sensor.scad>
use <smile.scad>
use <Arduino_nano_modify.scad>
use <kcd1-11_switch.scad> // power switch

box_x = 100+30;
box_y = 70;
box_h = 40; // working currently 90
box_width = 2;
corner_x = 8;

header1 = "המחסום של נטע";
//header2 = "המחסום של עידו";
//header = "שגיא";

// for real printing, use "false"
// for debug, use "true", to see how the inner parts fit

// 1: the box to print
// 2: 
// 3: trials
// 4: the box withthe internal
//to_print = 2 ;
//test();
//games();

//corner(ext_pins="false");

print_box(_param=2);
text_vec=[-30,0,0];
print_cover(_t=header1,_t_vec=text_vec);

module print_box(_param) {
    if (_param==1) {
    // print the actual box with Arduino mount & Battery 18650 holder
    // ext_pins: false: holes for production. True: show the pins used. 
    box_to_print(_inner="false",ext_pins="false"); 
    }

    else if(_param==3) {
        // trials
            
        //rotate([180,0,0])
        difference() {
            box_to_print(_inner="false",ext_pins="false"); 
            translate([-70,-43,-30]) cube([200,40,100]);
            translate([-60,30,-0]) cube([120,10,50]);
            } // of difference()    
    } // of if
    else if(_param==4) {
        box_to_print(_inner="true",ext_pins="false"); 

    } // of if
} // of print_box();

module print_cover(_t="my text",_t_vec) {

        // print the cover
            
        rotate([180,0,0])
            difference() {
                translate([0,0,box_h/2+1]) cover_to_print(_text=_t,_t_vec=_t_vec);
                box_to_print(_inner="false",ext_pins="true"); 
            } // of difference()    

} // of print_cover()




// *********************************************
module box_to_print(_inner="false",ext_pins="false") {
    // inner:       to include the non printable inner parts
    // ext_pins:    to create dumy pins up, to make holes for the cover
    // wemos:       wemos board holder 
    // PCB          wemos is mounted to pcb. Connect this pcb to the box.
    
    h_shield     = box_h/2-box_width;
    r_shield_vec = [0,0,-90];
    
    pins_vec = [4,0,-h_shield];
    //t_shield_vec = pins_vec+[0,0,8];  // for Arduino shield ??
    
    us_sensor_vec=[0,0,-box_h/2+20]; // was -30
    servo_vec=[-22,0+0-5,-box_h/4+15]; // was -23
 
    h_delta = -box_h/2+1;
    //bat_vec = [0,-19+3,-box_h/2+1+5];
    bat_vec = [3,16+1,-box_h/2+10];
    bat_rot_vec = [0,0,180];
    //arduino_vec=[10,15,-box_h/2+2];
    arduino_vec=[0,-15,-box_h/2+2+5];

        difference() {        
            union() {
                box(ext_pins);
                translate(arduino_vec) rotate([0,0,90])
                Arduino_nano(_sig_pins_up=1,_sig_pins_down=0,_6_pins_up=0,_6_pins_down=0,_pcb_pins=2);
        
            } // of union
            
            translate(bat_vec+[0,0,0]) rotate (bat_rot_vec)
                18650_shield(_prod=0,_usb=false,_pcb=0);
            
            
            translate(servo_vec) servo();
            
           translate(us_sensor_vec) ultra_sonic();
           rotate([-90,0,-90]) translate([0,-15,64]) smile(_range=40,_size=2);
        } // of difference
        
        translate(bat_vec+[0,0,0]) 18650_shield(_prod=1);
        
    
    if (_inner=="true") {
        // Show the innser parts (servo, US sensor, Arduino)
        // not for real printing, of course
        translate(servo_vec) servo();
        translate(us_sensor_vec) ultra_sonic();
        translate(arduino_vec) rotate([0,0,90])
            Arduino_nano(_sig_pins_up=1,_sig_pins_down=0,_6_pins_up=0,_6_pins_down=0,_pcb_pins=0);
        translate(bat_vec+[0,0,0])  rotate (bat_rot_vec)
            18650_shield(_prod=0);
        //
        //18650_shield;
    } // of IF
    
    
  
} // of box_to_print()



module corner(ext_pins="false") {
    // ext_ins - to add dummy external pins to make a hole in the cover
    cone_h=4;           
    
    if (ext_pins=="true") {
        translate([0,0,box_h/2-cone_h/2+2])
            union() {
                cylinder(d=2,h=8);
                color("red") cylinder(d1=4,d2=2,h=2);
            } // of union()
    } // of if()
    
    difference() {
        cube ([corner_x,corner_x,box_h], center=true);  
        translate([0,0,box_h/2-cone_h/2-7]) #pin_negative(size=2);
        //translate([0,0,box_h/2-cone_h/2-2]) cone();
    } // of difference()
    

    
    module cone() {
        // to make it easy to push the screw holder
        color("red") cylinder(r1=0,r2=2,h=cone_h);
    } // of cone() module
    
} // of corner()

module ultra_sonic() {
    x_shift = box_x/2-box_width-2;
    y_shift = 0;
    h_shift = 4;
    translate ([x_shift,y_shift,h_shift]) rotate([90,180,90])
        US_025A_sensor(); // HC_SR04();
} // of ultra_sonic()

/*
module US_sensor() {
    x_shift = box_x/2-box_width;
    rotate([90,0,90]) translate ([0,0,x_shift-1])
        module_HC_SR04(extractHoles=true);
} //of US_sensor()
*/

module box(ext_pins="false") {
    inner_x = box_x - 2*box_width;
    inner_y = box_y - 2*box_width;
    difference() {
        cube ([box_x,box_y,box_h], center=true);  
        color("red") translate([0,0,box_width]) cube ([inner_x,inner_y,box_h], center=true);
    } // of difference     
    x_shift = box_x/2-corner_x/2;
    y_shift = box_y/2-corner_x/2;
    translate([x_shift,y_shift,0]) corner(ext_pins); // the screw holder
    translate([x_shift,-y_shift,0]) corner(ext_pins);
    translate([-x_shift,y_shift,0]) corner(ext_pins);
    translate([-x_shift,-y_shift,0]) corner(ext_pins);
            
} // of box()



module cover_to_print(_text="texttt",_t_vec) {
    led_cover_d=11.8;// was 12.5;
    cover_h = 2;
    

    header=_text;
    
    font = "Liberation Sans";
    
    
    difference() {
        union() {
            cube ([box_x,box_y,cover_h], center=true);  
            
            translate(_t_vec) translate([-10,-16,0])
                rotate([180,0,0])
                    color("red")
                        linear_extrude(height = 2)                         
                            text(text = header, font = font, size = 10);
            
            //text("OpenSCAD");
        } // of union
        // cut holes for LEDs       
        translate([20,15,-5]) cylinder(d=led_cover_d,h=10);
        translate([-20,15,-5]) cylinder(d=led_cover_d,h=10);
        translate([-50,15-20,5]) rotate([0,0,90]) kcd1_11();
        
    } // of difference()
} // of cover_to_print()


module servo() {
    rotate([-90,0,90]) translate([0,0,29])  sg90_motor();
} // of servo()
