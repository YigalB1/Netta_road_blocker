//$fn=40;
//range=40;
//smile();

module smile(range=40) {
rotate([-90,0,0])
color("black")
for (i = [-range/2:1:range/2])
  translate([0,0,1/2])  
rotate([0,i,0])
    translate([0,0,27])
cube(size=5, center=true);}