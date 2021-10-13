/* [HIDDEN] */
//QUALITY
$fn = 40;
D = 0.05;
F = 1.0;
// PLANE
H = 5;
W = 10;
// CLIP
CLIP = 5;
CLIP_F = 0.5;
CLIP_W = 1.5;
CLIP_L = 4.2;
// WHEEL
WHEEL_OUT_D = 52;
WHEEL_W = 3;
WHEEL_H = 20;
WHEEL_ARM_N = 5;
WHEEL_ARM_W = 4;
WHEEL_ARM_H = 10;
WHEEL_GEAR_N = 18;
// WHEEL PIN
WHEEL_PIN_D = 5.4;
WHEEL_PIN_L = 20;
// BEARING 688
BEAR_OUT_D = 16;
BEAR_IN_D = 8;
BEAR_H = 5;
// DC MOTOR
DC_PIN_D = 5.4;
DC_PIN_W = 3.6;
// SERVO
SERVO_D = 7.4;
SORVO_S = 2.2;
SERVO_T = 0.4;

/* [MODULES] */
MODULE = 2; // [1:Clips, 2:Plane, 3:Corner, 4:Servo Mount, 5:Servo Bracet, 6:Servo Pin, 7:Control Unit, 8:Control Unit Cap, 9:Battery Block, 10:Battery Block Cap]
/* [PARAMETERS] */
ROWS = 3; // [1:20]
COLS = 3; // [1:20]
ROWS_CORNER = 3; // [1:10]
HEIGHT = 1; // [1:0.5:10]


if (MODULE == 1){
    clips();
} else if (MODULE == 2){
    plane(ROWS, COLS, HEIGHT);
} else if (MODULE == 3){
    corner(ROWS, ROWS_CORNER, COLS);
} else if (MODULE == 4){
    servo_joint();
} else if (MODULE == 5){
    servo_bracet();
} else if (MODULE == 6){
    servo_pin();
} else if (MODULE == 7){
    control_block();
} else if (MODULE == 8){
    control_block_cap();
} else if (MODULE == 9){
    battery_block();
} else if (MODULE == 10){
    battery_cap();
} 

// UTILS:
// 1. clip_gap();
// 2. solid_plane(r, c);
// 3. bevel(r, c, h);
// 4. pyramid4(a, h);
// 5. prizm3rect(a, h);

module control_block_cap(){
    difference(){
        plane(9, 9, 1.2);
        translate([0, 0, 4.95])
            cube([11, 11, 1.1]);
        translate([79, 0, 4.95])
            cube([11, 11, 1.1]);
        translate([0, 79, 4.95])
            cube([11, 11, 1.1]);
        translate([79, 79, 4.95])
            cube([11, 11, 1.1]);
    }
}

module battery_cap(){
    difference(){
        union(){
            plane(5,9);
            translate([1,1,0.05])
                cube([8,8,4.9]);
            translate([41,1,0.05])
                cube([8,8,4.9]);
            translate([1,81,0.05])
                cube([8,8,4.9]);
            translate([41,81,0.05])
                cube([8,8,4.9]);
        }
        translate([3, 3, 0])
            cylinder(d=2.5, h=10, center=true);
        translate([3, 90-3, 0])
            cylinder(d=2.5, h=10, center=true);
        translate([50-3, 3, 0])
            cylinder(d=2.5, h=10, center=true);
        translate([50-3, 90-3, 0])
            cylinder(d=2.5, h=10, center=true);
        translate([2.5,2.5,2.5])
            cylinder(d=10, h=3);
        translate([50-2.5,2.5,2.5])
            cylinder(d=10, h=3);
        translate([2.5,90-2.5,2.5])
            cylinder(d=10, h=3);
        translate([50-2.5,90-2.5,2.5])
            cylinder(d=10, h=3);
    }
}

