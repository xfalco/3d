
module top_right_corner() {
    intersection() {
        linear_extrude(height = 22, slices = 60, $fn=50) {
           difference() {
             offset(r = 8) {
              square(8, center = true);
             }
             offset(r = 6) {
               square(8, center = true);
             }
           }
         }
         translate([0,0,-1])
         cube([20, 20, 40]);
     }
     intersection () {
         translate([0, 0, -2])
          linear_extrude(height = 2, slices = 60, $fn=50) {
           offset(r = 8) {
              square(8, center = true);
             }
         }
         translate([0,0,-10])
         cube([20, 20, 40]);
     }
 }
 module top_left_corner() {
     intersection() {
     translate([-3, -3, 0])
     linear_extrude(height = 22, slices = 60, $fn=50) {
         difference() {
            offset(r=12) {square(6, center = true); }
            offset(r = 10) { square(6, center = true); }
         }
     }
     translate([-40, 0 , -1])
     cube([40, 40, 40]);
     }
     intersection () {
        translate([-3, -3, -2])
          linear_extrude(height = 2, slices = 60, $fn=50) {
            offset(r=12) {square(6, center = true); }
         }
         translate([-40,0,-10])
         cube([40, 40, 40]);
     }
 }
 
module bottom_left_corner() {
 intersection() {
     translate([-3, 3, 0])
     linear_extrude(height = 22, slices = 60, $fn=50) {
         difference() {
            offset(r=12) {square(6, center = true); }
            offset(r = 10) { square(6, center = true); }
         }
     }
     translate([-40, -40 , -1])
     cube([40, 40, 40]);
     }
     intersection () {
        translate([-3, 3, -2])
          linear_extrude(height = 2, slices = 60, $fn=50) {
            offset(r=12) {square(6, center = true); }
         }
         translate([-40,-40,-10])
         cube([40, 40, 40]);
     }
 }
 
 module bottom_right_corner() {
     translate([0, -12, -2])
     cube([12, 12, 2]);
     translate([10, -12, -2])
     cube([2, 12, 24]);
     translate([0, -12, -2])
     cube([12, 2, 24]);
 }
 
 module base() {
     top_right_corner();
     top_left_corner();
     bottom_left_corner();
     bottom_right_corner();
 }
 
 module previous() {
     translate([0, 0, 12])
     rotate(a=90, v=[0, 1, 0])
     difference() {
         base();
         translate([-40, -10, 0])
         cube([40, 20, 20]);
         translate([-30, -20, 0])
         cube([40, 20, 20]);
     }
 }
 
 RADIUS = 10;
 WIDTH = 114;
 LENGTH = 310;
 SHELL = 2;
 
 HEIGHT= 10;
 
 TOLERANCE = 1;
 
 HOLE_SIZE = 16;
 HOLE_SIZE_HORIZONTAL_DIFF = 5;
 HOLE_SIZE_VERTICAL_DIFF = 10;
 HOLE_RADIUS = 5;
 
 // 19 and then 18.5, 18.5 ...
 

