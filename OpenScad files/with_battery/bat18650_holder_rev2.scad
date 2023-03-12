use <screw_inserts.scad>

pin_h = 10;
pin_d = 7;
hole_d = 2.8;
//pin_d = hole_d-0.4;
holes_dx = 91.7+hole_d/2;
holes_dy = 21.8+hole_d/2;

m2_ins_d1 = 5.0; // the holder d
m2_ins_d2 = 3.1; // the hole
m2_h=8; // the height of the holder
m2_d=5; // the depth of the hole for the insert
//m2_d = 3.1;         // to be used
//m2_h = 3.9+0.5;     // depth of hole for insert


// pins shifting
x_shift = holes_dx/2+1;
y_shift = holes_dy/2+1;
//h_shift = box_h/2-pin_h/2;
switch_x_dist = x_shift-10;
switch_y_dist = -25;
switch_h_dist = -5;

delta=3;
plate_x = 2 * x_shift + delta;
plate_y = 2 * y_shift + delta;
plate_h = 1;
   
pcb_x = 99;
pcb_y = 29.6;
pcb_w = 1.6;

holder_x=77;
holder_y=21;
holder_h=17.0-pcb_w;
holder_w=3.5;


translate([0,0,pcb_w]) 18650_shield(_prod=1,_usb=true,_pcb=1);
translate([0,0,pcb_w]) 18650_shield(_prod=0,_usb=true,_pcb=1);

   
module 18650_shield(_prod=1,_usb=true,_pcb=1) {
    // _prod = 0: things for show, or holes in the box
    // _prod = 1: things to be printed, production
    // _usb: add the USB typeA (not always needed)
    // _pcb: so the pcb will not affect the final box
    
    
    if (_prod==0 && _pcb==1) {
    difference() {
            color("green") cube([pcb_x,pcb_y,pcb_w],center=true);
            if (_prod==0) {
                translate([0,0,0]) 18650_pins();
            } // of if()
        } // of difference()
    } // of if()
    
    if (_prod==1) {
        // the pins that hold the shield
        // pins math: 8 mm below pcb, to allow, m2 screws.
        // for inserts: 3.5mm wide. 4mm height of insert.
        translate([0,0,0]) 18650_pins(_pin=1);    // pin_h/2
    } // of if()
    
    if (_prod==0) {
        // the cube that holds the battery
        translate([0,0,holder_h/2+2]) difference() {
            color("cyan") cube([holder_x,holder_y,holder_h],center=true);
            translate([0,0,holder_w]) cube([holder_x-2,holder_y-2,holder_h],center=true);
        } // of difference()
                
        // the battery
        translate([0,0,10]) rotate([0,90,0]) import ("18650.stl");
        
        // the USB typeA connector
        usb_A_x = 14;
        usb_A_y = 14.5;
        usb_A_h = 6.8;
        if (_usb==true) {
            translate([pcb_x/2,0,usb_A_h/2]) color("gray")
                cube([usb_A_x,usb_A_y,usb_A_h],center=true);
        } // of if()
        
        // the side little switch
        sw_x = 9+2;
        sw_y = 8; // dummy value
        sw_h = 4+2;
        translate([pcb_x/2-12.7,-pcb_y/2-sw_y/2+3,usb_A_h/2-1.5-0.5]) color("blue")
            cube([sw_x,sw_y,sw_h],center=true);
        
        // the side charging usb b socket
        ch_x = 8+2+2;
        ch_y = 8; // dummy value
        ch_h = 4.4+0;
        ch_h1 = 4.4+4.6;
        //translate([-pcb_x/2+10,-pcb_y/2-sw_y/2+3,-pcb_w/2]) color("indigo")
        //    cube([ch_x,ch_y,ch_h],center=true);
        
        translate([-pcb_x/2+10,-pcb_y/2-sw_y/2+3,-pcb_w/2-(ch_h1/2-ch_h/2)+3-1])
            color("indigo")
                cube([ch_x,ch_y,ch_h1],center=true);
            
        // the charging leds below
        h1=20;
        translate([-10.5,5.8-11.4,-h1/2]) color("red")
            cube([8,8,h1],center=true);
        

    } // of if()
    
} // of 18650_shield()
   


   
    
module bat18650_holder(_negative=0,_pins=0) {
    // if _negative is 0: create the holder
    // if _negative is 1: create the negative for holes
    //      for the switch & charging
    
    // pins: 0 for thin pins, 1 for inserts
    
    if (_negative==0) {
        translate([0,0,pin_h/2]) 18650_pins(_pin=1);
        cube([plate_x,plate_y,plate_h],center=true);        
    } // of if()
    else {
        x = 8;
        y = 10;
        d = 16 ;
        translate([switch_x_dist,-holes_dy/2-5,y/2+plate_h+0.5])
            cube([x,d,y],center=true);
       translate([-switch_x_dist,-holes_dy/2-5,y/2+plate_h+0.5])
            cube([x,d,y],center=true);
    } // of else()
    translate([0,0,10]) rotate([0,90,0]) import ("18650.stl");
} // of ()


module 18650_pins(_pin=1) {
    // _pin = 1:  holes for inserts
    // _pin = 0:  pins only
    
    if (_pin==0) {
        // create pins
        translate([ x_shift, y_shift,0])
            holding_pin(_d=pin_d,_h=pin_h,_pin_only=_pin);
        translate([ x_shift,-y_shift,0])
            holding_pin(_d=pin_d,_h=pin_h,_pin_only=_pin);
        translate([-x_shift, y_shift,0])
            holding_pin(_d=pin_d,_h=pin_h,_pin_only=_pin);
        translate([-x_shift,-y_shift,0])
            holding_pin(_d=pin_d,_h=pin_h,_pin_only=_pin);
    } // of if()
    if (_pin==1) {
        // for inserts
        
        translate([ x_shift, y_shift,-pcb_w/2])
            add_insert(_size="M2");
            //insert_pin();
        translate([ x_shift,-y_shift,-pcb_w/2])
            add_insert(_size="M2");
        translate([-x_shift, y_shift,-pcb_w/2])
            add_insert(_size="M2");
        translate([-x_shift,-y_shift,-pcb_w/2])
            add_insert(_size="M2");
    } // of if()
    

} // of 18650_pins()




module holding_pin(_d,_h,_pin_only=0) {
    // pins_only = 0 have holes for inserts
    // pins_only = 1 have male pins to hold the pcb
    if (_pin_only == 0) {
        // for inserts screws
        difference(){
            //color("red") cylinder(d=_d,h=_h,$fn=60,center=true);
            color("cyan") cube([_d,_d,_h],center=true);
            //cylinder(d=_d,h=_h,$fn=60,center=true);
            translate ([0,0,_h-m2_h])
            cylinder(d=m2_d,h=_h,$fn=60,center=true);
        } // of difference()
    } // of if()
    else {
        // just a pin
        cylinder(d=2.2,h=_h,$fn=60,center=true);
    } // of else 
} // of holding_pin()