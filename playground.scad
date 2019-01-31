use <utils.scad>

box = [6,4,1];
box = [6,3,1];

// SNAPS back to back
/*
DOUBLE JOINT
translate([2,0,0])
doubleCantileverSnap(box, tolerance=0.1, position="bottom");
cube([2,4,1]);
*/
translate([2,5,0])
singleCantileverSnap(box, tolerance=0.1, position="bottom");
translate([2,3,0])
mirror([0,1,0])
singleCantileverSnap(box, tolerance=0.1, position="bottom");
translate([0,-1,0])
cube([2,10,1]);

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

mirror([1,0,0])
translate([1,0,0])
union() {
    translate([0,5,1]) singleCantileverHole(box,tolerance=0.1);
    translate([0,3,1])
    mirror([0,1,0]) 
    singleCantileverHole(box, tolerance=0.1, position="bottom");
    cube([6,8,1]);
}