module battery_block(){
    difference(){
        union(){
            difference(){
                plane(5,9, 7);
                translate([4.5, 5, 7])
                    cube([41, 80, 28]);
                translate([6, 0, 6])
                    cube([38, 5.1, 28]);
                translate([6, 84.9, 6])
                    cube([38, 5.1, 28]);
                translate([0, 6, 6])
                    cube([5.0, 78, 28]);
                translate([45, 6, 6])
                    cube([5.0, 78, 28]);
            }
            
            translate([5, 5, 5])
                rotate([90, 0, 0])
                    plane(4, 3);
            translate([5, 90, 5])
                rotate([90, 0, 0])
                    plane(4, 3);
            translate([5, 5, 5])
                rotate([0,-90,0])
                    plane(3,8);
            translate([50, 5, 5])
                rotate([0,-90,0])
                    plane(3,8);
        }
        translate([4.5, 5, 7])
            cube([41, 80, 28]);
        
        translate([21, 0, 0])
            cube([8, 9, 5]);
        translate([21, 5, 0])
            cube([8, 5, 10]);
        
        translate([21, 81, 0])
            cube([8, 9, 5]);
        translate([21, 80, 0])
            cube([8, 5, 10]);
        
        translate([3, 3, 35])
            cylinder(d=2.5, h=10, center=true);
        translate([3, 90-3, 35])
            cylinder(d=2.5, h=10, center=true);
        translate([50-3, 3, 35])
            cylinder(d=2.5, h=10, center=true);
        translate([50-3, 90-3, 35])
            cylinder(d=2.5, h=10, center=true);
    }
    translate([4, 34, 20])
        cube([1, 2, 5]);
    translate([4, 54, 20])
        cube([1, 2, 5]);
    translate([45, 34, 20])
        cube([1, 2, 5]);
    translate([45, 54, 20])
        cube([1, 2, 5]);
    
}

module control_block(){
    dw = 2;
    dh = H + dw;
    h = 7;
    w = 9;
    servo_h = 13;
    union(){
        difference(){
            plane(w, w, h);
            // inner space
            translate([dw, dw, dh])
                cube([w*W-dw*2, w*W-dw*2, h*H]);
            // servo pins gap
            translate([22, 0, 0])
                cube([66, 10, dh + servo_h]);
            // servo power gap
            translate([51, 0, dh+18])
                cube([10, dw+1, 5]);
            // power connector gap
            //translate([dw, 0, dh])
            //    cube([4, dw+1, 8]);
            // power button gap
            translate([w*W-3, 75, dh])
                cube([4, 12, 20]);
            //translate([w*W-3, 75, dh+20.5])
            //    cube([4, 4, 35]);
            // shield bower gap
            translate([w*W-3, 58, dh+4])
                cube([4, 20, 16]);
            // arduino nano usb gap
            translate([w*W-3, 44, dh+16])
                cube([4, 10, 6]);
            // side gaps
            translate([0, 0, H*h-3])
                cube([90, 90, 4]);
            
            
        }
        // joints
        translate([0, 0, (h-1)*H])
            upper_joint();
        translate([(w)*W, W, (h-1)*H])
            rotate([0, 0, 180])
                upper_joint();
        translate([0, (w-1)*W, (h-1)*H])
            upper_joint();
        translate([(w-1)*W, (w-0)*W, (h-1)*H])
            rotate([0, 0, -90])
                upper_joint();
        //translate([(w-1)*W, (w-3)*W, (h-1)*H])
        //    upper_joint();
        
