LOCK_RADIUS = 3;
LOCK_ENCLOSURE_THICKNESS = 1.5;

WIDTH = 15;
HEIGHT = 5;
RAIL = 20;
THICKNESS = 2.5;
THICKNESS_FLEXIBLE = 1.25;
GAME = 0.4;

SNAP_RADIUS = 4;

STICK_LENGTH = 180;
RING_LENGTH = 10;
RING_THICKNESS = 2.5;

/*

|-|--OxxxxxxxxxxxxO--|-|--OxxxxxxxxxxxxO--|-|
 A  B      C       B  A  B       C      B  A
 
total = 520
A = WIDTH + 2 * THICKNESS
C = STICK_LENGTH
B = (520 - 2 * STICK_LENGTH - 3 * (WIDTH + 2 * THICKNESS + 2 * GAME)) / 4

*/

EXTENSION = (520 - 2 * STICK_LENGTH - 3 * (WIDTH + 2 * THICKNESS + 2 * GAME)) / 4;
EXTENSION_THICK = 10;
EXTENSION_THIN = 3;

CLIP_LENGTH_BOTTOM = 30;
CLIP_LENGTH_TOP = 20;
CLIP_HEIGHT = 8;
CLIP_SPACING = 5.3;
CLIP_SCALE = 2.5;

LENGTH_BOTTOM = WIDTH + 2 * THICKNESS + 2 * GAME + EXTENSION + RAIL;
WIDTH_BOTTOM = 2 * GAME + WIDTH + 2 * THICKNESS;
HEIGHT_BOTTOM = HEIGHT + 2 * GAME + THICKNESS;

LENGTH_TOP = WIDTH + 3 * THICKNESS + 3 * GAME + EXTENSION + RAIL;
WIDTH_TOP = WIDTH + 4 * THICKNESS + 4 * GAME;
HEIGHT_TOP = HEIGHT + 2 * THICKNESS + 4 * GAME;

module bottom_lock2() {
    cube([LENGTH_BOTTOM, WIDTH_BOTTOM, THICKNESS]);
    cube([LENGTH_BOTTOM, THICKNESS, HEIGHT_BOTTOM]);
    cube([THICKNESS, WIDTH_BOTTOM, HEIGHT_BOTTOM]);
    translate([0, WIDTH_BOTTOM - THICKNESS, 0])
    cube([LENGTH_BOTTOM, THICKNESS, HEIGHT_BOTTOM]);
    translate([2 * GAME + WIDTH + THICKNESS, 0, 0])
    cube([THICKNESS, WIDTH_BOTTOM, HEIGHT_BOTTOM]);
}

module top_lock2() {
    difference() {
        cube([LENGTH_TOP, WIDTH_TOP, THICKNESS]);
        translate([WIDTH + 2 * THICKNESS + 2 * GAME + EXTENSION, WIDTH_TOP / 2, 0])
        cylinder(h = THICKNESS * 3, r1= SNAP_RADIUS, r2 = SNAP_RADIUS, $fn = 100, center = true);
    }
    cube([LENGTH_TOP, THICKNESS, HEIGHT_TOP]);
    cube([THICKNESS, WIDTH_TOP, HEIGHT_TOP]);
    translate([0, WIDTH_TOP - THICKNESS, 0])
    cube([LENGTH_TOP, THICKNESS, HEIGHT_TOP]);
    /*
    length_thick = THICKNESS + GAME + THICKNESS + WIDTH + THICKNESS + GAME + EXTENSION_THICK;
    width = THICKNESS + GAME + THICKNESS + GAME + WIDTH + THICKNESS + GAME + THICKNESS + GAME;
    height = HEIGHT + 2 * THICKNESS + 4 * GAME;
    cube([length_thick, width, THICKNESS]);
    cube([length_thick, THICKNESS, height]);
    cube([THICKNESS, width, height]);
    translate([0, width - THICKNESS, 0])
    cube([length_thick, THICKNESS, height]);
    difference() {
        union() {
            cube([length_thick + EXTENSION - EXTENSION_THICK + RAIL, width, THICKNESS_FLEXIBLE]);
            translate([length_thick + EXTENSION_THIN, 0, 0])
            cube([(EXTENSION - EXTENSION_THICK - EXTENSION_THIN) + RAIL, width, THICKNESS]);
        }
        translate([length_thick + (EXTENSION - EXTENSION_THICK), width / 2, 0])
        cylinder(h = THICKNESS * 3, r1= SNAP_RADIUS, r2 = SNAP_RADIUS, $fn = 100, center = true);
    }
    */
}

