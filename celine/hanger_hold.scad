INNER_RADIUS = 1;
OUTER_RADIUS = 3;

WIDTH = 2 * (INNER_RADIUS + 2 * OUTER_RADIUS);
HOLE_HEIGHT = 4;
HOLE_WIDTH = 8;
PADDING = 0;
BOTTOM_PADDING = 2.5;

RADIUS_CURVE = 3;

HOLD_CUBE_SIZE = 5;
HOLD_CUBE_INDENT = 2.5;
HOLD_CUBE_RETRACT = 1;

HOLD_CUBE_EXTEND = 175;

SCREW_HOLE_RADIUS = 2.5;
SCREW_HOLES_DISTANCE = 33;
SCREW_HOLE_HEIGHT = 5;

SCREWS_PADDING = 3;

module notch() {
    translate([WIDTH / 2, (PADDING + RADIUS_CURVE + HOLE_HEIGHT - HOLD_CUBE_INDENT), PADDING- HOLD_CUBE_RETRACT])
        difference() {
            translate([0, HOLD_CUBE_INDENT + 2, -3.5])
            rotate(a=90, v=[1, 0, 0])
            rotate(a = 45, v=[0, 0, 1])
            cube([HOLD_CUBE_SIZE, HOLD_CUBE_SIZE, HOLD_CUBE_INDENT + 2]);
            translate([-2 * HOLD_CUBE_SIZE, -2 * HOLD_CUBE_INDENT, -4 * HOLD_CUBE_SIZE -1 + HOLD_CUBE_RETRACT])
            cube([4 * HOLD_CUBE_SIZE, 4 * HOLD_CUBE_INDENT, 4 * HOLD_CUBE_SIZE]);
        }
}

module rounded_corner_1() {
    translate([0, PADDING, PADDING])
        difference() {
            cube([WIDTH, RADIUS_CURVE, RADIUS_CURVE]);
            translate([-1, RADIUS_CURVE, RADIUS_CURVE])
            rotate(a = 90, v = [0, 1, 0])
            cylinder(h = WIDTH + 2, r1 = RADIUS_CURVE, r2 = RADIUS_CURVE, center = false, $fn = 100);
        }
}

module rounded_corner_2() {
    translate([0, PADDING, HOLE_WIDTH + PADDING - RADIUS_CURVE])
        difference() {
            cube([WIDTH, RADIUS_CURVE, RADIUS_CURVE]);
            translate([-1, RADIUS_CURVE, 0])
            rotate(a = 90, v = [0, 1, 0])
            cylinder(h = WIDTH + 2, r1 = RADIUS_CURVE, r2 = RADIUS_CURVE, center = false, $fn = 100);
        }
}

module slotted_end() {
    difference() {
            cube([WIDTH, HOLE_HEIGHT + PADDING + BOTTOM_PADDING + RADIUS_CURVE, HOLE_WIDTH + 2 * PADDING]);
            translate([-1, PADDING, PADDING])
            cube([WIDTH + 2, HOLE_HEIGHT + RADIUS_CURVE, HOLE_WIDTH]);
        }
}

module notched_slotted_end() {
    notch();
    rounded_corner_1();
    rounded_corner_2();
    slotted_end();
}

module fitted_end() {
    translate([-(2 * SCREWS_PADDING + SCREW_HOLES_DISTANCE + 2 * SCREW_HOLE_RADIUS) / 2 + WIDTH / 2, SCREW_HOLE_HEIGHT, -(2 * (SCREW_HOLE_RADIUS + SCREWS_PADDING) - (HOLE_WIDTH + 2 * PADDING)) / 2])
    rotate(a=90, v=[1, 0, 0]) {
        difference() {
            cube([2 * SCREWS_PADDING + SCREW_HOLES_DISTANCE + 2 * SCREW_HOLE_RADIUS, 2 * (SCREWS_PADDING + SCREW_HOLE_RADIUS), SCREW_HOLE_HEIGHT]);
            translate([SCREWS_PADDING + SCREW_HOLE_RADIUS, SCREWS_PADDING + SCREW_HOLE_RADIUS, 0])
            cylinder(h = SCREW_HOLE_HEIGHT + 10, r1 = SCREW_HOLE_RADIUS, r2 = SCREW_HOLE_RADIUS, center = true, $fn = 100);
            translate([SCREW_HOLES_DISTANCE + SCREWS_PADDING + SCREW_HOLE_RADIUS, SCREWS_PADDING + SCREW_HOLE_RADIUS, 0])
            cylinder(h = SCREW_HOLE_HEIGHT + 10, r1 = SCREW_HOLE_RADIUS, r2 = SCREW_HOLE_RADIUS, center = true, $fn = 100);
        }
    }
}

module extension() {
    translate([-(WIDTH/2), (INNER_RADIUS + 2 * OUTER_RADIUS - PADDING) - 1, -(HOLE_WIDTH + 2 * PADDING) / 2])
cube([WIDTH, HOLD_CUBE_EXTEND, HOLE_WIDTH + 2 * PADDING]);
}



rotate(a = -90, v = [1, 0, 0]) {
    extension();
    
    translate([-(WIDTH / 2), 1 + (INNER_RADIUS + 2 * OUTER_RADIUS - PADDING) + HOLD_CUBE_EXTEND - 2, -(HOLE_WIDTH + 2 * PADDING) / 2]) {
        fitted_end();
    }

    rotate_extrude(convexity = 10, $fn = 100)
    translate([(INNER_RADIUS + OUTER_RADIUS), 0, 0])
    circle(r=OUTER_RADIUS, $fn = 100);
}
