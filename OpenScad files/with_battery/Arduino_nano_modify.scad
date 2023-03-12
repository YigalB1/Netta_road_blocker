// from https://www.thingiverse.com/thing:3248304/files
// modified Yigal 15 Oct 2022;
use <screw_inserts.scad>
$fn=60;
//0=false 1=true


pcb_w = 1.5;

//_pins_only=0;
//screw_holes=1;
 

//Arduino_nano1(pins_up=1,_down_pins=3,6_pins_enabled,6_pins_up,_screw_holes=1,_pins_only=2);
Arduino_nano(_sig_pins_up=1,_sig_pins_down=0,_6_pins_up=0,_6_pins_down=0,_pcb_pins=0);



//module Arduino_nano1(pins_up=1,_down_pins,6_pins_enabled,6_pins_up,_screw_holes,_pins_only)
module Arduino_nano(_sig_pins_up=1,_sig_pins_down=0,_6_pins_up=0,_6_pins_down=0,_pcb_pins=0)
   {
    // _pins_type:
    // 0: show all Nano
    // 1: Just the pins in order to mount the pcb
    // 2: Just inserts holes
       

   // 0: holes as in reality. 1: pins to be used for holes in the box
   // _pins_only: 0: show all Nano. 1: Just the pins in order to mount 2: inserts holes
   if (_pcb_pins==1) {
       // show the pins to mount the PCB
       pcb_pins(_pins_type=_pcb_pins);
   } // of if()

    else if (_pcb_pins==2) {
        // show base for inserts
        pcb_pins(_pins_type=_pcb_pins);
    } 

   else {
       // show the whole NANO device
   
       
   translate([0,1.257,4])
      union()
         {
         difference() {            
            union() {               
               color("RoyalBlue")
                  translate([0,-1.252,0])
                     cube([18,43,pcb_w],center=true);
            
               translate([2.54*3,0,-3])
                  rotate([0,180,0])
                     Pins_copper_rings(15);

               translate([-2.54*3,0,-3])
                  rotate([0,180,0])
                     Pins_copper_rings(15);
            
               translate([0,2.54*7,-3])
                  rotate([0,180,90])
                     6_pins_copper_rings(3);
                   
               if (_pcb_pins==0) {
                    pcb_pins(_pcb_pins); // was screw_holes()
               } // of if()
  
            } // of union()
        
            if (_pcb_pins==0) {
                //pcb_pins(_pins_only);
                echo ();
                pcb_pins(1);
            } // of if()
  


            translate([2.54*3,0,0])
               rotate([0,180,0])
                  Pins_holes(15);

            translate([-2.54*3,0,0])
               rotate([0,180,0])
                  Pins_holes(15);
         
            translate([0,2.54*7,0])
               rotate([0,180,90])
                  6_pins_holes(3);

            } // of difference()

         color("Silver")
            translate([0,-20,1.25])
               USBmini();
         


            //if(Connection_pins_up==0 && Connection_pins_enabled==1)
            echo(_sig_pins_up);
            echo(_sig_pins_down);
            if(_sig_pins_up==1)
               translate([2.54*3,0,0])
                  rotate([0,0,0])
                     Pins1(15);

         //if(Connection_pins_up==0 && Connection_pins_enabled==1)
            if(_sig_pins_up==1)
               translate([-2.54*3,0,0])
                  rotate([0,0,0])
                     Pins(15);


           // if(Connection_pins_up==1 && Connection_pins_enabled==1)
           if(_sig_pins_down==1)
               translate([2.54*3,0,0])
                  rotate([0,180,0])
                     Pins(15);

         //if(Connection_pins_up==1 && Connection_pins_enabled==1)
           if(_sig_pins_down==1)
               translate([-2.54*3,0,0])
                  rotate([0,180,0])
                     Pins(15);
            
         //if(6_pins_up==1 && 6_pins_enabled==1)
         if(_6_pins_up==1)
            translate([0,2.54*7,0])
               rotate([0,180,90])
                  6_pins(3);

         //if(6_pins_up==0 && 6_pins_enabled==1)
         if(_6_pins_down==1)
            translate([0,2.54*7,0])
               rotate([0,0,90])
                  6_pins(3);

         color("Black")
            translate([0,-6.5,0])
               rotate([0,0,45])
                  Component(5,5,1.5);
         color("Silver")
            translate([0,-6.5,-0.5])
               rotate([0,0,45])
                  Component(5.5,4,1.5);
         color("Silver")
            translate([0,-6.5,-0.5])
               rotate([0,0,-45])
                  Component(5.5,4,1.5);
            
         color("Silver")
            translate([-5,-5,0])
               rotate([0,0,135])
                  Component(0.5,2.3,1.25);
            
         color("White")
            translate([-1,12,0])
               Component(0.7,1.8,1.25);
         color("White")
            translate([1,12,0])
               Component(0.7,1.8,1.25);
         color("White")
            translate([3,12,0])
               Component(0.7,1.8,1.25);
         color("White")
            translate([-3,12,0])
               Component(0.7,1.8,1.25);
            
         color("Saddlebrown")
            translate([-1,9,0])
               Component(0.7,1.8,1.25);
         color("Saddlebrown")
            translate([1,9,0])
               Component(0.7,1.8,1.25);
         color("Saddlebrown")
            translate([3,9,0])
               Component(0.7,1.8,1.25);
         color("Saddlebrown")
            translate([-3,9,0])
               Component(0.7,1.8,1.25);
            
         color("Silver")
            translate([0,2.9,0])
               Component(7,3,2);
         color("Silver")
            translate([0,2.9,0])
               Component(5,2,2.1);
         color("Saddlebrown")
            translate([0,2.9,0])
               Component(3,1,2.5);
         color("Brown")
            translate([0,2.9,0])
               Component(3,1,2.5);

      //Underneath

         color("Saddlebrown")
            translate([1.5,-21,-1.25])
               Component(0.4,1.5,1);

         color("Saddlebrown")
            translate([4,-21,-1.25])
               Component(0.4,1.5,1);
            
         color("Black")
            translate([-1,-20.75,-1.5])
               Component(1.25,2.5,1);

         color("Saddlebrown")
            translate([-4,-19.75,-1.25])
               Component(2,4.5,1);

         color("Saddlebrown")
            translate([4.5,-7,-1.25])
               Component(0.4,1.5,1);

         color("Saddlebrown")
            translate([4,-2,-1.25])
               Component(0.4,1.5,1);

         color("Saddlebrown")
            translate([2.5,-2,-1.25])
               Component(0.4,1.5,1);

         color("Black")
            translate([0,-9.75,-1.75])
               Component(3.5,10,1.5);
         color("Silver")
            translate([0,-9.75,-0.75])
               Component(5.5,9,1.5);

         color("Black")
            translate([2,9.75,-1.75])
               Component(5.5,3,1.75);
         color("Silver")
            translate([2,8,-1])
               Component(3,3,0.75);
         color("Silver")
            translate([2,11,-1])
               Component(0.6,3,0.5);
         color("Silver")
            translate([4,11,-1])
               Component(0.6,3,0.5);
         color("Silver")
            translate([0,11,-1])
               Component(0.6,3,0.5);

         color("Saddlebrown")
            translate([-3,10.5,-1.25])
               Component(2.25,4.5,1);
            
         color("Saddlebrown")
            translate([-5,8.5,-1])
               Component(0.4,1.5,0.5);

         color("Saddlebrown")
            translate([-5,12.25,-1])
               Component(0.4,1.5,0.5);
         }
         
         } // of else of pins_only
   } // of Arduino nano







