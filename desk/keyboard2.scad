 RADIUS = 10;
 WIDTH = 114; 
 LENGTH = 280;// - 30
 SHELL = 2;
 
 HEIGHT= 9;
 
 TOLERANCE = 1;
 
 HOLE_SIZE = 16;
 HOLE_SIZE_HORIZONTAL_DIFF = 5;
 HOLE_SIZE_VERTICAL_DIFF = 10;
 HOLE_RADIUS = 5;
 ROUNDNESS = 2;
 
 RAIL_LENGTH = LENGTH - 10;
 RAIL_RADIUS = 0.75;
 RAIL_HEIGHT = 1;
 
 NOTCH_INDENT = 1.5;
 NOTCH_HOOKS = 50;
 
  module cutoff_cube() {
     mirror([0, 1,0]) {
         translate([0, -WIDTH/2-TOLERANCE/2-SHELL -50,HEIGHT])
         rotate(a=3,v=[1, 0 ,0])
         translate([-200, 0, 0])
     cube([400, 300, 100]);
     }
}

 module rail() {
     translate([-LENGTH/2 + 20, -2 * RAIL_RADIUS, 0])
     cube([RAIL_LENGTH, 2 * RAIL_RADIUS,RAIL_HEIGHT]); 
     translate([-LENGTH/2 + 20, -RAIL_RADIUS, RAIL_HEIGHT])
     rotate(a=90, v=[0, 1, 0])
     cylinder(h=RAIL_LENGTH, r=RAIL_RADIUS, center=false, $fn=50);
 }
 
 module sides() {
  linear_extrude(height = 2 * HEIGHT, slices = 60, $fn=50) {
         difference() {
            offset(r=(RADIUS + SHELL)) {square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
            offset(r = RADIUS) { square([LENGTH - 2 * RADIUS + TOLERANCE, WIDTH - 2 * RADIUS + TOLERANCE], center = true); }
         }
     }
 }
 
 module sides_notch(extra = 0) {
  linear_extrude(height = 2 * HEIGHT + 5, slices = 60, $fn=50) {
         offset(r=(RADIUS + SHELL + extra)) {square([LENGTH - 2 * RADIUS + TOLERANCE - 2 * NOTCH_INDENT, WIDTH - 2 * RADIUS + TOLERANCE -  2 * NOTCH_INDENT], center = true); }
     }
     translate([NOTCH_HOOKS, 0.5 * (WIDTH - 2 * RADIUS + TOLERANCE -  2 * NOTCH_INDENT) + RADIUS + SHELL, HEIGHT])
     cylinder(r=(1 + extra), h=2 * HEIGHT + 5, $fn=50, center=true);
     translate([-NOTCH_HOOKS, 0.5 * (WIDTH - 2 * RADIUS + TOLERANCE -  2 * NOTCH_INDENT) + RADIUS + SHELL, HEIGHT])
     cylinder(r=(1 + extra), h=2 * HEIGHT + 5, $fn=50, center=true);
     translate([NOTCH_HOOKS, -0.5 * (WIDTH - 2 * RADIUS + TOLERANCE -  2 * NOTCH_INDENT) - RADIUS - SHELL, HEIGHT])
     cylinder(r=(1 + extra), h=2 * HEIGHT + 5, $fn=50, center=true);
     translate([-NOTCH_HOOKS, -0.5 * (WIDTH - 2 * RADIUS + TOLERANCE -  2 * NOTCH_INDENT) - RADIUS - SHELL, HEIGHT])
     cylinder(r=(1 + extra), h=2 * HEIGHT + 5, $fn=50, center=true);
 }
 
module notch(extra =0) {
  intersection() {
      sides_notch(extra);
      difference() {
        translate([0, 0, -5.5 - extra])
        cutoff_cube();
        translate([0, 0, -4.5 + extra])
        cutoff_cube();
      }
  }
}
 
 module cover_new() {
     translate([15, 0, 0]) {
         // outer side shell, with hole for plug
        difference() {
          sides();
           translate([-6.5,  -0.5 * (WIDTH - 2 * RADIUS + TOLERANCE) - RADIUS - 10, 2])
           cube([13, 20, 50]);
         }
         intersection() {
             // bottom shell
             translate([0, 0, -SHELL])
             minkowski() {
                linear_extrude(height = SHELL, slices = 60, $fn=50) {
                     offset(r=(RADIUS + SHELL)) {square([LENGTH - 2 * RADIUS + TOLERANCE - 2 * ROUNDNESS, WIDTH - 2 * RADIUS + TOLERANCE - 2* ROUNDNESS], center = true); }
                 }
                 sphere(r = ROUNDNESS, $fn = 50);
             }
             translate([-200, -200, -200])
             cube([400, 400, 200]);
         }
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

  module cover_new_with_holes(notch_padding = 0) {
     difference() {
         cover_new();
         
         // minus the corner
         translate([(LENGTH - HOLE_RADIUS - HOLE_SIZE_HORIZONTAL_DIFF - HOLE_SIZE + 2) / 2 + 30, -(WIDTH -5 - HOLE_RADIUS - HOLE_SIZE + 2) / 2 - 15, -2 * SHELL])
         linear_extrude(height = 5 * SHELL + 50, slices = 60, $fn=50) {
             offset(r=(HOLE_RADIUS)) {square([HOLE_SIZE + HOLE_SIZE_HORIZONTAL_DIFF - 2 * HOLE_RADIUS + TOLERANCE + 30, HOLE_SIZE + HOLE_SIZE_VERTICAL_DIFF - 5 - 2 * HOLE_RADIUS + TOLERANCE + 30], center = true); }
         }
        // translate([0, 0, -6])
        translate([0, 0, -3])
        cutoff_cube();
         translate([15, 0, 0])
        notch(notch_padding);
     }
 }

 module cover_right() {
     intersection() {
    cover_new_with_holes(0.5);
         translate([0, -200, -200])
         cube([400, 400, 400]);
     }
}

 module cover_left() {
     intersection() {
    cover_new_with_holes(0.5);
         translate([-400, -200, -200])
         cube([400, 400, 400]);
     }
}

module bump() {
    difference() {
        intersection() {
            translate([15, 0, 0]) sides();
            translate([0, 0, -7]) cutoff_cube();
        }
        translate([0, 0, -5]) cutoff_cube();
    }
}

module base() {
    rotate(a=3,v=[1, 0 ,0])
    intersection() {
        notch();
       cube([130, 120, 100], center=true);
    }
}

base();

// cover_left();
