//$fn=40;
//range=40;
smile(_range=40,_size=5);

module smile(_range=40,_size=5) {
rotate([-90,0,0])
color("green")
for (i = [-_range/2:1:_range/2])
  translate([0,0,1/2])  
    rotate([0,i,0])
        translate([0,0,27])
            cube([_size+5,_size+10,_size], center=true);}