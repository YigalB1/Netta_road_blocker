$fn=60;

x = 15.3;
y = 10.3;
cover_h = 1.8;

int_x = 12.9+0.7; // the 1mm is for spare and printing offset
int_y = 8.2 + 0.7; // offset
int_h = 9.4;

// trials();
//kcd1_11();

module trials() {
    difference() {
        cube([x*2,y*2,2],center=true); 
        translate([0,0,int_h/2]) kcd1_11();
    } // of difference()
} // of trials

module kcd1_11() {

        color("green") cube([x,y,cover_h],center=true);
        color("red") translate([0,0,-int_h/2])
            cube([int_x,int_y,int_h],center=true);
        

} // of switch kcd1_11()


