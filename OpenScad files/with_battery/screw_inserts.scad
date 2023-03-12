// to add holders for inserts

add_insert(_size="M2");

module add_insert(_size) {
    // _size: M2, M1.6
    if (_size=="M2") {
        // d1: external diameter
        // d2: external diameter
        // h1: pin hight
        // h2: internal space height
        // cube_h: hight of base cube, to be merged with box floor mostly
        insert_pin(_d1=5+2,_d2=3.5,_h1=8,_h2=4,_cube_h=1);
    } // of if()
    
    if (_size=="M1.6") {
        // d1: external diameter
        // d2: external diameter
        // h1: pin hight
        // h2: internal space height
        // cube_h: hight of base cube, to be merged with box floor mostly
        insert_pin(_d1=5+2,_d2=2.5,_h1=8,_h2=4,_cube_h=1);
    } // of if()
    
} // of add_insert()

module insert_pin(_d1,_d2,_h1,_h2,_cube_h=1) {
    
    
    // the cube on button is to help align on box's floor
//    d1 = 5;
//    d2 = 3.5;
//    h_ins = 8;
//    cube_h=1;
    
    translate([0,0,-_h1/2])
        difference() {
            union() {
                //cylinder(d=_d1,h=_h1,center=true,$fn=60);
                cube([_d1,_d1,_h1],center=true);
                translate([0,0,-_h1/2-_cube_h/2])
                    color("green")cube([_d1,_d1,1],center=true);
            } // of union()
            translate([0,0,_h1-_h2])
            cylinder(d=_d2,h=_h1,center=true,$fn=60);
    } // of difference()
} // of insert_pin