        // pca9685 mount
        translate([25, 13, dh])
            cube([5, dw, 5]);
        translate([25, 17, dh])
            cube([5, dw, 5]);
        translate([82, 13, dh])
            cube([7, dw, 25]);
        translate([82, 17, dh])
            cube([7, dw, 25]);
        translate([27.5, 14, dh+3])  
            sphere(d=3.0,$fn=12);
        translate([27.5, 18, dh+3])  
            sphere(d=3.0,$fn=12);
        translate([84, 14, dh+3])  
            sphere(d=3.0,$fn=12);
        translate([84, 18, dh+3])  
            sphere(d=3.0,$fn=12); 
        // dc converter mount
        translate([10, 24, dh])
            cube([10, 2, 5]);
        translate([10, 70, dh])
            cube([10, 2, 5]);
        translate([2, 45, dh])
            cube([2, 10, 5]);
        translate([25, 45, dh])
            cube([5, 10, 5]);
        translate([7, 34, dh])
            cylinder(d=2.2, h=5);
        translate([22, 64, dh])
            cylinder(d=2.2, h=5);
        // io shield mount
        translate([50, 20, dh])
            cube([10, 2, 5]);
        translate([50, 75.5, dh])
            cube([10, 2, 5]);
        translate([32.5, 40, dh])
            cylinder(d=2.2, h=5);
        translate([32.5, 67, dh])
            cylinder(d=2.2, h=5);
        translate([83.5, 25, dh])
            cylinder(d=2.2, h=5);
        translate([84.5, 73, dh])
            cylinder(d=2.2, h=5);
        // bluetooth mount
        translate([20, 83, dh])
            cube([2, 5, 15]);
        translate([30, 80, dh])
            cube([5, 2, 15]);
        translate([30, 86, dh])
            cube([5, 3, 15]);
        translate([57, 80, dh])
            difference(){
                cube([5, 8, 20]);
                translate([-1, 2, 0])
                    cube([4, 2.5, 21]);
            }
        
    }
    
}

module upper_joint(){
    union(){
        translate([0, 0, H])
            mirror([0,0,1])
                plane(1,1,1.5);
        translate([0.5, 1, -9])
            rotate([0, 45, 0])
                cube([1.0, 8, 11]);
    }
}


module wheel(){
    union(){
        difference(){ 
            cylinder(d=WHEEL_OUT_D, h=WHEEL_H);
            translate([0,0,-D]) cylinder(d=WHEEL_OUT_D-WHEEL_W*2, h=WHEEL_H+D*2); 
        }
        difference(){ 
            cylinder(d=WHEEL_W*2+WHEEL_PIN_D, h=WHEEL_H);
            translate([0, 0, -D]) intersection(){
                cylinder(d=WHEEL_PIN_D+2*D, h=WHEEL_H+2*D);
                translate([-DC_PIN_D/2-F/2, -DC_PIN_W/2-D, 0]) cube([DC_PIN_D+F, DC_PIN_W+2*D, WHEEL_H+2*D]);
            }
        }
        for (i = [0:WHEEL_ARM_N-1]){
            rotate([0, 0, (360*i)/WHEEL_ARM_N]) 
                translate([WHEEL_W+WHEEL_PIN_D/2-F, -WHEEL_ARM_W/2, 0]) 
                    cube([WHEEL_OUT_D/2 - WHEEL_W - WHEEL_PIN_D/2, WHEEL_ARM_W, WHEEL_ARM_H]);
        }
        for (i = [0:WHEEL_GEAR_N-1]){
            rotate([0,0,(360*i)/WHEEL_GEAR_N])
                translate([0, WHEEL_OUT_D/2-D*2, WHEEL_H/2]) 
                    rotate([-90, 0, 0]) 
                        track_pin(2*F, 2*W-2*F-2*D, H/2, [0.7, 0.8]);
        }
    }
}

module wheel_pin(){
    translate([0, 0, DC_PIN_W/2])
    rotate([90, 0, 0])
    union(){
        intersection(){
            cylinder(d=BEAR_IN_D+D*2, h=BEAR_H);
            translate([-BEAR_IN_D/2-D, -DC_PIN_W/2, 0]) 
                cube([BEAR_IN_D+D*2, BEAR_IN_D+D*2, BEAR_H]);
        
        }
        intersection(){
            translate([0,0,H]) 
                cylinder(d=WHEEL_PIN_D, h=WHEEL_PIN_L-H);
            translate([-DC_PIN_D/2-F/2, -DC_PIN_W/2, H]) 
                cube([DC_PIN_D+F, DC_PIN_W, WHEEL_PIN_L-H]);
        }
    }
}

