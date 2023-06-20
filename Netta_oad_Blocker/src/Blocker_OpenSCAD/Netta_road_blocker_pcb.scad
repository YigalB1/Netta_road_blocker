use <DC_plug_pcb.scad>
pcb_y = 88.5; 
pcb_x = 67.6;
pcb_h = 2;
Pillar_h = 6+1;

Netta_blocker_pcb();

mk_holes(); // holes on the box for the connectors

module mk_holes() {

    // for DC charging USB connector
    translate([-7,-75,5]) color("blue")
        cube([20,20,15-5]);

    
   
    
} // of mk_holes()



module Netta_blocker_pcb(_dxf=true) {
      
    //translate([26,-1,Pillar_h+2])
    //    import("PCB_Netta Road Blocker_2_2023-06-15.dxf");
    
    pcb_pillars();
     
} // of train_ctrl_pcb()

module pcb_pillars() {
    x1=30.5;
    y1=41;
    //x1=0;
    //y1=0;
    x2=x1-61;
    y2=y1;
    x3=x1;
    y3=y1-82;
    x4 = x2;
    y4 = y3;
    
    color("red") translate([x1,y1,0]) my_pillar();
    color("blue")translate([x2,y2,0]) my_pillar();
    color("cyan")translate([x3,y3,0]) my_pillar();
    color("gray") translate([x4,y4,0]) my_pillar();
    //translate([-1,-1,0]) color("green")
    //cube([x2+7,y3+5,pcb_h],center=true);
    translate([0,0,0]) color("green")
        cube([pcb_x+2,pcb_y+2,pcb_h],center=true);
} // of pcb_screws_holes()

module my_pillar() {
    // insert m2 6mm od=3.5
    int_od = 3.2;
    ext_od = 8;
    int_l = Pillar_h;
    ext_l = 8;
    d_l = (ext_l-int_l)/2;
    difference() {
        cylinder(h=ext_l, d=ext_od,$fn=60);
        #translate([0,0,d_l+0.5]) cylinder(h=int_l, d=int_od,$fn=60);
    } // of difference()
} // of my_pillar()