module pcb_pins(_pins_type) {
    
    // _pins_type:
    // 0: show all Nano
    // 1: Just the pins in order to mount the pcb
    // 2: Just inserts holes
    
    
    
    
    holes_shift_x = 2.54*3;
    holes_shift_y1 = 2.54*7;
    holes_shift_y2 = 2.54*9;
    dy = 1.252;
    h1 = 9; // dummy value - to allow holes in box
    dh = h1/2 - pcb_w/2-1;
    
    vec1 = [holes_shift_x,holes_shift_y1+dy,dh];
    vec2 = [holes_shift_x,-holes_shift_y2+dy,dh];
    vec3 = [-holes_shift_x,holes_shift_y1+dy,dh];
    vec4 = [-holes_shift_x,-holes_shift_y2+dy,dh];
    
    if (_pins_type==1) {
        // pins only
        translate(vec1)
            cylinder(r=0.75,h=h1,center=true);
        translate(vec2)
            cylinder(r=0.75,h=h1,center=true);
        translate(vec3)
            cylinder(r=0.75,h=h1,center=true);
        translate(vec4)
            cylinder(r=0.75,h=h1,center=true);
    }  // for pins
    
    if (_pins_type==2) {
        // inserts for screws
        translate(vec1)
            add_insert(_size="M1.6");
            //(r=0.75,h=h1,center=true);
        translate(vec2)
            add_insert(_size="M1.6");
            //cylinder(r=0.75,h=h1,center=true);
        translate(vec3)
            add_insert(_size="M1.6");
            //cylinder(r=0.75,h=h1,center=true);
        translate(vec4)
            add_insert(_size="M1.6");
            //cylinder(r=0.75,h=h1,center=true);
    }  // for inserts
    
    
} // of pcb_pins()



