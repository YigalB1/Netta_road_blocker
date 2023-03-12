//$fn=60;
include <US-025A_sensor.scad>


//wemos_and_pins(dummy_usb=false);


/*    
    difference() {
        wemos_and_pins();
        translate([30,30,-2]) US_025A_sensor();
        translate([-5,-15,0]) #cube([70,30,10]);
        translate([-5,50,0]) #cube([70,30,10]);
        translate([-25,10,0]) #cube([30,60,10]);
        translate([55,10,0]) #cube([30,60,10]);
    } // of difference()
  */  
    
    
    

module wemos_and_pins(dummy_usb=false) {
    if (dummy_usb==true) {
        wemos_d1_mini(dummy_usb);
    } // of if()
    else{
        pins_wemos_motor_pcb();
    wemos_pcb();
    wemos_d1_mini(dummy_usb);
    } // of else()
    
    
} // of wemos_and_pins

module wemos_d1_mini(dummy_usb=false) {
    
    rotate([0,0,-90]) translate([-30,0,10])
        if (dummy_usb==true) {
                translate([0,-15,0]) cube([20,40,12],center=true);
        } // of  IF()
        else {
            //translate([0,17,0]) import("Wemos_D1_mini.stl");
        } // of else()
        
        
} // of wemos_d1_mini()

module wemos_d1_mini_prev(dummy_usb=false) {
    rotate([0,0,-90]) translate([-30,0,10])
        union() {
            import("Wemos_D1_mini.stl");
            if (dummy_usb==true) {
                translate([0,-25,0]) cube([20,40,12],center=true);
            } // of  IF()
        } // of union()
        
} // of wemos_d1_mini()

module wemos_pcb() {
    color("green") cube([62.9-6,57.5,1]);
} // of wemos_pcb()


module pins_wemos_motor_pcb(usb_dummy="false") {
    // the xy were taken from the pcb file
    color("blue") translate([2.286,53.975,0]) pin();
    color("cyan") translate([51.435,54.229,0]) pin();
    color("green") translate([2.286,3.683,0]) pin();
    color("yellow") translate([51.562,3.683]) pin();
} // of pins_wemos_motor_pcb()

module pin() {
    $fn=60;
    insert_2mm_ext_d = 3.4 - 0.2; // the 0.2 for a little smaller hole
    // to allow insert push
    pcb_w = 1.3;
    screw_l = 6;
    spare = 2;
    cylinder_h = screw_l - pcb_w +spare;
    screw_holder_d = insert_2mm_ext_d + 2; // 2mm spare
    
    //cylinder(d=2,h=cylinder_h+3);
    difference(){
        cylinder (d=screw_holder_d,h=5);
        #cylinder(d=insert_2mm_ext_d,h=cylinder_h);
    } // of difference
    
} // of pin();


module wemos_motor_pcb() {
    linear_extrude(height = 4, center = true, convexity = 10)
    import (file = "PCB_Wemos_motor_2021-10-14.dxf",center=true);
} // of wemos_motor_pcb()