module cover() {
    difference() {
  linear_extrude(height = 2 * HEIGHT, slices = 60, $fn=50) {
         difference() {
            offset(r=(RADIUS + SHELL)) {square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
            offset(r = RADIUS) { square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
         }
     }
   translate([10,  -0.5 * (WIDTH - 2 * RADIUS + TOLERANCE) - RADIUS - 10, 8])
   cube([13, 20, 50]);
 }
     translate([0, 0, -SHELL])
    linear_extrude(height = SHELL, slices = 60, $fn=50) {
         offset(r=(RADIUS + SHELL)) {square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
     }
     union() {
         translate([0, 0.5 * (WIDTH - 2 * RADIUS + TOLERANCE) + RADIUS - 3, 0])
         cube([100, 5, 12]);
         translate([0, -0.5 * (WIDTH - 2 * RADIUS + TOLERANCE) - RADIUS - 2, 0])
         cube([100, 5, 12]);
     }
 }
 
 module cover_with_hole() {
     difference() {
         cover();
         translate([(LENGTH - 20) / 2, -(WIDTH - 20) / 2 , 0])
            intersection() {
             translate([0, 0, -2 * SHELL])
             linear_extrude(height = 5 * SHELL, slices = 60, $fn=50) {
                 offset(r=(RADIUS)) {square(1, center = true); }
             }
             translate([0, -50, -25])
             cube([50, 50, 50]);
         }
         // top right
         translate([(LENGTH - HOLE_RADIUS - HOLE_SIZE_HORIZONTAL_DIFF - HOLE_SIZE + 2) / 2 + 15, -(WIDTH -5 - HOLE_RADIUS - HOLE_SIZE + 2) / 2 - 15, -2 * SHELL])
         linear_extrude(height = 5 * SHELL + 50, slices = 60, $fn=50) {
             offset(r=(HOLE_RADIUS)) {square([HOLE_SIZE + HOLE_SIZE_HORIZONTAL_DIFF - 2 * HOLE_RADIUS + TOLERANCE + 30, HOLE_SIZE + HOLE_SIZE_VERTICAL_DIFF - 5 - 2 * HOLE_RADIUS + TOLERANCE + 30], center = true); }
         }
         // top left
         /*
         translate([(LENGTH - HOLE_RADIUS - HOLE_SIZE_HORIZONTAL_DIFF - HOLE_SIZE + 5) / 2, -(WIDTH - HOLE_RADIUS - HOLE_SIZE + 2) / 2, -2 * SHELL])
         intersection() {
             linear_extrude(height = 5 * SHELL, slices = 60, $fn=50) {
                 offset(r=(HOLE_RADIUS)) {square([HOLE_SIZE - 2 * HOLE_RADIUS + HOLE_SIZE_HORIZONTAL_DIFF + TOLERANCE, HOLE_SIZE - 2 * HOLE_RADIUS + TOLERANCE + HOLE_SIZE_VERTICAL_DIFF + 5], center = true); }
             }
             translate([0, 0, -25])
             cube([50, 50, 50]);
         }
         translate([(LENGTH - HOLE_RADIUS - HOLE_SIZE_HORIZONTAL_DIFF - HOLE_SIZE + 5) / 2, -(WIDTH - HOLE_RADIUS - HOLE_SIZE + 2) / 2, -2 * SHELL])
         intersection() {
             linear_extrude(height = 15 * SHELL, slices = 60, $fn=50) {
                 offset(r=(HOLE_RADIUS)) {square([HOLE_SIZE - 2 * HOLE_RADIUS + HOLE_SIZE_HORIZONTAL_DIFF + TOLERANCE + 20, HOLE_SIZE - 2 * HOLE_RADIUS + TOLERANCE + HOLE_SIZE_VERTICAL_DIFF + 5], center = true); }
             }
             translate([0, 0, -25])
             cube([50, 50, 50]);
         }
         // bottom right
         translate([(LENGTH - HOLE_RADIUS + 5 - HOLE_SIZE_HORIZONTAL_DIFF - HOLE_SIZE + 2) / 2, -(WIDTH - HOLE_RADIUS - HOLE_SIZE + 5) / 2, -2 * SHELL])
         intersection() {
             linear_extrude(height = 5 * SHELL, slices = 60, $fn=50) {
                 offset(r=(HOLE_RADIUS)) {square([HOLE_SIZE + 5 + HOLE_SIZE_HORIZONTAL_DIFF - 2 * HOLE_RADIUS + TOLERANCE, HOLE_SIZE - 2 * HOLE_RADIUS + TOLERANCE], center = true); }
             }
             translate([-100, -100, -25])
             cube([100, 100, 50]);
         }
         */
     }
 }
 
 RAIL_LENGTH = 100;
 RAIL_RADIUS = 0.75;
 RAIL_HEIGHT = 1;
 RAIL_INDENT = 10;
 
 module rail() {
     translate([RAIL_INDENT, -2 * RAIL_RADIUS, 0])
     cube([RAIL_LENGTH, 2 * RAIL_RADIUS,RAIL_HEIGHT]); 
     translate([RAIL_INDENT, -RAIL_RADIUS, RAIL_HEIGHT])
     rotate(a=90, v=[0, 1, 0])
     cylinder(h=RAIL_LENGTH, r=RAIL_RADIUS, center=false, $fn=50);
 }
 
 NEW_HEIGHT = 8;
 
 module cover_new() {
     // outer side shell, with hole for plug
    difference() {
      linear_extrude(height = 2 * NEW_HEIGHT, slices = 60, $fn=50) {
             difference() {
                offset(r=(RADIUS + SHELL)) {square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
                offset(r = RADIUS) { square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
             }
         }
       translate([10,  -0.5 * (WIDTH - 2 * RADIUS + TOLERANCE) - RADIUS - 10, 2])
       cube([13, 20, 50]);
     }
     // bottom shell
     translate([0, 0, -SHELL])
        linear_extrude(height = SHELL, slices = 60, $fn=50) {
             offset(r=(RADIUS + SHELL)) {square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
     }
     
     // rails
     translate([0, RADIUS + 0.5 *(WIDTH - 2 * RADIUS + TOLERANCE), 0])
     rail();
     
     for (idx =[0:4]) {
         translate([0, RADIUS + 0.5 *(WIDTH - 2 * RADIUS + TOLERANCE) - 20 - 18.5 * idx, 0])
     rail();
     }
     translate([0, RADIUS + 0.5 *(WIDTH - 2 * RADIUS + TOLERANCE)- 20 - 18.5 * 4 - 20, 0])
     rail();
 }
 
  module cover_new_with_holes() {
     difference() {
         cover_new();
         translate([(LENGTH - 20) / 2, -(WIDTH - 20) / 2 , 0])
            intersection() {
             translate([0, 0, -2 * SHELL])
             linear_extrude(height = 5 * SHELL, slices = 60, $fn=50) {
                 offset(r=(RADIUS)) {square(1, center = true); }
             }
             translate([0, -50, -25])
             cube([50, 50, 50]);
         }
         // minus the corner
         translate([(LENGTH - HOLE_RADIUS - HOLE_SIZE_HORIZONTAL_DIFF - HOLE_SIZE + 2) / 2 + 15, -(WIDTH -5 - HOLE_RADIUS - HOLE_SIZE + 2) / 2 - 15, -2 * SHELL])
         linear_extrude(height = 5 * SHELL + 50, slices = 60, $fn=50) {
             offset(r=(HOLE_RADIUS)) {square([HOLE_SIZE + HOLE_SIZE_HORIZONTAL_DIFF - 2 * HOLE_RADIUS + TOLERANCE + 30, HOLE_SIZE + HOLE_SIZE_VERTICAL_DIFF - 5 - 2 * HOLE_RADIUS + TOLERANCE + 30], center = true); }
         }
         translate([0, 0, -7])
        cutoff_cube();
     }
 }
 
 module bottom_new() {
    intersection() {
        cover_new_with_holes();
         translate([0, -100, -100])
         cube([200, 200, 200]);
    }
}

 
 module trunk() {
     intersection() {
         cover_with_hole();
         // cover();
         translate([0, -100, -100])
         cube([200, 200, 200]);
     }
 }
 
 module cutoff_cube() {
     mirror([0, 1,0]) {
         translate([0, -WIDTH/2-TOLERANCE/2-SHELL -50,HEIGHT])
         rotate(a=3,v=[1, 0 ,0])
         translate([-200, 0, 0])
     cube([400, 300, 100]);
     }
}

module bottom() {
    difference() {
        trunk();
        cutoff_cube();
    }
}

module cover_top() {
    difference() {
      linear_extrude(height = 2 * HEIGHT, slices = 60, $fn=50) {
             difference() {
                offset(r=(RADIUS + 2 * SHELL + TOLERANCE)) {square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
                offset(r = (RADIUS+SHELL + TOLERANCE)) { square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
             }
         }
         cutoff_cube();
     }
     intersection() {
         linear_extrude(height = 2 * HEIGHT + SHELL, slices = 60, $fn=50) {
             offset(r=(RADIUS + 2 * SHELL + TOLERANCE)) {square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
         }
         cutoff_cube();
     }
 }
 
module top() {
    difference() {
        intersection() {
        cover_top();
         translate([0, -100, -100])
         cube([200, 200, 200]);
        }
    // top right
         translate([(LENGTH - HOLE_RADIUS - HOLE_SIZE_HORIZONTAL_DIFF - HOLE_SIZE + 2) / 2 + 15, -(WIDTH -5 - HOLE_RADIUS - HOLE_SIZE + 2) / 2 - 15, -2 * SHELL])
         linear_extrude(height = 5 * SHELL + 50, slices = 60, $fn=50) {
             offset(r=(HOLE_RADIUS)) {square([HOLE_SIZE + HOLE_SIZE_HORIZONTAL_DIFF - 2 * HOLE_RADIUS + TOLERANCE + 30, HOLE_SIZE + HOLE_SIZE_VERTICAL_DIFF - 5 - 2 * HOLE_RADIUS + TOLERANCE + 30], center = true); }
         }
   translate([10,  -0.5 * (WIDTH - 2 * RADIUS + TOLERANCE) - RADIUS - 20, -5])
   cube([13, 20, 100]);
     }
}
bottom_new();