module wheel_mount(){
    r = 2;
    c = 2;
    dr = (r - floor(r))*W;
    dc = (c - floor(c))*W;
    difference(){
        solid_plane(r, c, 2.0);
        for (i = [0:r-1]){
            for (j = [0:c-1]){
               translate([(i+0.5)*W+dr, (j+0.5)*W+dc, 0]) clip_gap();
            }
        }
        translate([W, W, H+F]) cylinder(d=BEAR_OUT_D, h=BEAR_H+D);
        translate([W, W, H+F/2]) cylinder(d=BEAR_IN_D+2*F, h=BEAR_H+D+F);
    }
    
}

module track(){
    difference(){
        union(){
            difference(){
                union(){
                    // main
                    translate([0, D, D]) cube([W, 2*W-2*D, H-2*D]);
                    translate([2*D, D, H/2]) rotate([-90, 0, 0]) cylinder(h=2*W-2*D, d=H-2*D);
                    translate([W, D, H/2]) rotate([-90, 0, 0]) cylinder(h=2*W-2*D, d=H-2*D);
                    // pins
                    translate([F, H/2, H-D]) track_pin(2*F, H-2*D, F, 0.5);
                    translate([F, 2*W-H/2, H-D]) track_pin(2*F, H-2*D, F, 0.5);
                    translate([H, W, H-D]) track_pin(2*F, W-2*D, F, 0.5);
                }
                // minus gaps
                translate([-H/2, H-D, 0]) cube([H+D*2,W+D*2,H]);
                translate([H+H/2, 0, 0]) cube([H,H+D*2,H]);
                translate([H+H/2, W+H-D*2, 0]) cube([H,H+D*2,H]);
                // small gaps
                //translate([H+H/2, H+1.5, 0]) cube([H,F,H]);
                //translate([H+H/2, W+H-1.5-F, 0]) cube([H,F,H]);
                translate([H+H/2, H+F*2, 0]) cube([H,W-4*F,H]);
                
                // minus pins
                translate([H, W, 0]) track_pin(3*F, 2*W-2*F-2*D, H/2, [0.5, 0.8]);
            }
            // clips plus
            translate([W,H+D*2, H/2])   rotate([90, 0, 0]) track_clips();
            translate([W,W+H-D*2, H/2])   rotate([-90, 0, 0]) track_clips();
        }  
        // clips minus
        translate([0,H-D, H/2])   rotate([90, 0, 0]) track_clips();
        translate([0,W+H+D, H/2])   rotate([-90, 0, 0]) track_clips();
    } 
}

module track_pin(x, y, z, s){
    linear_extrude(height=z, scale=s) square(size=[x, y], center=true);
}

module track_clips(){
        linear_extrude(height=F*0.5, scale=0.8) circle(d=H-2*F);
}




module servo_pin(){
    difference(){
        cylinder(d=SERVO_D-SERVO_T, h=H-2);
        cylinder(d=SORVO_S, h=H);
        translate([0,0,H-2])
            cylinder(d=SERVO_D-3, h=2);
        
        
    }
    
}

module servo_mount(){
    union(){
        rotate([90, 0, 0])
        linear_extrude(height=16.5, scale=[4.4/SERVO_D, 1])
            translate([-SERVO_D/2, -2.0])
                square([SERVO_D, 4]);
        cylinder(d=SERVO_D,h=4, center=true);
        translate([0, -16.5])
            cylinder(d=4.4,h=4, center=true);
    }
}

module servo_bracet(){
    r = 3;
    c = 3;
    
