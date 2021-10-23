$fn=90;
include <servos.scad>
//include <Arduino_nano.scad>
//include <HC_SR04.scad>
//include <Wemos holder.scad>
//include <Arduino_shield_base.scad>
include <screw_holder.scad>
include <US-025A_sensor.scad>
include <Wemos_holder.scad>
include<smile.scad>
use <wemos_d1_mini_clip_rev_3.scad>

box_x = 100;
box_y = 70;
box_h = 40; // working currently 90
box_width = 2;
corner_x = 6;

// for real printing, use "false"
// for debug, use "true", to see how the inner parts fit

to_print = 2; // 1: the box, 2: the cover
//wemos_and_pins();

//test();



module test() {
    // only for testting
         
   difference() {
        box_to_print(inner="false",ext_pins="false"); 
        translate([-30,0,0]) color("blue") cube([50,80,50],center=true);
        translate([ 50,0,0]) color("blue") cube([50,80,50],center=true);
        translate([ 10,-10,38]) color("blue") cube([50,100,40],center=true);
       translate([ 10,33,5]) color("blue") cube([50,10,40],center=true);
    } // of difference
    

    
    //cube_x = 35.5;
    //cube_y = 22.7;
    //x_shift = box_x/2-cube_x/2;
    //y_shift = -box_y/2;
    //translate([x_shift,y_shift,0]) color("blue") cube([cube_x,2,cube_y],center=true);
} // of test()


if (to_print==1) {
    // print the actual box to print
    box_to_print(inner="false",ext_pins="false"); 
}
else if(to_print==2) {
    // print the cover
        
    rotate([180,0,0])
        difference() {
            translate([0,0,box_h/2+1]) cover_to_print();
            box_to_print(inner="false",ext_pins="true"); 
        } // of difference()    
} // of if


//translate([40,70,0]) test(); // testing for chosing servo & US sensor
//test_1();   
   


module cover_to_print() {
    led_cover_d=11.8;// was 12.5;
    cover_h = 2;
    
    header1 = "המחסום של נטע";
    header = "המחסום של עידו";
    font = "Liberation Sans";
    
    
    difference() {
        union() {
            cube ([box_x,box_y,cover_h], center=true);  
            
            translate([-40,-16,0])
                rotate([180,0,0])
                    color("red")
                        linear_extrude(height = 2)                         
                            text(text = header, font = font, size = 8);
            
            //text("OpenSCAD");
        } // of union
        translate([20,15,-5]) cylinder(d=led_cover_d,h=10);
        translate([-20,15,-5]) cylinder(d=led_cover_d,h=10);
        
    } // cut holes for LEDs
    
    
    
} // of cover_to_print()



// *********************************************
module box_to_print(inner="false",ext_pins="false") {
    // inner to include the non printable inner parts
    // ext_pins: to create dumy pins up, to make holes for the cover
    h_shield     = box_h/2-box_width;
    r_shield_vec = [0,0,-90];
    
    pins_vec = [4,0,-h_shield];
    //t_shield_vec = pins_vec+[0,0,8];  // for Arduino shield ??
    
    us_sensor_vec=[0,0,-box_h/2+20]; // was -30
    servo_vec=[0,0,-box_h/4+5]; // was -23
    
    if (inner=="true") {
        // print the innser parts (servo, US sensor, Arduino)
        // not for real printing, of course
        translate(servo_vec) servo();
        translate(us_sensor_vec) ultra_sonic();
    } // of IF
    
    //arduino_shield_base(usb_dummy="true");
    //rotate([0,0,90]) translate([0,-10,-box_h/2+3]) arduino_shield_base(usb_dummy="true");
    
    Wemos_shift_vec=[-27,-25,-box_h/2+1];
    Wemos_rotate_vec=[0,0,90];
    
    difference() {        
        union() {
            box(ext_pins);
            // add wemos pcb holder
            rotate(Wemos_rotate_vec) translate(Wemos_shift_vec)         wemos_and_pins(dummy_usb=false);             
            // add the wemos small holder (no pcb)
            
            wemos_d1_shift_vec=[-5,-17,-13];
            wemos_d1_rot_vec=[0,0,-90];
            wemos_RF_up=0; // 0: RF down. 1: RF up
            rotate(wemos_d1_rot_vec) translate(wemos_d1_shift_vec)
                color("blue") wemos_d1_mini_demo(rf_up=wemos_RF_up);
       
       
       
       
            
        } // of union
        rotate(Wemos_rotate_vec) translate(Wemos_shift_vec)         wemos_and_pins(dummy_usb=true); 
        
        translate(servo_vec) servo();
        //translate(us_sensor_vec) US_sensor(); // module was not accurate
        translate(us_sensor_vec) ultra_sonic();
        rotate([-90,0,-90]) translate([0,-14,52]) smile();
    } // of difference
} // of box_to_print()



module arduino() {
    arduino_x = 20;
    arduino_y = 45;
    arduino_h = 1;
    //cyl_x = arduino_x/2;
    //cyl_y = arduino_y/2;
    //cyl_r=1;
    union() {
        //translate([0,0,0]) cube([arduino_x,arduino_y,arduino_h],center=true);
        //translate([cyl_x,cyl_y,0]) cylinder(r=cyl_r,h=51);
    } // of union()
    Arduino_nano(Connection_pins_enabled,Connection_pins_up,6_pins_enabled,6_pins_up);
} // of Arduino()

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
        translate([0,0,box_h/2-cone_h/2-2]) pin_negative(size=2);
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
    translate([x_shift,y_shift,0]) corner(ext_pins);
    translate([x_shift,-y_shift,0]) corner(ext_pins);
    translate([-x_shift,y_shift,0]) corner(ext_pins);
    translate([-x_shift,-y_shift,0]) corner(ext_pins);
        
} // of box()

module servo() {
    rotate([-90,0,90]) translate([0,0,29])  towerprosg90(position=[0,0,0], rotation=[0,0,0], screws = 1, axle_length = 0, cables=1);
} // of servo()
