top_width = 900;
bottom_width = 880;
height = 100;
cylinder_diameter = 50;
cylinder_radius = cylinder_diameter / 2;
offset = (top_width - bottom_width) /2;


module base() {
    hold_depth=cylinder_diameter + 10;
    linear_extrude(height=hold_depth)
    polygon(points = [[0,0],[top_width,0],[top_width-offset,height],[offset,height]]);
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

rotate(a=90,v=[1,0,0])
difference() {
    base();
    cylinder1();
    cylinder2();
}