    dr = (r - floor(r))*W;
    dc = (c - floor(c))*W;
    difference()
    {
        solid_plane(4.5, 3);
        for (i = [0:r-1]){
            for (j = [0:2:c-1]){
               translate([(i+1.25)*W+dr, (j+0.5)*W+dc, 0]) clip_gap();
            }
        }
        translate([22.5,15,4])
            rotate([0,0,90])
                servo_mount();
        translate([22.5,15,4])
            rotate([0,0,-90])
                servo_mount();
        translate([22.5,15,0])
            cylinder(d=SERVO_D, h=5);
    }
    
    translate ([W-H, 0, 0]) 
        rotate ([0, -90, 0]) 
    difference(){
        solid_plane(3.5, 3);
            for (i = [0:r-1]){
            for (j = [0:2:c-1]){
               translate([(i+1.0)*W+dr, (j+0.5)*W+dc, 0]) clip_gap();
            }
        }
        translate([30,15,4])
            rotate([0,0,-90])
                servo_mount();
        translate([30,15,0])
            cylinder(d=SERVO_D, h=5);
        translate([5, 10, 0])
            cube([4,10,5]);
    }
    
    translate ([40+W-H, 0, 0]) 
        rotate ([0, -90, 0]) 
    difference(){
        solid_plane(3.5, 3);
            for (i = [0:r-1]){
            for (j = [0:2:c-1]){
               translate([(i+1.0)*W+dr, (j+0.5)*W+dc, 0]) clip_gap();
            }
        }
        translate([30,15,1])
            rotate([0,0,-90])
                servo_mount();
        translate([30,15,0])
            cylinder(d=SERVO_D, h=5);
        translate([5, 10, 0])
            cube([4,10,5]);
    }
}

module servo_joint(){
    r=3;
    c=3;
    dr = (r - floor(r))*W;
    dc = (c - floor(c))*W;
    difference()
    {
        solid_plane(3.5, 3, 7);
        translate([0, 9-SERVO_T/2, 23.5])
            cube([35, 12+SERVO_T, 11.5]);
        translate([5, 9-SERVO_T/2, 5])
            cube([25, 12+SERVO_T, 19]);
        translate([3.5, 15, 15])
            cylinder(d=SORVO_S, h=10);
        translate([35-3.5, 15, 15])
            cylinder(d=SORVO_S, h=10);
        translate([23, 15, 0])
            cylinder(d=SORVO_S, h=10);
        translate([25, 13, 5])
            cube([10, 4, 12]);
        rotate([90, 0, 0])
            for (i = [0:r-1]){
                for (j = [0:c-1]){
                    translate([(i+1.0)*W+dr, (j+0.75)*W+dc, -5]) clip_gap();
                    translate([(i+1.0)*W+dr, (j+0.75)*W+dc, -30]) clip_gap();
                }
            }
        rotate([0, -90, 0]){
            translate([(0.75)*W+dr, (0.5)*W+dc, -5]) 
                clip_gap();
            translate([(1.75)*W+dr, (0.5)*W+dc, -5]) 
                clip_gap();
            translate([(2.75)*W+dr, (0.5)*W+dc, -5]) 
                clip_gap();
            translate([(0.75)*W+dr, (2.5)*W+dc, -5]) 
                clip_gap();
            translate([(1.75)*W+dr, (2.5)*W+dc, -5]) 
                clip_gap();
            translate([(2.75)*W+dr, (2.5)*W+dc, -5]) 
                clip_gap();
        }
        
    }
}

module plane(r, c, h = 1){
    dr = (r - floor(r))*W;
    dc = (c - floor(c))*W;
    difference(){
        solid_plane(r, c, h);
        for (i = [0:r-1]){
            for (j = [0:c-1]){
               translate([(i+0.5)*W+dr, (j+0.5)*W+dc, 0]) clip_gap();
            }
        }
    }
}

