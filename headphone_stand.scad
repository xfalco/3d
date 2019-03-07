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
cylinder_padding = 4;

module left_handle() {
    difference() {
        union() {
            cube([guide_height,cylinder_diameter + cylinder_padding,handle_guide_width + 10]);
            translate([0,cylinder_diameter + cylinder_padding,0])
            rotate(a=-10,v=[0,0,1])
            union() {
                cube([guide_height,6,handle_guide_width + 10]);
                translate([-1,2,0])
                cube([guide_height+1,4,guide_length]);
            }
        }

        translate([-1,3 + cylinder_padding,12])
        rotate(a=90,v=[0,1,0])
        union() {
            cylinder(h=15,r1=3.5,r2=3.5, $fn=100);
            translate([-handle_guide_width - 0.5,-3.5,0])
            cube([handle_guide_width,7,15]);
        }
    }
}

module left_handle2() {
    translate([2,0,0])
    difference() {
        union() {
            cube([guide_height-4,cylinder_diameter + cylinder_padding,handle_guide_width + 10]);
            translate([0,cylinder_diameter + cylinder_padding,0])
            rotate(a=-10,v=[0,0,1])
            union() {
                cube([guide_height-4,6,handle_guide_width + 10]);
                translate([-1,2,0])
                cube([guide_height-3,4,guide_length-2]);
            }
        }

        translate([-1,3 + cylinder_padding,12])
        rotate(a=90,v=[0,1,0])
        union() {
            cylinder(h=15,r1=5.5,r2=5.5, $fn=100);
            translate([-handle_guide_width - 10.5,-5.5,0])
            cube([handle_guide_width+10,11,15]);
        }
    }
}

// mount
first_mount_length = 50;
mount_width = cylinder_diameter + cylinder_padding-4;
first_mount_angle = 30;
first_mount_height = cos(first_mount_angle) * first_mount_length;
first_mount_translation_width = sin(first_mount_angle) * first_mount_length;

module pyramid_shape() {
    intersection() {
            translate([0,3,0])
            rotate(a=5,v=[1,0,0])
            translate([first_mount_translation_width,0,0])
            cube([guide_height,mount_width,first_mount_height+5]);
            translate([0,-3,0])
            rotate(a=-5,v=[1,0,0])
            translate([first_mount_translation_width,0,0])
            cube([guide_height,mount_width,first_mount_height+5]);
        }
        translate([0,3,0])
        rotate(a=5,v=[1,0,0])
        translate([first_mount_translation_width,0,0])
        cube([guide_height,mount_width,first_mount_height/2+12]);
        translate([0,-3,0])
        rotate(a=-5,v=[1,0,0])
        translate([first_mount_translation_width,0,0])
        cube([guide_height,mount_width,first_mount_height/2+12]);
}

module left_first_mount() {
    translate([first_mount_translation_width,0,0])
    rotate(a=-first_mount_angle,v=[0,1,0])
    cube([guide_height, mount_width, first_mount_length]);
    pyramid_shape();
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
        left_handle2();
        translate([0,4,second_mount_height])
        left_first_mount();
        left_second_mount();
    }
}

// joint
//joint_length = 60;
joint_length = 25;
joint_height = 10;

module joint() {
    // original
    translate([first_mount_translation_width+second_mount_translation_width-15,50,0])
    cube([40,joint_length,joint_height]);
}

module everything() {
    left();
    joint();
    //translate([0,base_length,0])
    //mirror([0,1,0])
    //left();
}

module area_to_smooth() {
    translate([-5,0,2])
    cube([125,200,120]);
}

module smoothed() {
    smooth(r=0) {
        everything();
        translate([-5,-5,27+ second_mount_height])
        cube([20,20,20]);
        //translate([-5,base_length-15,27+ second_mount_height])
        //cube([20,20,20]);
        translate([first_mount_translation_width-10,0,second_mount_height-10])
        cube([30,30,20]);
        //translate([first_mount_translation_width-10,base_length-first_mount_translation_width-5,second_mount_height-10])
        //cube([30,30,20]);
       
        translate([100,40,0])
        cube([20,30,30]);
    }
}

//mirror([0,1,0])
//smoothed();
/*union() {
    smoothed();
    minkowski() {
        intersection() {
            smoothed();
            area_to_smooth();
        }
        sphere(2);
    }
}*/

//color("red")
//cube([first_mount_translation_width+second_mount_translation_width-15,70,90]);
//cube([120,50,90]);

smoothing_padding = 2;

// base1

mid_space = (190 - 40 - 25) - (40 + 60);
padding = 0.25;
wall_width = 3;
joint_depth = 24;

base_length = wall_width + padding + smoothing_padding + 60 + smoothing_padding + padding + mid_space + padding + smoothing_padding + 25 + smoothing_padding + padding + wall_width;
base_width = wall_width + padding + smoothing_padding + joint_height + smoothing_padding + padding + wall_width;
base_height = joint_depth + padding + wall_width;

base_center_x = 90;
base_center_height = base_height + (120 - (first_mount_translation_width+second_mount_translation_width-15));

// layer

layer_height = 10;
num_layers = 4;
final_layer_width = 60;
final_layer_length = 50;

// base2

base_2_width = 150;
base_2_length = 120;
base_2_height = base_center_height - (num_layers - 1) * layer_height;
base_2_hole_height = layer_height;
base_2_hole_width = final_layer_width + (num_layers - 1) * layer_height + 2 * smoothing_padding + 2 * padding;
base_2_hole_length = final_layer_length + (num_layers - 1) *layer_height + 2 * smoothing_padding + 2 * padding;

module base1() {
    translate([smoothing_padding,0,0])
    difference() {
        cube([base_width, base_length, base_height]);
        union() {
            translate([wall_width,wall_width,wall_width])
            cube([(padding + smoothing_padding + joint_height + smoothing_padding + padding),(padding + smoothing_padding + 60 + smoothing_padding + padding),(padding + smoothing_padding + joint_depth + 5)]);
            translate([wall_width, (wall_width + padding + 60 + padding + mid_space),wall_width])
            cube([(padding + smoothing_padding + joint_height + smoothing_padding + padding),(padding + smoothing_padding + 25 + smoothing_padding + padding),(padding + smoothing_padding + joint_depth + 5)]);
        }
    }
}

base_2_offset_x = base_width + smoothing_padding * 3 - 1;
hole_start_x = smoothing_padding + wall_width + smoothing_padding + padding + base_center_x - base_2_hole_length / 2;
hole_start_y = (base_2_width - base_2_hole_width) / 2 + smoothing_padding;
hole_start_z = (base_2_height - base_2_hole_height);

module base2() {
    difference() {
        translate([base_2_offset_x,smoothing_padding,0])
        cube([base_2_length,base_2_width,base_2_height]);
        translate([hole_start_x, hole_start_y, hole_start_z])
        cube([base_2_hole_length, base_2_hole_width, base_2_hole_height + 5]);
    }
}

module base() {
    translate([0,((base_2_width - base_length - smoothing_padding) / 2 + smoothing_padding),0])
    base1();
    base2();
}

/*
 minkowski() {
    // intersection so we don't go under z-axis
    intersection() {
        base();
        translate([0,0,smoothing_padding])
        cube([200,200,100]);
    }
    sphere(smoothing_padding);
}
*/