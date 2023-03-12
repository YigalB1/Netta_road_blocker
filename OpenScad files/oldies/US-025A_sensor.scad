//$fn=60;
crystal_x = 9.7+1.3;
crystal_y = 4.2+0.8;
crystal_h = 4.4+0.6;
pcb_x = 45.5;
pcb_y = 20;
pcb_h = 1;
    

//US_025A_sensor();

module US_025A_sensor() {
    US_025A_pcb();
} // of wemos_and_pins



module txrx() {
    cylinder(d=16+0.5,h=12);
} // of txrx()

module us_pin() {
    hole_d = 2;
    pin_h = 10;
    cylinder (d=hole_d,h=pin_h);    
} // of pin();


module US_025A_pcb() {
    
    x_shift = pcb_x/2-1.5;
    y_shift = pcb_y/2-1.5;
    
    difference() {
        union() {
            cube([pcb_x,pcb_y,pcb_h],center=true);
            translate([pcb_x/2-11.6,0,0]) txrx();
            translate([-(pcb_x/2-11.2),0,0]) txrx();
            translate([0,pcb_y/2-crystal_y/2,crystal_y/2]) color("grey") crystal();
            translate([x_shift,y_shift,0]) color("red") us_pin();
            translate([x_shift,-y_shift,0]) color("red") us_pin();
            translate([-x_shift,y_shift,0]) color("red") us_pin();
            translate([-x_shift,-y_shift,0]) color("red") us_pin();
        } // of union
        
        
    } // of difference()
    
} // of US_025A_pcb()
module crystal(){
    cube([crystal_x,crystal_y,crystal_h],center=true);
} // of crystal