module solid_plane(r, c, h=1){
    bevel (r, c, h) translate ([D, D, D])
        cube([r*W-2*D, c*W-2*D, h*H-2*D]);
}

module corner(r1, r2, c){
    plane(r1+H/W, c);
    translate ([W-H, 0, 0]) rotate ([0, -90, 0]) plane(r2+H/W, c);
}

module clips(){
        clips_main();
}

module clips_main(){
    translate([0,0,-CLIP/2]) linear_extrude(CLIP) 
        polygon([
            [-CLIP/2, -H],
            [-CLIP/2-CLIP_F,-H+CLIP_F],
            [-CLIP/2,-H+CLIP_F*2],
            [-CLIP/2, H-CLIP_F*2],
            [-CLIP/2-CLIP_F,H-CLIP_F],
            [-CLIP/2, H],
            [-CLIP/2+CLIP_W, H],
            [CLIP/2-CLIP_W, -H+CLIP_L],
            [CLIP/2-CLIP_W, H],
            [CLIP/2, H],
            [CLIP/2+CLIP_F, H-CLIP_F],
            [CLIP/2, H-CLIP_F*2],
            [CLIP/2, -H+CLIP_F*2],
            [CLIP/2+CLIP_F, -H+CLIP_F],
            [CLIP/2, -H],
            [CLIP/2-CLIP_W, -H],
            [-CLIP/2+CLIP_W, H-CLIP_L],
            [-CLIP/2+CLIP_W, -H],
            [-CLIP/2, -H]
        ]);
}

module clip_gap(){
    union(){
        translate([0, 0, H/2]) 
            cube([CLIP + 2*D, CLIP + 2*D, H], center=true);
        translate([0, 0, -D/5]) pyramid4(CLIP+CLIP_F*4+2*D, CLIP/2+CLIP_F*2+2*D);
        translate([0, 0, H+D/5]) rotate([180, 0, 0]) pyramid4(CLIP+CLIP_F*4+2*D, CLIP/2+CLIP_F*2+2*D);
    }
}

module gear(){
    
}

module bevel(r, c, h){
    difference(){
        children(0);
        // r
        translate ([0, 0, 0]) rotate ([90, 0, 90]) prizm3rect(F, r*W);
        translate ([0, 0, h*H]) rotate ([90, 90, 90]) prizm3rect(F, r*W);
        translate ([0, c*W, 0]) rotate ([90, 270, 90]) prizm3rect(F, r*W);
        translate ([0, c*W, h*H]) rotate ([90, 180, 90]) prizm3rect(F, r*W);
        // c
        translate ([0, 0, 0]) rotate ([90, 270, 180]) prizm3rect(F, c*W);
        translate ([0, 0, h*H]) rotate ([90, 180, 180]) prizm3rect(F, c*W);
        translate ([r*W, 0, 0]) rotate ([90, 0, 180]) prizm3rect(F, c*W);
        translate ([r*W, 0, h*H]) rotate ([90, 90, 180]) prizm3rect(F, c*W);
        // h
        prizm3rect(F, h*H);
        translate ([r*W, 0, 0]) rotate ([0, 0, 90]) prizm3rect(F, h*H);
        translate ([r*W, c*W, 0]) rotate ([0, 0, 180]) prizm3rect(F, h*H);
        translate ([0, c*W, 0]) rotate ([0, 0, 270]) prizm3rect(F, h*H);
        
    }
}

module prizm3rect(a, h){
    linear_extrude(h) polygon([[0,0], [0,a], [a,0]]);
}

module pyramid4(a, h){
    points = [[a/2, -a/2, 0], [-a/2, -a/2, 0], [-a/2, a/2, 0], [a/2, a/2, 0], [0, 0, h]];
    faces = [[3, 2, 1, 0], [0, 1, 4], [1, 2, 4], [2, 3, 4], [3, 0, 4]];
    polyhedron(points = points, faces = faces);
}

