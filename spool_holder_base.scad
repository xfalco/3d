HEIGHT_BASE=5;
HEIGHT_FRAME=5;

LENGTH=142;
WIDTH=84;
TRACK_WIDTH=25;

PADDING = 5;

module track() {
    difference() {
        cube([TRACK_WIDTH + 2 * PADDING, LENGTH + 2 * PADDING, HEIGHT_FRAME]);
        translate([PADDING, PADDING, -1])
        cube([TRACK_WIDTH, LENGTH, HEIGHT_FRAME + 2]);
    }
}

translate([0, 0, HEIGHT_BASE])
track(); 

translate([WIDTH - TRACK_WIDTH, 0, HEIGHT_BASE])
track(); 

cube([WIDTH + 2 * PADDING, LENGTH + 2 * PADDING, HEIGHT_BASE]);