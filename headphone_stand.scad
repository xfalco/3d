// width: 1900 top, 1880 bottom
// cylinder: 70
// angle: 20deg

guide_length = 25;
handle_guide_width = 5;
guide_height = 10;
cylinder_diameter = 7;
cylinder_width = 1;

module left_handle() {
    difference() {
        union() {
            cube([guide_height,cylinder_diameter + cylinder_width,handle_guide_width + 10]);
            translate([0,cylinder_diameter + cylinder_width,0])
            rotate(a=-10,v=[0,0,1])
            union() {
                cube([guide_height,6,handle_guide_width + 10]);
                translate([-1,2,0])
                cube([guide_height+1,4,guide_length]);
            }
        }

        translate([-1,4,12])
        rotate(a=90,v=[0,1,0])
        union() {
            cylinder(h=15,r1=3.5,r2=3.5, $fn=100);
            translate([-handle_guide_width - 0.5,-3.5,0])
            cube([handle_guide_width,7,15]);
        }
    }
}

left_handle();
