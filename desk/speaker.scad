HOOK_RADIUS = 6.6;
INNER_HOOK_RADIUS = 4.6;
MOUNT_FRAME_CIRCUS_WIDTH = 1.5;

TOLERANCE = 0.5;
HOOK_WIDTH = 1.8;
INNER_HOOK_WIDTH = 1.4;

module hook_entry() {
    translate([0, 0, TOLERANCE + INNER_HOOK_WIDTH+MOUNT_FRAME_CIRCUS_WIDTH])
    minkowski() {
        union() {
            cylinder(h=HOOK_WIDTH, r=HOOK_RADIUS, $fn=50);
            translate([0, -HOOK_RADIUS, 0])
            cube([20, 2 * HOOK_RADIUS, HOOK_WIDTH]);
        }
        sphere(r=TOLERANCE);
    }
    translate([0, 0, -1])
    union() {
        cylinder(h=INNER_HOOK_WIDTH + 5, r=INNER_HOOK_RADIUS, $fn=50);
        translate([0, -INNER_HOOK_RADIUS, 0])
        cube([20, 2 * INNER_HOOK_RADIUS, INNER_HOOK_WIDTH + 4]);
    }
    linear_extrude(height=MOUNT_FRAME_CIRCUS_WIDTH) {
        offset(r=TOLERANCE) {
            translate([0, -HOOK_RADIUS, 0])
            square([20, 2 * HOOK_RADIUS]);
            circle(r=HOOK_RADIUS, $Fn=50);
        }
    }
}

module hook_with_hull_entry() {
    HOOK_RADIUS = 6.6;
    INNER_HOOK_RADIUS = 5.6;
    MOUNT_FRAME_CIRCUS_WIDTH = 1.7;

    TOLERANCE = 0.5;
    HOOK_WIDTH = 1.3;
    INNER_HOOK_WIDTH = 1.2;
    translate([0, 0, MOUNT_FRAME_CIRCUS_WIDTH])
    hull() {
        translate([0, 0, TOLERANCE + INNER_HOOK_WIDTH])
        minkowski() {
            union() {
                cylinder(h=HOOK_WIDTH, r=HOOK_RADIUS, $fn=50);
                translate([0, -HOOK_RADIUS, 0])
                cube([20, 2 * HOOK_RADIUS, HOOK_WIDTH]);
            }
            sphere(r=TOLERANCE);
        }
        translate([0, 0, 1])
        union() {
            cylinder(h=INNER_HOOK_WIDTH - 1, r=INNER_HOOK_RADIUS, $fn=50);
            translate([0, -INNER_HOOK_RADIUS, 0])
            cube([20, 2 * INNER_HOOK_RADIUS, INNER_HOOK_WIDTH - 1]);
        }
    }
    translate([0, 0, -1])
    union() {
        cylinder(h=INNER_HOOK_WIDTH + 3, r=INNER_HOOK_RADIUS, $fn=50);
        translate([0, -INNER_HOOK_RADIUS, 0])
        cube([20, 2 * INNER_HOOK_RADIUS, INNER_HOOK_WIDTH + 4]);
    }
    linear_extrude(height=MOUNT_FRAME_CIRCUS_WIDTH) {
        offset(r=TOLERANCE) {
            translate([0, -HOOK_RADIUS, 0])
            square([20, 2 * HOOK_RADIUS]);
            circle(r=HOOK_RADIUS, $Fn=50);
        }
    }
}

BRACKET_HEIGHT = 8;
BRACKET_LENGTH = 30;
BRACKET_WIDTH = 20;

MOUNT_FIRST_LENGTH = 10.3;
MOUNT_SECOND_LENGTH = 5;

FRAME_LENGTH = 50.2;

MOUNT_TOP_LENGTH_EXTRA = 6.8;

module bracket() {
    difference() {
        translate([-15, -10, 0])
        cube([BRACKET_LENGTH, BRACKET_WIDTH, BRACKET_HEIGHT]);
        hook_entry();
    }
}



//rotate(v=[0, 1, 0], a=-90)
//foo();

