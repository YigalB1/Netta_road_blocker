include <Servo_Arms.scad>
$fn=60;

base_length = 2; // was 25
arm_count = 1;
translate([0,0,6]) rotate([0, 180, 0]) servo_standard(base_length, arm_count);

//test();
arm_legth = 160;
sg90_f1(5.0,arm_legth);

module test() {
    translate([0,0,0]) sg90_f1(4.9);
    translate([0,8,0]) sg90_f1(5.1);
    translate([0,16,0]) sg90_f1(5.3);
    translate([0,24,0]) sg90_f1(5.5);
    translate([0,32,0]) sg90_f1(5.7);
} // of test()

module sg90_f1(head_d,length) {
    arm_length = length; // was 14 // was 110
    arm_base_diameter = 16; // was 6 // was 16
    arm_end_diameter = 12; // was 4
    
    arm_width = 1.4;
    screw_d = 2;
    
    servo_head_diameter = head_d; // was 4.7
      
	color("white") difference() {
        arm();
        translate([0,0,-4]) cylinder(d=screw_d,h=10);
	} // of difference();
    
    
    module arm() {
        arm_holes_diameter = 5; // was 1
        hole_start_dist = 12;
        holes_dist = 25;
        
        count = (length - hole_start_dist)/ holes_dist;
        //echo(count);
        
        linear_extrude(height=arm_width)
				difference() {
					hull() {
						circle(d=arm_base_diameter);
						translate([arm_length,0])
                            circle(d=arm_end_diameter);
					} // of hull()
                    // make the holes in the arm
                    
					translate([hole_start_dist,0]) 
                        for (i=[0:count]) translate([i*holes_dist,0])
                            circle(d=arm_holes_diameter);

				} // of difference()
} // or arm() module

}

