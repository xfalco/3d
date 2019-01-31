use <utils.scad>

box1 = [6,4,2];
box2 = [7,4,2];

// SNAPS back to back

translate([2,0,0]) cantileverSnap(box1);
cube([2,4,2]);
mirror([1,0,0]) cantileverSnap(box2);

// Holes
/*
box = box1;
translate([0,0,box[2]]) cantileverHole(box);
cube(box);
*/