// width: 1900 top, 1880 bottom
// cylinder: 70
// angle: 20deg

top_width = 100;
bottom_width = 80;
height = 60;
cylinder_diameter = 70;
cylinder_radius = cylinder_diameter / 2;
offset = (top_width - bottom_width) /2;


module base() {
    hold_depth=cylinder_diameter + 10;
    linear_extrude(height=hold_depth)
    polygon(points = [[0,0],[top_width,0],[top_width-offset,height],[offset,height]]);
}

module base2() {
    hold_depth=cylinder_diameter + 10;
    linear_extrude(height=hold_depth)
    polygon(points = [[0,0],[top_width,0],[top_width,height],[offset,height]]);
}

module cylinder1() {
    rotate(a=-atan(offset/height),v=[0,0,1])
    translate([0,-20,cylinder_radius + 5])
    rotate(a=-90,v=[1,0,0])
    cylinder(h = height * 1.5, r1 = cylinder_radius, r2 = cylinder_radius);
}

module cylinder2() {
    translate([top_width,0,0])
    rotate(a=atan(offset/height),v=[0,0,1])
    translate([0,-20,cylinder_radius + 5])
    rotate(a=-90,v=[1,0,0])
    cylinder(h = height * 1.5, r1 = cylinder_radius, r2 = cylinder_radius);
}

/*
rotate(a=90,v=[1,0,0])
difference() {
    base();
    cylinder1();
    cylinder2();
}
*/

/*
rotate(a=90,v=[1,0,0])
difference() {
    base2();
    cylinder1();
}
*/

difference() {
union() {
    cube([10,8,8]);
    translate([0,8,0])
    rotate(a=-20,v=[0,0,1])
    cube([10,6,8]);
}

translate([-1,4,8])
rotate(a=90,v=[0,1,0])
cylinder(h=15,r1=3.5,r2=3.5, $fn=100);
}