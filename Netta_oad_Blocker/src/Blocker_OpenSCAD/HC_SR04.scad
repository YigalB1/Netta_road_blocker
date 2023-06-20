//$fn=60;
sens_d = 16+0.5;
sens_h = 15;

HC_SR04();

module HC_SR04() {
    union(){
        union(){
            // base
            cube([45,20,1]);
            // tranducers
            translate([9,10,0])cylinder(d=sens_d,h=sens_h,$fn=60);
            translate([45-9,10,0])cylinder(d=sens_d,h=sens_h,$fn=60);
            // cristal
            translate([45/2-7/2, 20-1-3/2,0])hull(){
                cylinder(d=3, h=5,$fn=60);
                translate([7,0,0])cylinder(d=3, h=5,$fn=60);
            } // of hull()
        } // of inner union()
        
        // for the screw holes
        translate([1.5,1.5,0])cylinder(d=1.5,h=16,$fn=60);
        translate([45-1.5,1.5,0])cylinder(d=1.5,h=16,$fn=60);
        translate([1.5,20-1.5,0])cylinder(d=1.5,h=16,$fn=60);
        translate([45-1.5,20-1.5,0])cylinder(d=1.5,h=16,$fn=60);
    } // of outer union
    
} // of SR04