module bottom_lock2_k() {
    bottom_lock2();
    translate([WIDTH_BOTTOM, 0, 0])
    rotate(a=90, v=[0, 0, 1])
    bottom_lock2();
    translate([WIDTH_BOTTOM, WIDTH_BOTTOM, 0])
    rotate(a=180, v=[0, 0, 1])
    bottom_lock2();
}

module bottom_lock2_corner() {
    bottom_lock2();
    translate([WIDTH_BOTTOM, 0, 0])
    rotate(a=90, v=[0, 0, 1])
    bottom_lock2();
}

module top_lock2_corner() {
    difference() {
        union() {
            top_lock2();
            translate([WIDTH_TOP, 0, 0])
            rotate(a=90, v=[0, 0, 1])
            top_lock2();
        }
        translate([THICKNESS, THICKNESS, THICKNESS])
        cube([LENGTH_TOP + 1, WIDTH_TOP - 2 * THICKNESS, HEIGHT_TOP]);
        translate([THICKNESS, THICKNESS, THICKNESS])
        cube([WIDTH_TOP - 2 * THICKNESS, LENGTH_TOP + 1, HEIGHT_TOP]);
    }
}

module top_lock2_k() {
    difference() {
        union() {
            top_lock2();
            translate([WIDTH_TOP, 0, 0])
            rotate(a=90, v=[0, 0, 1])
            top_lock2();
            translate([WIDTH_TOP, WIDTH_TOP, 0])
            rotate(a=180, v=[0, 0, 1])
            top_lock2();
        }
        translate([THICKNESS, THICKNESS, THICKNESS])
        cube([LENGTH_TOP + 1, WIDTH_TOP - 2 * THICKNESS, HEIGHT_TOP]);
        translate([THICKNESS, THICKNESS, THICKNESS])
        cube([WIDTH_TOP - 2 * THICKNESS, LENGTH_TOP + 1, HEIGHT_TOP]);
        translate([-(LENGTH_TOP - THICKNESS), THICKNESS, THICKNESS])
        cube([LENGTH_TOP + 1, WIDTH_TOP - 2 * THICKNESS, HEIGHT_TOP]);
    }
}

module bottom_lock2_center() {
    bottom_lock2();
    translate([WIDTH_BOTTOM, 0, 0])
    rotate(a=90, v=[0, 0, 1])
    bottom_lock2();
    translate([WIDTH_BOTTOM, WIDTH_BOTTOM, 0])
    rotate(a=180, v=[0, 0, 1])
    bottom_lock2();
    translate([0, WIDTH_BOTTOM, 0])
    rotate(a=-90, v=[0, 0, 1])
    bottom_lock2();
}

module top_lock2_center() {
    difference() {
        union() {
            top_lock2();
            translate([WIDTH_TOP, 0, 0])
            rotate(a=90, v=[0, 0, 1])
            top_lock2();
            translate([WIDTH_TOP, WIDTH_TOP, 0])
            rotate(a=180, v=[0, 0, 1])
            top_lock2();
            translate([0, WIDTH_BOTTOM, 0])
            rotate(a=-90, v=[0, 0, 1])
            top_lock2();
        }
        translate([THICKNESS, THICKNESS, THICKNESS])
        cube([LENGTH_TOP + 1, WIDTH_TOP - 2 * THICKNESS, HEIGHT_TOP]);
        translate([THICKNESS, THICKNESS, THICKNESS])
        cube([WIDTH_TOP - 2 * THICKNESS, LENGTH_TOP + 1, HEIGHT_TOP]);
        translate([-(LENGTH_TOP - THICKNESS), THICKNESS, THICKNESS])
        cube([LENGTH_TOP + 1, WIDTH_TOP - 2 * THICKNESS, HEIGHT_TOP]);
        translate([THICKNESS, -(LENGTH_TOP - THICKNESS), THICKNESS])
        cube([WIDTH_TOP - 2 * THICKNESS, LENGTH_TOP + 1, HEIGHT_TOP]);
    }
}