ADJUSTMENT_1 = 2.5;
ADJUSTMENT_2 = 0.5;
ADJUSTMENT_3 = 0.1;

DISTANCE_HOLD_X = 40;
DISTANCE_HOLD_Y = 35;


module bracket_mount_bottom(x, width, height, angle) {
    roundness = 0.2;
    width = width - 2 * roundness;
    height = height - 2 * roundness;
    translate([0, roundness, roundness])
    minkowski() {
        union() {
            // hold
            cube([x, width, height]);
            translate([x, 0, 0])
            // first bend
            rotate(v=[0, 1, 0], a=(angle - 180))
            cube([x + ADJUSTMENT_3, width, height]);
            // joint 
            joint_vertex_angle = 180 - angle - 45;
            joint_base_angle = 0.5 * (180 - joint_vertex_angle);
            inner_joint_size = 2 * cos(joint_base_angle) * height;
            // complicated walk along edges and geometry...
            first_slanted_cube_inner_diagonal_length = sqrt((x+ADJUSTMENT_3) * (x+ADJUSTMENT_3) + height * height);
            first_slanted_cube_inner_diagonal_angle = acos((x+ADJUSTMENT_3) / first_slanted_cube_inner_diagonal_length);
            angle_pointing_to_final_loc = angle - first_slanted_cube_inner_diagonal_angle;
            pos_x = x - cos(angle_pointing_to_final_loc) * first_slanted_cube_inner_diagonal_length;
            pos_z = sin(angle_pointing_to_final_loc) * first_slanted_cube_inner_diagonal_length;
            // ugh...
            angle_1 = acos(pos_z / first_slanted_cube_inner_diagonal_length);
            joint_offset_down = 90 - angle_1 - (90 - first_slanted_cube_inner_diagonal_angle) + (90 - joint_base_angle);
            joint_x = sin(joint_base_angle) * height;
            translate([pos_x, 0, pos_z])
            rotate(v=[0, 1, 0], a = joint_offset_down)
            cube([joint_x, width, inner_joint_size + sqrt(60) * ADJUSTMENT_3]);
            // second diagonal
            pos_x_mid = (x+ADJUSTMENT_3) + cos(180-angle) * (x+ADJUSTMENT_3) - ADJUSTMENT_3;
            pos_z_mid = sin(180 -angle) * (x+ADJUSTMENT_3) + ADJUSTMENT_3;
            translate([pos_x_mid, 0, pos_z_mid])
            rotate(v=[0, 1, 0], a=-35)
            // not sure why the + 2.5...
            cube([2 * MOUNT_SECOND_LENGTH + ADJUSTMENT_1, width, height]);
            // final frame
            pos_x_frame=pos_x_mid + cos(45) * MOUNT_SECOND_LENGTH;
            pos_z_frame = pos_z_mid + sin(45) * MOUNT_SECOND_LENGTH;
            final_height = sqrt(2) * height;
            translate([pos_x_frame, 0, pos_z_frame-ADJUSTMENT_2])
            cube([FRAME_LENGTH + 0.5 * x, width, final_height+ADJUSTMENT_2]);
            // hold
            translate([pos_x_frame + FRAME_LENGTH, 0, 0])
            rotate(v=[0, 1, 0], a=-5)
            cube([x, width, final_height+pos_z]);
            translate([pos_x_frame + DISTANCE_HOLD_X, -DISTANCE_HOLD_Y, pos_z_frame-ADJUSTMENT_2])
            cube([5, DISTANCE_HOLD_Y, final_height+ADJUSTMENT_2]);
        }
        sphere(r=roundness);
    }
}

