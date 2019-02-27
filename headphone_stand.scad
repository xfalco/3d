// width: 190 top, 188 bottom
// cylinder: 7
// angle: 10deg
// mounting angle: 70% towards center, 45% back

use <utils.scad>

// handle
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

// mount
first_mount_length = 50;
mount_width = cylinder_diameter + cylinder_width;
first_mount_angle = 30;
first_mount_height = cos(first_mount_angle) * first_mount_length;
first_mount_translation_width = sin(first_mount_angle) * first_mount_length;

module left_first_mount() {
    translate([first_mount_translation_width,0,0])
    rotate(a=-first_mount_angle,v=[0,1,0])
    cube([guide_height, mount_width, first_mount_length]);
}

second_mount_length = 100;
second_mount_angle = 70;
second_mount_angle_2 = 20;
second_mount_height = cos(second_mount_angle) * second_mount_length;
second_mount_translation_width = cos(second_mount_angle_2) * second_mount_length;
second_mount_offset = sin(second_mount_angle_2) * sin(second_mount_angle) * second_mount_length;

module left_second_mount() {
    translate([first_mount_translation_width + second_mount_translation_width,second_mount_offset,0])
    rotate(a=second_mount_angle_2,v=[0,0,1])
    rotate(a=-second_mount_angle,v=[0,1,0])
    cube([guide_height, mount_width, second_mount_length]);
}

module left() {
    rotate(a=10,v=[0,0,1])
    union() {
        translate([0,0,first_mount_height + second_mount_height])
        left_handle();
        translate([0,0,second_mount_height])
        left_first_mount();
        left_second_mount();
    }
}

left();

// base
base_length = 195;
base_height = 10;

module base() {
    // "shadows"
    rotate(a=10,v=[0,0,1])
    translate([first_mount_translation_width + second_mount_translation_width,second_mount_offset,0])
    rotate(a=second_mount_angle_2,v=[0,0,1])
    rotate(a=-90,v=[0,1,0])
    cube([guide_height - 5, mount_width, second_mount_length + 5]);
    translate([0,base_length,0])
    mirror([0,1,0])
    rotate(a=10,v=[0,0,1])
    translate([first_mount_translation_width + second_mount_translation_width,second_mount_offset,0])
    rotate(a=second_mount_angle_2,v=[0,0,1])
    rotate(a=-90,v=[0,1,0])
    cube([guide_height - 5, mount_width, second_mount_length + 5]);
    // original
    translate([first_mount_translation_width+second_mount_translation_width-30,0,0])
    cube([30,base_length,base_height]);
}

module everything() {
    left();
    base();
    translate([0,base_length,0])
    mirror([0,1,0])
    left();
}


smooth() {
    everything();
    translate([-5,-5,27+ second_mount_height])
    cube([20,20,20]);
    translate([-5,base_length-15,27+ second_mount_height])
    cube([20,20,20]);
    translate([first_mount_translation_width-10,0,second_mount_height-10])
    cube([30,30,20]);
    translate([first_mount_translation_width-10,base_length-first_mount_translation_width-5,second_mount_height-10])
    cube([30,30,20]);
}
