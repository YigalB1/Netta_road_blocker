$fn=90;
include <servos.scad>
//include <module_HC_SR04.scad> // module was not accurate
include <Arduino_nano.scad>
include <HC_SR04.scad>
include <Nano_shield_holder.scad>
//include <sg90_servo.scad>

//translate([-160,0,0]) import ("Arduino_Nano_IO_Shield.stl");

box_x = 100;
box_y = 70;
box_h = 33; // working currently 90
box_width = 2;
corner_x = 6;

// for real printing, use "false"
// for debug, use "true", to see how the inner parts fit

to_print = 2; // 1: the box, 2: the cover

if (to_print==1) {
    box_to_print(inner="false",ext_pins="false"); 
}
else if(to_print==2) {
    rotate([180,0,0])
        difference() {
            translate([0,0,box_h/2+1]) cover_to_print();
            box_to_print(inner="false",ext_pins="true"); 
        } // of difference()
    

}




//translate([40,70,0]) test(); // testing for chosing servo & US sensor
//test_1();   
   
module test_1() {
    // test the shield holder
    cube_x = 50; //w
    cube_y = 50;
    cube_z = 50;
    translate([0,0,-22])
        cube([cube_x,cube_y,cube_z]); // to reduce printing for test
    difference() {
        box_to_print(inner="false"); 
    } // of difference()
    
} // of test_1() moduke


module test() {
    // to test the holes before printing the whole box
    //translate([0,0,30]) arduino_sheild(shield="true",pins="false"); 
    translate([-30,10,-7]) color("red") Nano_shield_holder();
    //sg90_motor();
    difference() {
        cube([60,90,2]);
        rotate([90,90,0]) translate([-50,30,-15]) ultra_sonic();
        //rotate([-90,-90,0]) translate([51,10,50]) servo();
        
    //rotate([180,0,0]) translate([60,-50,-10])sg90_motor(); // not to use
    }
    
    
    
}


//translate([0,0,60]) arduino_sheild(shield="true",pins="true"); 

module cover_to_print() {
    led_cover_d=7.7;
    cover_h = 2;
    cube ([box_x,box_y,cover_h], center=true);  
    translate([0,0,0]) cylinder(d=led_cover_d,h=10);
} // of cover_to_print()

module box_to_print(inner="false",ext_pins="false") {
    // inner to include the non printable inner parts
    h_shield     = box_h/2-box_width;
    r_shield_vec = [0,0,-90];
    //t_shield_vec = [4,0,-h_shield];
    pins_vec = [4,0,-h_shield];
    t_shield_vec = pins_vec+[0,0,8];
    
    us_sensor_vec=[0,0,-box_h/2+20]; // was -30
    servo_vec=[0,0,-box_h/4+5]; // was -23
    
    if (ext_pins=="true") {
    } // to create dumy pins up, to make holes for the cover
    
    if (inner=="true") {
        rotate(r_shield_vec) translate(t_shield_vec)
            arduino_sheild(shield="true",pins="false"); 
        translate(servo_vec) servo();
        //translate(us_sensor_vect) US_sensor();
        translate(us_sensor_vec) ultra_sonic();
    } // of IF
    
    
    difference() {        
        union() {
            box(ext_pins);
            // add the pins that will hold the shield
            //translate([0,0,-box_h/2])
            rotate(r_shield_vec) translate(pins_vec)
                arduino_sheild(shield="false",pins="true");
            
            // this is the newer pins to hold the shield
            translate([-48,56,-23]) rotate([0,0,-90]) Nano_shield_holder();
            
            
            
        } // of union
        rotate(r_shield_vec) translate(t_shield_vec)
            arduino_sheild(shield="true",pins="false");    
        translate(servo_vec) servo();
        //translate(us_sensor_vec) US_sensor(); // module was not accurate
        translate(us_sensor_vec) ultra_sonic();
    } // of difference
} // of box_to_print()


module arduino_sheild(pins="true",shield="true"){
    base_x= 57.0;
    base_y = 53.4;
    base_h = 1;
    cyl_h=5;
    jack_x = base_x/2;
    jack_y = base_y/2-10;
   // translate([jack_x,jack_y,-15]) rotate([0,0,90])dc_jack();
    
    cyl_r=1; // the hole diameter is 3.2
    cyl_x = base_x/2-cyl_r;
    cyl_y = base_y/2-cyl_r;
    
    ard_x = 8;
    ard_y = 0;
    
    if (shield=="true") {
        // produce the shield                
        union() {
            cube([base_x,base_y,base_h],center=true);
            translate([ard_x,ard_y,6])rotate([0,0,90]) arduino();
            translate([jack_x,jack_y,0]) rotate([0,0,90]) color("green") dc_jack();
            } // of union()
    } // of IF.
    
    if (pins=="true") {
        pin_h = 10;
        // generate the pins that hold the shield
        color("red") translate([cyl_x-1,cyl_y-0.5,0]) cylinder(r=cyl_r,h=pin_h);
        color("green") translate([cyl_x-1.6,-cyl_y+0.5,0]) cylinder(r=cyl_r,h=pin_h);
        color("blue") translate([-cyl_x+0.7,cyl_y-5.6,0]) cylinder(r=cyl_r,h=pin_h);
        translate([-cyl_x+1.0,-cyl_y+15.6,0]) cylinder(r=cyl_r,h=pin_h);
    } // of IF
    

    
    module dc_jack() {
        dc_in_x= 8.8+1; // 0.2 is slack
        dc_in_y = 13.8 ; //12.4;
        //dc_in_h1 = 6.20; 
        dc_in_h=10.5+1;
    translate([0,0,5]) cube([dc_in_x,dc_in_y,dc_in_h],center=true);
    } // of dc_jack()
    
    
} // of arduino_sheild()


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
        translate([0,0,box_h/2-cone_h/2-2]) cone();
    } // of difference()
    

    
    module cone() {
        // to make it easy to push the screw holder
        color("red") cylinder(r1=0,r2=2,h=cone_h);
    } // of cone() module
    
} // of corner()

module ultra_sonic() {
    x_shift = box_x/2-box_width-2;
    y_shift = 23;
    h_shift = 10;
    translate ([x_shift,y_shift,h_shift]) rotate([90,180,90]) 
        HC_SR04();
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
