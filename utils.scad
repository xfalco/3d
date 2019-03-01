// Utilities
use <libraries/SnapLib/SnapLib.0.36.scad>

// Misc

/**
 * smooth: will create convex hull of shape over specified intervals. 
 * ex:
 * smooth() {
 *   shape1();
 *   section_to_smooth_1();
 *   section_to_smooth_2();
 * }
 */
module smooth(r=0) {
    children(0);
    // step needed in case $children < 2  
    for (i= [1:1:$children-1]) {
        if(r > 0) {
            minkowski() {
                hull() {
                    intersection() {
                        children(0);
                        children(i);
                    }
                }
                sphere(r,center=true);
            }
        } else {
            hull() {
                intersection() {
                    children(0);
                    children(i);
                }
            }
        }
    }
}


// Snap Joints

/**
 * doubleCantileverSnap: creates the snap portion of a Cantilever Joint with 2 snap fits
 * x_size: size on x-axis of containing box
 * y_size: size on y-axis of containing box
 * z_size: size on z-axis of containing box
 */
module doubleCantileverSnap(size, tolerance=0.1, center = true) {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    corrected_z = z_size * (1 - tolerance);
    z_offset = center ? (tolerance / 2) * z_size : 0;
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
module singleCantileverSnap(size, tolerance=0.1, center = true) {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    corrected_z = z_size * (1 - tolerance);
    z_offset = center ? (tolerance / 2) * z_size : 0;
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
module singleCantileverHole(size, tolerance =0.1, back_wall=false) {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    ratio = 1 - tolerance;
    single_cantilever_base = y_size / 3;
    single_cantilever_leg_size = x_size / 2;
    overhang = Ysnap(l=single_cantilever_leg_size, h=single_cantilever_base, f=1);
    if (back_wall) {
        cube([x_size, single_cantilever_base * ratio, z_size]);
    }
    translate([0, 3 * single_cantilever_base, 0])
    mirror([0,1,0])
    cube([single_cantilever_leg_size * ratio, single_cantilever_base * ratio, z_size]);
    snap_stop = single_cantilever_leg_size+ overhang + (overhang + single_cantilever_base/4)/tan(25);
    back_size = x_size - snap_stop - 3 * overhang;
    translate([snap_stop + 3 * overhang,0,0])
    cube([back_size,y_size,z_size]);
}

/**
 * singleSlotPlug: creates the hole portion of a slot
 * x_size: size on x-axis of containing box
 * y_size: size on y-axis of containing box
 * z_size: size on z-axis of containing box
 */
module singleSlotPlug(size, tolerance =0.1, center = true) {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    corrected_z = z_size * (1 - tolerance);
    z_offset = center ? (tolerance / 2) * z_size : 0;
    slot_plug_base = y_size / 2;
    slot_plug_leg = 3 * x_size / 4;
    // first snap
    translate([0,0,z_offset])
    translate([0,  slot_plug_base / 2, 0])
    cube([slot_plug_leg, slot_plug_base, corrected_z]);
}

/**
 * singleSlotHot: creates the hole portion of a slot
 * x_size: size on x-axis of containing box
 * y_size: size on y-axis of containing box
 * z_size: size on z-axis of containing box
 */
module singleSlotHole(size, tolerance =0.1) {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    ratio = 1 - tolerance;
    slot_plug_base = y_size / 2;
    cube([x_size, ratio * slot_plug_base / 2, z_size]);
    translate([0,y_size,0])
    mirror([0,1,0])
    cube([x_size, ratio * slot_plug_base / 2, z_size]);
    translate([x_size, 0, 0])
    mirror([1,0,0])
    cube([ratio * x_size / 4, y_size, z_size]);
}

/**
 * singleCantileverTool: creates a tool to push out cantilever snaps
 * x_size: size on x-axis of containing box
 * y_size: size on y-axis of containing box
 * z_size: size on z-axis of containing box
 */
module singleCantileverTool(size, tolerance =0.1) {
    x_size = size[0];
    y_size = size[1];
    z_size = size[2];
    ratio = 1 - tolerance;
    single_cantilever_base = y_size / 3;
    single_cantilever_leg_size = x_size / 2;
    overhang = Ysnap(l=single_cantilever_leg_size, h=single_cantilever_base, f=1);
    snap_stop = single_cantilever_leg_size+ overhang + (overhang + single_cantilever_base/4)/tan(25);
    back_size = x_size - snap_stop - 3 * overhang;
    tool_leg = x_size - (back_size * (1 + tolerance)) - single_cantilever_leg_size;
    translate([single_cantilever_leg_size, y_size / 2, 0])
    union() {
        cube([tool_leg, y_size / 2, z_size]);
        linear_extrude(height=z_size)
        polygon(points=[[0,0],[tool_leg,0],[tool_leg,-tan(25) * tool_leg]]);
    }
}


box = [6,3,1];
color("red")
singleCantileverSnap(box, center=true);
color("green")
singleCantileverHole(box, back_wall=true);
color("blue")
singleCantileverTool(box);
