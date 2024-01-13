HOOK_RADIUS = 7;
TOLERANCE = 0.5;
HOOK_WIDTH = 2;

module hook_entry() {

    minkowski() {
        union() {
            cylinder(h=HOOK_WIDTH, r=HOOK_RADIUS, $fn=50);
            translate([0, -HOOK_RADIUS, 0])
            cube([20, 2 * HOOK_RADIUS, HOOK_WIDTH]);
        }
        sphere(r=TOLERANCE);
    }

}

