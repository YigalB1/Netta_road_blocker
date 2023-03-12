//$fn=90;

dw = 2;
H = 5;
dh=H + dw;
pin_d = 2.5;
pin_h=10;
low_pin_d = 6; 
low_pin_h = 6;

//Nano_shield_holder();

module Nano_shield_holder() {
  union(){
    translate([50, 20, dh])
        cube([10, 2, pin_h]);
    translate([50, 75.5, dh])
      cube([10, 2, pin_h]);
      //union() {
        
        
      //}
      
    translate([32.5, 40, dh])
      pin();
      //  cylinder(d=pin_d, h=pin_h);
    translate([32.5, 67, dh])
      pin();
        //cylinder(d=pin_d, h=pin_h);
    translate([83.5, 25, dh])
      pin();
        //cylinder(d=pin_d, h=pin_h);
    translate([84.5, 73, dh])
      pin();
        //cylinder(d=pin_d, h=pin_h);
      
  } // of union()
  
  

    module pin() {
        
        cylinder(d=low_pin_d, h=low_pin_h);
        cylinder(d=pin_d, h=pin_h+low_pin_h);
        
    } // module pins()
} // of Nano_shield_holder()