module ring() {
    inner_width = WIDTH + 4 * THICKNESS + 6 * GAME;
    inner_height = HEIGHT + 2 * THICKNESS + 4 * GAME;
    difference() {
        cube([inner_width + 2 * RING_THICKNESS, inner_height + 2 * RING_THICKNESS, RING_LENGTH]);
        translate([RING_THICKNESS, RING_THICKNESS, -1])
        cube([inner_width, inner_height, RING_LENGTH + 2]);
    }
}


module bottom_lock() {
    cube([EXTENSION_THICK + EXTENSION_THIN + RAIL + 2 * WIDTH + THICKNESS, WIDTH + 2 * THICKNESS + 2 * GAME, THICKNESS]);
    cube([THICKNESS, WIDTH + 2 * THICKNESS + 2 * GAME, THICKNESS + HEIGHT + 2 * GAME]);
    cube([EXTENSION_THICK + EXTENSION_THIN + RAIL + 2 * WIDTH + THICKNESS, THICKNESS, THICKNESS + HEIGHT + 2 * GAME]);
    translate([0, WIDTH + THICKNESS + 2 * GAME, 0])
    cube([EXTENSION_THICK + EXTENSION_THIN + RAIL + 2 * WIDTH + THICKNESS, THICKNESS, THICKNESS + HEIGHT + 2 * GAME]);
    translate([(WIDTH + 2 * THICKNESS) / 2, (WIDTH + 2 * THICKNESS + 2 * GAME) / 2, 0])
    difference() {
        cylinder(h = THICKNESS + HEIGHT + 2 * GAME, r1 = (LOCK_RADIUS + LOCK_ENCLOSURE_THICKNESS + GAME), r2 = (LOCK_RADIUS + LOCK_ENCLOSURE_THICKNESS + GAME), $fn = 100);
        translate([0, 0, -1])
        cylinder(h = THICKNESS + HEIGHT + 2 * GAME + 2, r1 = LOCK_RADIUS + GAME, r2 = LOCK_RADIUS + GAME, $fn = 100);
    }
}

module top_lock() {
    cube([EXTENSION_THICK + WIDTH + 2 * THICKNESS + GAME, WIDTH + 4 * THICKNESS + 4 * GAME, THICKNESS]);
    translate([EXTENSION_THICK + WIDTH + 2 * THICKNESS + GAME, 0, 0])
    difference() {
        cube([EXTENSION_THIN + WIDTH + RAIL, WIDTH + 4 * THICKNESS + 4 * GAME, THICKNESS_FLEXIBLE]);
        /*
        translate([0, 0, THICKNESS])
        rotate(a=-90, v=[1, 0, 0])
        linear_extrude(height= WIDTH + 4 * THICKNESS + 4 * GAME, $fn=100) 
        polygon(points=[[0,0],[EXTENSION_THIN + WIDTH + RAIL,0],[0, THICKNESS]]);*/
        translate([EXTENSION_THIN + WIDTH / 2, 2 * THICKNESS + GAME + WIDTH / 2 , -1])
        cylinder(h = THICKNESS + 2, r1 = SNAP_RADIUS , r2 = SNAP_RADIUS, $fn = 100);
    }
    cube([EXTENSION_THICK + WIDTH + 2 * THICKNESS + GAME, THICKNESS, 2 * THICKNESS + HEIGHT + 2 * GAME]);
    cube([THICKNESS, WIDTH + 4 * THICKNESS + 2 * GAME, 2 * THICKNESS + HEIGHT + 2 * GAME]);
    translate([0, WIDTH + 3 * THICKNESS + 4 * GAME, 0])
    cube([EXTENSION_THICK + WIDTH + 2 * THICKNESS + GAME, THICKNESS, 2 * THICKNESS + HEIGHT + 2 * GAME]);
    translate([2 * THICKNESS + WIDTH / 2 + GAME, 2 * THICKNESS + 2 * GAME + WIDTH / 2, 0])
    cylinder(h = THICKNESS + HEIGHT + 2 * GAME, r1 = LOCK_RADIUS, r2 = LOCK_RADIUS, $fn = 100);
}

