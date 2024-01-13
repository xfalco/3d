HOOK_RADIUS = 7;
INNER_HOOK_RADIUS = 6;
TOLERANCE = 0.5;
HOOK_WIDTH = 2;
INNER_HOOK_WIDTH = 2;



module hook_entry() {
    translate([0, 0, TOLERANCE + INNER_HOOK_WIDTH])
    minkowski() {
        union() {
            cylinder(h=HOOK_WIDTH, r=HOOK_RADIUS, $fn=50);
            translate([0, -HOOK_RADIUS, 0])
            cube([20, 2 * HOOK_RADIUS, HOOK_WIDTH]);
        }
        sphere(r=TOLERANCE);
    }
    translate([0, 0, -1])
    union() {
        cylinder(h=INNER_HOOK_WIDTH + 2, r=INNER_HOOK_RADIUS, $fn=50);
        translate([0, -INNER_HOOK_RADIUS, 0])
        cube([20, 2 * INNER_HOOK_RADIUS, INNER_HOOK_WIDTH + 2]);
    }
}

module hook_with_hull_entry() {
    hull() {
        translate([0, 0, TOLERANCE + INNER_HOOK_WIDTH])
        minkowski() {
            union() {
                cylinder(h=HOOK_WIDTH, r=HOOK_RADIUS, $fn=50);
                translate([0, -HOOK_RADIUS, 0])
                cube([20, 2 * HOOK_RADIUS, HOOK_WIDTH]);
            }
            sphere(r=TOLERANCE);
        }
        translate([0, 0, 1])
        union() {
            cylinder(h=INNER_HOOK_WIDTH - 1, r=INNER_HOOK_RADIUS, $fn=50);
            translate([0, -INNER_HOOK_RADIUS, 0])
            cube([20, 2 * INNER_HOOK_RADIUS, INNER_HOOK_WIDTH - 1]);
        }
    }
    translate([0, 0, -1])
    union() {
        cylinder(h=INNER_HOOK_WIDTH + 2, r=INNER_HOOK_RADIUS, $fn=50);
        translate([0, -INNER_HOOK_RADIUS, 0])
        cube([20, 2 * INNER_HOOK_RADIUS, INNER_HOOK_WIDTH + 2]);
    }

}

module foo() {
    difference() {
        translate([-15, -10, 0])
        cube([30, 20, 8]);
        hook_with_hull_entry();
    }
}


foo();