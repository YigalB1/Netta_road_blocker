//$fn=60;

linear_extrude(height = 4, center = true, convexity = 10)
    offset(0.01) import(file="PCB_PCB_Wemos_motor_2021-10-15.svg", center = false, dpi = 96);

module wemos_and_pins() {
    wemos_motor_pcb();
    pins_wemos_motor_pcb();
} // of wemos_and_pins



module pins_wemos_motor_pcb(usb_dummy="false") {
    // the xy were taken from the pcb file
    color("blue") translate([2.286,53.975,0]) pin();
    color("cyan") translate([51.435,54.229,0]) pin();
    color("green") translate([2.286,3.683,0]) pin();
    color("yellow") translate([51.562,3.683]) pin();
} // of pins_wemos_motor_pcb()

module pin() {
    inset_2mm_ext_d = 3.4 - 0.2; // the 0.2 for a little smaller hole
    // to allow insert push
    pcb_w = 1.3;
    screw_l = 6;
    spare = 2;
    cylinder_h = screw_l - pcb_w +spare;
    screw_holder_d = inset_2mm_ext_d + 2; // 2mm spare
    
    difference(){
        cylinder (d=screw_holder_d,h=5);
        #cylinder(d=inset_2mm_ext_d,h=cylinder_h);
    } // of difference
    
} // of pin();


module wemos_motor_pcb() {
    linear_extrude(height = 4, center = true, convexity = 10)
    import (file = "PCB_Wemos_motor_2021-10-14.dxf",center=true);
} // of wemos_motor_pcb()