module test_stick() {
    cube([STICK_LENGTH, WIDTH, HEIGHT]);
    translate([0, WIDTH / 2, 0])
    cylinder(h = HEIGHT, r1 = WIDTH / 2, r2 = WIDTH /2, $fn = 100);
    translate([0, WIDTH / 2, HEIGHT])
    difference() {
        sphere(r = SNAP_RADIUS, $fn = 100);
        translate([-WIDTH/2, -WIDTH/2, -WIDTH])
        cube([WIDTH, WIDTH, WIDTH]);
    }
}

module half_stick() {
    translate([-STICK_LENGTH / 2, -WIDTH/2 , 0]) {
        cube([STICK_LENGTH / 2, WIDTH, HEIGHT]);
        translate([0, WIDTH / 2, 0])
        cylinder(h = HEIGHT, r1 = WIDTH / 2, r2 = WIDTH /2, $fn = 100);
        translate([0, WIDTH / 2, HEIGHT])
        difference() {
            sphere(r = SNAP_RADIUS, $fn = 100);
            translate([-WIDTH/2, -WIDTH/2, -WIDTH])
            cube([WIDTH, WIDTH, WIDTH]);
        }
    }
}

module clip() {
    difference() {
        linear_extrude(height=CLIP_HEIGHT * CLIP_SCALE, scale = [ 1 - ((CLIP_LENGTH_BOTTOM - CLIP_LENGTH_TOP) / CLIP_LENGTH_BOTTOM) * CLIP_SCALE, 1 - ((WIDTH - CLIP_SPACING) / WIDTH) * CLIP_SCALE], $fn = 100)
        translate([-CLIP_LENGTH_BOTTOM/2, -WIDTH/2, 0])
        polygon(points=[[0, 0], [CLIP_LENGTH_BOTTOM, 0], [CLIP_LENGTH_BOTTOM, WIDTH], [0, WIDTH]]);
        translate([-CLIP_LENGTH_BOTTOM / 2, -WIDTH/2, CLIP_HEIGHT])
        cube([CLIP_LENGTH_BOTTOM, WIDTH, CLIP_SCALE * CLIP_HEIGHT]);
        translate([-CLIP_LENGTH_BOTTOM/2 - 1, -CLIP_SPACING/2, -1])
        cube([CLIP_LENGTH_BOTTOM + 2, CLIP_SPACING, CLIP_HEIGHT+2]);
    }
}

module stick() {
    half_stick();
    mirror([1, 0, 0]) half_stick();
    translate([0, 0, HEIGHT])
    clip();
    translate([-STICK_LENGTH/4, 0, HEIGHT])
    clip();
    translate([STICK_LENGTH/4, 0, HEIGHT])
    clip();
}

module corners() {
    bottom_lock2_corner();
    translate([98, 55, 0]) rotate(a=180, v=[0, 0, 1]) top_lock2_corner();
}

module ks() {
    bottom_lock2_k();
    translate([98, 55, 0]) rotate(a=180, v=[0, 0, 1]) top_lock2_k();
}

module center() {
    bottom_lock2_center();
    translate([98, 55, 0]) rotate(a=180, v=[0, 0, 1]) top_lock2_center();
}

/*
bottom_lock2_k();
translate([60, 80, 0]) 
rotate(a = 90, v = [0, 0, 1]) top_lock2_k();
*/

/*
stick();
translate([0, 20, 0]) bottom_lock();
translate([0, 45, 0]) top_lock();
*/

top_lock2_k();
translate([-68, 50, 0])
rotate(a = -90, v= [0, 0, 1]) bottom_lock2_k();
translate([26, -2, 0])
rotate(a=180, v=[0, 0, 1]) top_lock2_k();
translate([-24, -96, 0]) bottom_lock2_k();
translate([96, -60, 0])
rotate(a=90, v=[0, 0, 1]) top_lock2_k();
translate([49, 94, 0])
rotate(a=-180, v=[0, 0, 1]) bottom_lock2_k();

// 25

/*
rows = 1;
columns = 2;
distance_rows = 150;
distance_columns = 78;
// comment out
offset_rows = 30;
rotation = -45;

rotate(a = rotation, v = [0, 0, 1]) {
    for(row = [0:(rows - 1)]) {
        for(column = [0:(columns - 1)]) {
            translate([row * distance_rows - offset_rows * column, column * distance_columns, 0])
            center();
         }
    }
}
*/