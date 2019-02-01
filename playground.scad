use <utils.scad>

box = [6,4,1];
box = [6,3,1];

// SNAPS 
/*
DOUBLE JOINT
translate([2,0,0])
doubleCantileverSnap(box, tolerance=0.1, position="bottom");
cube([2,4,1]);
*/
/*
translate([2,9,0])
singleCantileverSnap(box, tolerance=0.1, center = false);
translate([2,3,0])
mirror([0,1,0])
singleCantileverSnap(box, tolerance=0.1, center = false);
translate([2,4,0])
singleSlotPlug([6,4,1], tolerance=0.1, center = false);
translate([0,-1,0])
cube([2,14,1]);
*/
// Holes
/*
DOUBLE JOINT
mirror([1,0,0])
translate([1,0,0])
union() {
    translate([0,0,1]) doubleCantileverHole(box,tolerance=0.1);
    cube([6,4,1]);
}
*/
/*
mirror([1,0,0])
translate([1,0,0])
union() {
    translate([0,9,1]) singleCantileverHole(box, tolerance=0.1, back_wall = false);
    translate([0,3,1])
    mirror([0,1,0]) 
    singleCantileverHole(box, tolerance=0.1, back_wall = false);
    translate([0,4,1])
    singleSlotHole([6,4,1], tolerance=0.1);
    cube([6,12,1]);
}
*/

// Tools
union() {
    singleCantileverTool(box);
    translate([1, 3, 0])
    cube([6, 2, 1]);
}
mirror([1,0,0])
union() {
    singleCantileverTool(box);
    translate([1, 3, 0])
    cube([6, 2, 1]);
}