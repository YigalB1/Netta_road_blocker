//$fn=60;
cyl_d = 16 + 0.5;// 0.5 is to make it easy
pcb_x = 45.6;
pcb_y = 20.3;
bcb_h = 1.3;

//HC_SR04();

module HC_SR04() {
    union(){
        union(){
            cube([pcb_x,pcb_y,bcb_h]);
            translate([9,10,0]) color("red" )
                cylinder(d=cyl_d,h=15);
            translate([pcb_x-10.2,10,0])color("green")
                cylinder(d=cyl_d,h=15);
            // original crystal has the original shape
            // the "new" crystal module is a cube
            // for the hole in the print
            //translate([pcb_x/2-7/2, 20-1-3/2,0])
            //color("blue")org_crystal();
            
         } // of inner union()
            
         translate([pcb_x/2-5.5, 15,0]) crystal();

        
        pins();
        
        
    } // of outer union
    
    
    module org_crystal() {
        // better looking, but needs to be aligned. I am lazy.

        hull(){
            cylinder(d=3, h=5);
            translate([7,0,0])cylinder(d=3, h=5);
        }
    } // of org_crystal()
    
    
    module crystal() {
        l = 9.7+1; // the addition is for some spare
        w = 3.3 +1;
        h = 5;
        cube([l,w,h]);
    } // of crystal() module 
    
    module pins() {
        translate([1.5,1.5,0])cylinder(d=1.5,h=16);
        translate([pcb_x-1.5,1.5,0])cylinder(d=1.5,h=16);
        translate([1.5,20-1.5,0])cylinder(d=1.5,h=16);
        translate([pcb_x-1.5,20-1.5,0])cylinder(d=1.5,h=16);
    } // of pins() module

} // of SR04