module bracket_mount_top(x, width, height, angle) {
    roundness = 0.2;
    width = width - 2 * roundness;
    height = height - 2 * roundness;
    leg_out_size = x + MOUNT_TOP_LENGTH_EXTRA;
    translate([0, roundness, roundness])
    minkowski() {
        union() {
            // hold
            cube([leg_out_size, width, height]);
            translate([MOUNT_TOP_LENGTH_EXTRA, 0, 0]) {
                translate([x, 0, 0])
                // first bend
                rotate(v=[0, 1, 0], a=(angle - 180))
                cube([x + ADJUSTMENT_3, width, height]);
                // joint 
                joint_vertex_angle = 180 - angle - 45;
                joint_base_angle = 0.5 * (180 - joint_vertex_angle);
                inner_joint_size = 2 * cos(joint_base_angle) * height;
                // complicated walk along edges and geometry...
                first_slanted_cube_inner_diagonal_length = sqrt((x+ADJUSTMENT_3) * (x+ADJUSTMENT_3) + height * height);
                first_slanted_cube_inner_diagonal_angle = acos((x+ADJUSTMENT_3) / first_slanted_cube_inner_diagonal_length);
                angle_pointing_to_final_loc = angle - first_slanted_cube_inner_diagonal_angle;
                pos_x = x - cos(angle_pointing_to_final_loc) * first_slanted_cube_inner_diagonal_length;
                pos_z = sin(angle_pointing_to_final_loc) * first_slanted_cube_inner_diagonal_length;
                // ugh...
                angle_1 = acos(pos_z / first_slanted_cube_inner_diagonal_length);
                joint_offset_down = 90 - angle_1 - (90 - first_slanted_cube_inner_diagonal_angle) + (90 - joint_base_angle);
                joint_x = sin(joint_base_angle) * height;
                translate([pos_x, 0, pos_z])
                rotate(v=[0, 1, 0], a = joint_offset_down)
                cube([joint_x, width, inner_joint_size + sqrt(60) * ADJUSTMENT_3]);
                // second diagonal
                pos_x_mid = (x+ADJUSTMENT_3) + cos(180-angle) * (x+ADJUSTMENT_3) - ADJUSTMENT_3;
                pos_z_mid = sin(180 -angle) * (x+ADJUSTMENT_3) + ADJUSTMENT_3;
                translate([pos_x_mid, 0, pos_z_mid])
                rotate(v=[0, 1, 0], a=-35)
                // not sure why the + 2.5...
                cube([2 * MOUNT_SECOND_LENGTH + ADJUSTMENT_1, width, height]);
                // final frame
                pos_x_frame=pos_x_mid + cos(45) * MOUNT_SECOND_LENGTH;
                pos_z_frame = pos_z_mid + sin(45) * MOUNT_SECOND_LENGTH;
                final_height = sqrt(2) * height;
                translate([pos_x_frame, 0, pos_z_frame-ADJUSTMENT_2])
                cube([x, width, final_height+ADJUSTMENT_2]);
            }
        }
        sphere(r=roundness);
    }
}

module bracket_and_mount_bottom() {
    rotate(v=[0, 1, 0], a=-90) {
        bracket();
        translate([BRACKET_LENGTH / 2, BRACKET_WIDTH / 2, 0])
        rotate(v=[0, 0, 1], a=90)
        bracket_mount_bottom(MOUNT_FIRST_LENGTH, BRACKET_LENGTH, BRACKET_HEIGHT, 108.5);
    }
}

module bracket_and_mount() {
    rotate(v=[0, 1, 0], a=-90) {
        bracket();
        translate([BRACKET_LENGTH / 2, BRACKET_WIDTH / 2, 0])
        rotate(v=[0, 0, 1], a=90)
        bracket_mount_bottom(MOUNT_FIRST_LENGTH, BRACKET_LENGTH, BRACKET_HEIGHT, 108.5);
        mirror([0,1,0])
        translate([BRACKET_LENGTH / 2, BRACKET_WIDTH / 2, 0])
        rotate(v=[0, 0, 1], a=90)
        bracket_mount_top(MOUNT_FIRST_LENGTH, BRACKET_LENGTH, 5, 108.5);
    }
}
bracket_and_mount();

// bracket_and_mount_bottom();
//rotate(v=[1, 0, 0], a=90)
//bracket_mount_bottom(MOUNT_FIRST_LENGTH, 10, 5, 108.5);


