// Utilities
use <libraries/SnapLib/SnapLib.0.36.scad>

// Snap Joints

/**
 * doubleCantileverSnap: creates the snap portion of a Cantilever Joint with 2 snap fits
 * x_size: size on x-axis of containing box
 * y_size: size on y-axis of containing box
 * z_size: size on z-axis of containing box
 */
module doubleCantileverSnap(size, tolerance=0.1, position="center") {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    corrected_z = z_size * (1 - tolerance);
    z_offset = (position == "center") ? (tolerance / 2) * z_size : 0;
    single_cantilever_base = y_size / 4;
    single_cantilever_leg_size = x_size / 2;
    // first snap
    translate([0,0,z_offset])
    translate([0, 3 *single_cantilever_base, 0])
    SnapY(l=single_cantilever_leg_size,h=single_cantilever_base,a=25,b=corrected_z);
    // second snap
    translate([0,0,z_offset])
    translate([0, 4 * single_cantilever_base, 0])
    mirror([0,1,0])
    translate([0, 3 *single_cantilever_base, 0])
    SnapY(l=single_cantilever_leg_size,h=single_cantilever_base,a=25,b=corrected_z);
}

/**
 * doubleCantileverHole: creates the hole portion of a Cantilever Joint with 2 snap fits
 * x_size: size on x-axis of containing box
 * y_size: size on y-axis of containing box
 * z_size: size on z-axis of containing box
 */
module doubleCantileverHole(size, tolerance =0.1) {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    ratio = 1 - tolerance;
    single_cantilever_base = y_size / 4;
    single_cantilever_leg_size = x_size / 2;
    overhang = Ysnap(l=single_cantilever_leg_size, h=single_cantilever_base, f=1);
    cube([single_cantilever_leg_size * ratio, single_cantilever_base * ratio, z_size]);
    translate([0, 4 * single_cantilever_base, 0])
    mirror([0,1,0])
    cube([single_cantilever_leg_size * ratio, single_cantilever_base * ratio, z_size]);
    snap_stop = single_cantilever_leg_size+ overhang + (overhang + single_cantilever_base/4)/tan(25);
    back_size = x_size - snap_stop - 3 * overhang;
    translate([snap_stop + 3 * overhang,0,0])
    cube([back_size,y_size,z_size]);
}

/**
 * singleCantileverSnap: creates the snap portion of a Cantilever Joint with 1 snap fit
 * x_size: size on x-axis of containing box
 * y_size: size on y-axis of containing box
 * z_size: size on z-axis of containing box
 */
module singleCantileverSnap(size, tolerance=0.1, position="center") {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    corrected_z = z_size * (1 - tolerance);
    z_offset = (position == "center") ? (tolerance / 2) * z_size : 0;
    single_cantilever_base = y_size / 3;
    single_cantilever_leg_size = x_size / 2;
    // first snap
    translate([0,0,z_offset])
    translate([0, 2 *single_cantilever_base, 0])
    SnapY(l=single_cantilever_leg_size,h=single_cantilever_base,a=25,b=corrected_z);
}

/**
 * singleCantileverHole: creates the hole portion of a Cantilever Joint with 2 snap fits
 * x_size: size on x-axis of containing box
 * y_size: size on y-axis of containing box
 * z_size: size on z-axis of containing box
 */
module singleCantileverHole(size, tolerance =0.1) {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    ratio = 1 - tolerance;
    single_cantilever_base = y_size / 3;
    single_cantilever_leg_size = x_size / 2;
    overhang = Ysnap(l=single_cantilever_leg_size, h=single_cantilever_base, f=1);
    cube([x_size, single_cantilever_base * ratio, z_size]);
    translate([0, 3 * single_cantilever_base, 0])
    mirror([0,1,0])
    cube([single_cantilever_leg_size * ratio, single_cantilever_base * ratio, z_size]);
    snap_stop = single_cantilever_leg_size+ overhang + (overhang + single_cantilever_base/4)/tan(25);
    back_size = x_size - snap_stop - 3 * overhang;
    translate([snap_stop + 3 * overhang,0,0])
    cube([back_size,y_size,z_size]);
}

// GOOD EXAMPLE
// color("red")
// cantileverSnap(7,4,2);
// color("green")
// cantileverHole(7,4,2);

box = [6,3,2];
color("red")
singleCantileverSnap(box, position="center");
color("green")
singleCantileverHole(box);