// build "negative" for ss12f15_toggle_switch 
// to make a hole in the box

ss12f15_toggle_switch();
ss12f15_mk_hole();

module ss12f15_toggle_switch(){
    
    import("ss12f15_toggle_switch.stl");
}

module ss12f15_mk_hole() {
    color("blue") translate([ 7.5,0,-10])
        cylinder(h=20,d=2.1,$fn=60);
    color("blue") translate([-7.5,0,-10])
        cylinder(h=20,d=2.1,$fn=60);
    color("cyan") translate([-0,0,0])
        cube([7,4,10],center=true);
}