module Pins(Pins_number,Offset)
   {
   translate([0,-2.54*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
            translate([0,2.54*a,-3])
               cube([0.6,0.6,10],center=true);
         color("Silver")
            translate([0,2.54*a,-1.5])
               cylinder(r1=0,r2=1,h=1);
         color("Silver")
            translate([0,2.54*a,0.5])
               cylinder(r1=1,r2=0,h=1);
         color("Black")
            translate([0,2.54*a,-2])
               Component(2,2,1.25);
        
        if(a==0) 
          {
          Text="D12";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==1) 
          {
          Text="D11";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==2) 
          {
          Text="D10";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==3) 
          {
          Text="D9";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==4) 
          {
          Text="D8";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==5) 
          {
          Text="D7";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==6) 
          {
          Text="D6";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==7) 
          {
          Text="D5";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==8) 
          {
          Text="D4";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==9) 
          {
          Text="D3";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==10) 
          {
          Text="D2";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==11) 
          {
          Text="GND";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==12) 
          {
          Text="RST";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==13) 
          {
          Text="RX0";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==14) 
          {
          Text="TX1";
          %color("Black")
            translate([1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
          
         }
   }

module Pins1(Pins_number,Offset)
   {
   translate([0,-2.54*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
            translate([0,2.54*a,-3])
               cube([0.6,0.6,10],center=true);
         color("Silver")
            translate([0,2.54*a,-1.5])
               cylinder(r1=0,r2=1,h=1);
         color("Silver")
            translate([0,2.54*a,0.5])
               cylinder(r1=1,r2=0,h=1);
         color("Black")
            translate([0,2.54*a,-2])
               Component(2,2,1.25);
        
        if(a==0) 
          {
          Text="D13";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==1) 
          {
          Text="3V3";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==2) 
          {
          Text="REF";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==3) 
          {
          Text="A0";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==4) 
          {
          Text="A1";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==5) 
          {
          Text="A2";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==6) 
          {
          Text="A3";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==7) 
          {
          Text="A4";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==8) 
          {
          Text="A5";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==9) 
          {
          Text="A6";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==10) 
          {
          Text="A7";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==11) 
          {
          Text="5V";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==12) 
          {
          Text="RST";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==13) 
          {
          Text="GND";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
        if(a==14) 
          {
          Text="VIN";
          %color("Black")
            translate([-1.75,2.54*a,0])
              rotate([0,0,90])
              linear_extrude(1)
                text(Text,size=0.8,valign="center",halign="center");
          }
          
         }
   }

module Pins_holes(Pins_number)
   {
   translate([0,-2.54*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
         translate([0,2.54*a,-3])
            cylinder(r=0.55,h=10,center=true);
         }
   }

module Pins_copper_rings(Pins_number)
   {
   translate([0,-2.54*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
         translate([0,2.54*a,-3])
            cylinder(r=1,h=1.6,center=true);
         }
   }

module 6_pins(Pins_number)
   {
   translate([0,-2.54*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
            translate([1.252,2.54*a+1.252,-3])
               cube([0.6,0.6,10],center=true);
         color("Silver")
            translate([1.252,2.54*a+1.252,-1.5])
               cylinder(r1=0,r2=1,h=1);
         color("Silver")
            translate([1.252,2.54*a+1.252,0.5])
               cylinder(r1=1,r2=0,h=1);
         color("Black")
            translate([1.252,2.54*a+1.252,-2])
               Component(2,2,1.25);
         color("Goldenrod")
            translate([-1.252,2.54*a+1.252,-3])
               cube([0.6,0.6,10],center=true);
         color("Silver")
            translate([-1.252,2.54*a+1.252,-1.5])
               cylinder(r1=0,r2=1,h=1);
         color("Silver")
            translate([-1.252,2.54*a+1.252,0.5])
               cylinder(r1=1,r2=0,h=1);
         color("Black")
            translate([-1.252,2.54*a+1.252,-2])
               Component(2,2,1.25);
         }
   }

module 6_pins_holes(Pins_number)
   {
   translate([0,-2.54*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
            translate([1.252,2.54*a+1.252,-3])
               cylinder(r=0.55,h=10,center=true);
         color("Goldenrod")
            translate([-1.252,2.54*a+1.252,-3])
               cylinder(r=0.55,h=10,center=true);
         }
   }

module 6_pins_copper_rings(Pins_number)
   {
   translate([0,-2.54*Pins_number/2,0])
      for(a=[0:1:Pins_number-1])
         {
         color("Goldenrod")
            translate([1.252,2.54*a+1.252,-3])
               cylinder(r=1,h=1.6,center=true);
         color("Goldenrod")
            translate([-1.252,2.54*a+1.252,-3])
               cylinder(r=1,h=1.6,center=true);
         }
   }

module Component(X,Y,Z)
   {
   hull()
      {
      translate([X/2,Y/2,0])
         sphere(r=0.25,$fn=18);
      translate([-X/2,Y/2,0])
         sphere(r=0.25,$fn=18);
      translate([X/2,-Y/2,0])
         sphere(r=0.25,$fn=18);
      translate([-X/2,-Y/2,0])
         sphere(r=0.25,$fn=18);

      translate([X/2,Y/2,Z-0.25])
         sphere(r=0.25,$fn=18);
      translate([-X/2,Y/2,Z-0.25])
         sphere(r=0.25,$fn=18);
      translate([X/2,-Y/2,Z-0.25])
         sphere(r=0.25,$fn=18);
      translate([-X/2,-Y/2,Z-0.25])
         sphere(r=0.25,$fn=18);
      }
   }

module USBmini()
   {
   difference()
      {
      hull()
         {
         translate([4,4.5,3])
            sphere(r=0.5,$fn=18);
         translate([-4,4.5,3])
            sphere(r=0.5,$fn=18);
         translate([4,-4.5,3])
            sphere(r=0.5,$fn=18);
         translate([-4,-4.5,3])
            sphere(r=0.5,$fn=18);

         translate([3,4.5,0])
            sphere(r=0.5,$fn=18);
         translate([-3,4.5,0])
            sphere(r=0.5,$fn=18);
         translate([3,-4.5,0])
            sphere(r=0.5,$fn=18);
         translate([-3,-4.5,0])
            sphere(r=0.5,$fn=18);
         }

      translate([0,-1,0])
         hull()
            {
            translate([3.25,4.5,2.5])
               sphere(r=0.5,$fn=18);
            translate([-3.25,4.5,2.5])
               sphere(r=0.5,$fn=18);
            translate([3.25,-4.5,2.5])
               sphere(r=0.5,$fn=18);
            translate([-3.25,-4.5,2.5])
               sphere(r=0.5,$fn=18);

            translate([2.5,4.5,0.5])
               sphere(r=0.5,$fn=18);
            translate([-2.5,4.5,0.5])
               sphere(r=0.5,$fn=18);
            translate([2.5,-4.5,0.5])
               sphere(r=0.5,$fn=18);
            translate([-2.5,-4.5,0.5])
               sphere(r=0.5,$fn=18);
            }
      }
   }


//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------



