// 3 cm for diameter inside

// + 12 AND 12 !

// NANIT PART
NANIT_BASE_RADIUS = 45;
NANIT_BASE_HEIGHT = 12;
NANIT_BASE_INNER_INDENT = 15;
NANIT_BASE_PADDING = 5; // 4
NANIT_SCREW_HOLE_RADIUS = 4;
NANIT_DEGREE_OPEN_TOP = 5;

// BOTTOM PART
PLATE_LENGTH = 45;
INNER_RADIUS = 12;
PADDING = 5;
HEIGHT = 2 * (NANIT_BASE_RADIUS + NANIT_BASE_PADDING);// 16

module base_wheel_block() {
    cylinder(h = NANIT_BASE_HEIGHT + 2 * NANIT_BASE_PADDING, r1 = NANIT_BASE_RADIUS + NANIT_BASE_PADDING, r2 = NANIT_BASE_RADIUS + NANIT_BASE_PADDING, center = true, $fn = 100);
    translate([-(NANIT_BASE_RADIUS + NANIT_BASE_PADDING), -(NANIT_BASE_RADIUS + NANIT_BASE_PADDING), -(NANIT_BASE_HEIGHT + 2 * NANIT_BASE_PADDING) / 2])
    cube([NANIT_BASE_RADIUS + NANIT_BASE_PADDING, NANIT_BASE_RADIUS + NANIT_BASE_PADDING, NANIT_BASE_HEIGHT + 2 * NANIT_BASE_PADDING]);
    translate([0, -(NANIT_BASE_RADIUS + NANIT_BASE_PADDING), -(NANIT_BASE_HEIGHT + 2 * NANIT_BASE_PADDING) / 2])
    cube([NANIT_BASE_RADIUS + NANIT_BASE_PADDING, NANIT_BASE_RADIUS + NANIT_BASE_PADDING, NANIT_BASE_HEIGHT + 2 * NANIT_BASE_PADDING]);
}

module wheel() {
    difference() {
        base_wheel_block();
        cylinder(h = NANIT_BASE_HEIGHT, r1 = NANIT_BASE_RADIUS, r2 = NANIT_BASE_RADIUS, center = true, $fn = 100);
        cylinder(h = NANIT_BASE_HEIGHT + NANIT_BASE_PADDING, r1 = (NANIT_BASE_RADIUS - NANIT_BASE_INNER_INDENT), r2 = (NANIT_BASE_RADIUS - NANIT_BASE_INNER_INDENT), $fn = 100);
        translate([-(NANIT_BASE_RADIUS + NANIT_BASE_PADDING + 1), 0, -(NANIT_BASE_HEIGHT / 2)])
        cube([2 * (NANIT_BASE_RADIUS + NANIT_BASE_PADDING) + 2, NANIT_BASE_RADIUS + NANIT_BASE_PADDING + 2, NANIT_BASE_HEIGHT + NANIT_BASE_PADDING + 2]);
        rotate(a=-NANIT_DEGREE_OPEN_TOP, v=[0, 0, 1])
        translate([-(NANIT_BASE_RADIUS + NANIT_BASE_PADDING + 1), 0, -(NANIT_BASE_HEIGHT / 2)])
        cube([2 * (NANIT_BASE_RADIUS + NANIT_BASE_PADDING) + 2, NANIT_BASE_RADIUS + NANIT_BASE_PADDING + 2, NANIT_BASE_HEIGHT + NANIT_BASE_PADDING + 2]);
        /*translate([0, -(NANIT_BASE_RADIUS + NANIT_BASE_PADDING + 1), -(NANIT_BASE_HEIGHT / 2)])
        cube([NANIT_BASE_RADIUS + NANIT_BASE_PADDING + 2, 2 * (NANIT_BASE_RADIUS + NANIT_BASE_PADDING) + 2, NANIT_BASE_HEIGHT + NANIT_BASE_PADDING + 2]);*/
    }
}

module extension() {
    translate([-(NANIT_BASE_RADIUS + NANIT_BASE_PADDING), 0, -(NANIT_BASE_HEIGHT + 2 * NANIT_BASE_PADDING) / 2])
    difference() {
        cube([NANIT_BASE_RADIUS + NANIT_BASE_PADDING, NANIT_BASE_RADIUS + NANIT_BASE_PADDING, NANIT_BASE_HEIGHT + 2 * NANIT_BASE_PADDING]);
        translate([NANIT_BASE_PADDING, -1, NANIT_BASE_PADDING])
        cube([NANIT_BASE_RADIUS + NANIT_BASE_PADDING, NANIT_BASE_RADIUS + NANIT_BASE_PADDING + 2, NANIT_BASE_HEIGHT]);
        translate([NANIT_BASE_PADDING + NANIT_BASE_INNER_INDENT, -1, NANIT_BASE_PADDING])
        cube([NANIT_BASE_RADIUS + NANIT_BASE_PADDING, NANIT_BASE_RADIUS + NANIT_BASE_PADDING + 2, NANIT_BASE_HEIGHT + 2 * NANIT_BASE_PADDING]);
    }
}

module nanit_hold() {
    translate([0, 0, NANIT_BASE_RADIUS + NANIT_BASE_PADDING])
    rotate(a = -90, v = [0, 1, 0])
    difference() {
        union() {
            wheel();
            extension();
        }
        cylinder(h = NANIT_BASE_HEIGHT + 2 * NANIT_BASE_PADDING + 2, r1 = NANIT_SCREW_HOLE_RADIUS, r2 = NANIT_SCREW_HOLE_RADIUS, center = true, $fn = 100);
    }
}

module base_hold() {
    cylinder(h = HEIGHT, r1 = INNER_RADIUS + PADDING, r2 = INNER_RADIUS + PADDING, center = true, $fn = 100);
    translate([-(INNER_RADIUS + PADDING), -(INNER_RADIUS + PADDING), -(HEIGHT / 2)])
    cube([INNER_RADIUS + PADDING, 2 * (INNER_RADIUS + PADDING), HEIGHT]);
}

module plate() {
    cube([PLATE_LENGTH, PADDING, HEIGHT]);
}


module base_grab() {
    translate([0, 0, -(INNER_RADIUS + PADDING)])
    rotate(a = 90, v=[0, 1, 0])
    rotate(a=90, v=[1, 0, 0]) {
        difference() {
            base_hold();
            translate([0, 0, -2])
            cylinder(h = HEIGHT + 5, r1 = INNER_RADIUS, r2 = INNER_RADIUS, center = true, $fn = 100);
            translate([0, -20, -(HEIGHT / 2) - 2])
            cube([INNER_RADIUS + 5, 2 * INNER_RADIUS + 10, HEIGHT + 5]);
        }

        translate([0, INNER_RADIUS, -(HEIGHT / 2)])
        plate();

        translate([0, -INNER_RADIUS - PADDING, -(HEIGHT / 2)])
        plate();
    }
}


rotate(a=90, v=[1, 0, 0]) {
    nanit_hold();
    base_grab();
}





