$fn=60;
sg90_motor();

module sg90_motor(){
	difference(){			
		union(){
			color("green") cube([23,12.5,22], center=true);
			color("blue") translate([0,0,5]) cube([32,12,2], center=true);
			color("blue") translate([5.5,0,2.75]) cylinder(r=6, h=25.75, $fn=20, center=true);
			color("blue") translate([-.5,0,2.75]) cylinder(r=1, h=25.75, $fn=20, center=true);
			color("blue") translate([-1,0,2.75]) cube([5,5.6,24.5], center=true);		
			color("white") translate([5.5,0,3.65]) cylinder(r=2.35, h=29.25, $fn=20, center=true);				
		} // of union()
		translate([10,0,-11]) rotate([0,-30,0]) cube([8,13,4], center=true);
		for ( hole = [14,-14] ){
			translate([hole,0,5]) cylinder(r=2.2, h=4, $fn=20, center=true);
		}	// of for loop
	} // of difference()
    translate([14,0,5])  cylinder(d=2.2,h=40, center=true,$fn=60);
    translate([-14,0,5]) cylinder(d=2.2,h=40, center=true,$fn=60);
} // of module()