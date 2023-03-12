//$fn=90;
base_x = 54.2;
base_y = 42.2;
base_h = 2;
hole_d = 3;
hole_dist_edge = 2.6;
pins_shift_x = base_x/2-hole_dist_edge-hole_d/2;

base_1 = 7;
base_2 = 7;
 
//arduino_shield_base(usb_dummy="true");   
//arduino_nano(usb_dummy="false");
 

module arduino_shield_base(usb_dummy="false") {
    // usb_dummy: true as is, false: very long for hole in the box
      
    if (usb_dummy == "false") {
        //add base and pins to hold the shield
        shield_base();  
        pins(); 
    } 
    else {
        // display only the USB header, for hole in the box
        arduino_nano(usb_dummy);        
    } // of else
    
} // of arduino_shield_base() 


module arduino_nano(usb_dummy="false") {
    pcb_x = 42.7;
    pcb_y = 17.6;
    pcb_h = 1.3;
    // usb hole dimentions
    usb_l = 10.3+1.7; // length. only for the length to meet the wall for the hole
    usb_w = 10.3+3.7; // the width of the hole
    usb_h = 7.4 + 2; // the height of the hole in the box
    
    echo("start, usb_dummy is: ",usb_dummy);
      
    usb_diff = 10.8+pcb_h+2; 
    
    if (usb_dummy=="false") {
        echo("in IF, USB_L is: ",usb_l);
         // Show the Arduino with "real" USB connector
        translate([0,0,10.8]) cube([pcb_x,pcb_y,pcb_h],center=true);
        translate([-pcb_x/2,0,usb_diff]) color("red") cube([usb_l,usb_w,usb_h],center=true);
    } else {
        // make USB very long for the hole in the box. Show only USB.
        echo("in else, USB_L is: ",usb_l);
        translate([-pcb_x/2,0,usb_diff]) color("red") cube([usb_l+20,usb_w,usb_h],center=true);
    } // of else    
} // of arduino_nano() 


module threads_holes(size=2) {
    
   if (size==2) {
    wide_d = 5;
    hole_d = 3.2;
    hole_h = 3.8+0.4;
    color("blue") thread(wide_d,hole_d,hole_h);
   } // 2mm  
   else if(size==3) {
    wide_d = 7;
    hole_d = 4.5;
    hole_h = 5.6+0.4;
    color("cyan") thread(wide_d,hole_d,hole_h);
   } // 3mm

    
} // of threads_holes()

module thread(wide_d = 5,hole_d = 2,hole_h = 5) {
    base_d = 7;
    base_h = 7;
          
      difference() {
        cylinder(d=base_d,h=base_h);
        translate([0,0,base_h-hole_h])color("red") cylinder(d=hole_d,h=hole_h);
      } // of difference
} // create the thread hole

module pins() {
    base_h = 5;
    base_d = 5;
    pin_h = 11;
    pin_d = 2;
    
    
    translate ([pins_shift_x,0,0]) color("red") pin();;
    translate ([-pins_shift_x,0,0]) color("green") pin();
    
    module pin() {
        //cylinder(d=base_d,h=base_h);
        //cylinder(d=pin_d,h=pin_h);
        threads_holes(size=2);
    } // of pin() module
} // of module pins()

module shield_base() {
    translate([0,0,0]) color("cyan") cube([base_x,base_y,base_h],center=true);
} // of module base()


