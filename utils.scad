// Utilities
use <libraries/SnapLib/SnapLib.0.36.scad>

// Snap Joints

/**
 * cantileverSnap: creates the snap portion of a Cantilever Joint
 * x_size: size on x-axis of containing box
 * y_size: size on y-axis of containing box
 * z_size: size on z-axis of containing box
 */
module cantileverSnap(size) {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    single_cantilever_base = y_size / 4;
    single_cantilever_leg_size = x_size / 2;
    translate([0, 3 *single_cantilever_base, 0])
    SnapY(l=single_cantilever_leg_size,h=single_cantilever_base,a=35,b=z_size);
    translate([0, 4 * single_cantilever_base, 0])
    mirror([0,1,0])
    translate([0, 3 *single_cantilever_base, 0])
    SnapY(l=single_cantilever_leg_size,h=single_cantilever_base,a=35,b=z_size);
}

/**
 * cantileverHole: creates the hole portion of a Cantilever Joint
 * x_size: size on x-axis of containing box
 * y_size: size on y-axis of containing box
 * z_size: size on z-axis of containing box
 */
module cantileverHole(size, tolerance =0.05) {
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
    snap_stop = single_cantilever_leg_size+ overhang + (overhang + single_cantilever_base/4)/tan(35);
    back_size = x_size - snap_stop - overhang;
    translate([snap_stop + overhang,0,0])
    cube([back_size,y_size,z_size]);
}

// GOOD EXAMPLE
// color("red")
// cantileverSnap(7,4,2);
// color("green")
// cantileverHole(7,4,2);

box = [6,4,2];
color("red")
cantileverSnap(box);
color("green")
cantileverHole(box);