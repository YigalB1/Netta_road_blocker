// from https://www.printables.com/model/10606-18650-battery-shield-v3-case/files
//Designed for 4 * 6mm cap head screws


sheild_pcb_width = 29;
sheild_pcb_length = 99;
sheild_pcb_height = 1.2;
sheild_mount_hole_diameter = 3;

cutout_width = sheild_pcb_width + 1; 
cutout_length = sheild_pcb_length + 1;
cutout_height = 6.2;

side_width = 1;
case_width = cutout_width + (side_width*2);
case_length = cutout_length + (side_width*2);
case_height = cutout_height + side_width;

mount_width = 25;
mount_length = 95;

support_length_1 = 54;
support_length_2 = 31;

end_length = 6;

//oversized usb cutout
micro_usb_cutout_length = 12;
micro_usb_cutout_width = 10;
micro_usb_cutout_height = 7;
micro_usb_cutout_pos_length = -45.5;
micro_usb_cutout_pos_width = -17;
micro_usb_cutout_pos_height = 1;


$fn=100;

//Base shape, hollowed out.
module base () { 
    difference() {
        translate([-case_length/2,-case_width/2,0]) 
        cube([case_length,case_width,case_height]);

        translate([-cutout_length/2,-cutout_width/2,side_width]) 
        cube([cutout_length,cutout_width,case_height]);
        
        translate([micro_usb_cutout_pos_length,micro_usb_cutout_pos_width,micro_usb_cutout_pos_height]) cube([micro_usb_cutout_length ,micro_usb_cutout_width,micro_usb_cutout_height]);
    }
}

//Draw pcb, not needed, but useful to see clearances 
module pcb() { 
    translate([0,0,5])  
    difference() {
        translate([-sheild_pcb_length/2,-sheild_pcb_width/2,0]) 
        cube([sheild_pcb_length,sheild_pcb_width,sheild_pcb_height]);
        translate([-mount_length/2,-mount_width/2,0]) cylinder(h=case_height, d=sheild_mount_hole_diameter);
        translate([mount_length/2,-mount_width/2,0]) cylinder(h=case_height, d=sheild_mount_hole_diameter);
        translate([-mount_length/2,mount_width/2,0]) cylinder(h=case_height, d=sheild_mount_hole_diameter);
        translate([mount_length/2,mount_width/2,0]) cylinder(h=case_height, d=sheild_mount_hole_diameter);
    }
}

//Mount points
module pillars() 
{
    translate([-mount_length/2,-mount_width/2,0]) pillar();
    translate([mount_length/2,-mount_width/2,0]) pillar();
    translate([-mount_length/2,mount_width/2,0]) pillar();
    translate([mount_length/2,mount_width/2,0]) pillar();

//Support pillars
    translate([-mount_length/2+support_length_1,-mount_width/2,0]) cylinder(h=case_height-sheild_pcb_height, d=sheild_mount_hole_diameter*2); ;
    translate([-mount_length/2+support_length_2,mount_width/2,0]) cylinder(h=case_height-sheild_pcb_height, d=sheild_mount_hole_diameter*2); ;
}

//Draw a single Mount point. 
module pillar() {
    difference() {
        cylinder(h=case_height-1.2, d=sheild_mount_hole_diameter*2); 
        translate([0,0,side_width]) cylinder(h=case_height, d=sheild_mount_hole_diameter-0.1); 
    }
}

//Extra plastic to sit under usb socket
module end() {
    translate([case_length/2,-case_width/2,0]) 
    cube([end_length,case_width,case_height]);
}

base();
pillars();
end();
//pcb();