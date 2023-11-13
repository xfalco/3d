WIDTH = 11;
HEIGHT = 20;
THICKNESS = 2;
STOPPER = 2; 

BUMP_RADIUS = 1.5;
BUMP_DISTANCE = 19;
BUMP_GLIDERS_DISTANCE = 14;
BUMP_BUMPER_HEIGHT = 3;
BUMP_BUMPER_OVERHANG = 2;
BUMP_BUMPER_PADDING = 1;

CLIP_SPACING = 5;
CLIP_THICKNESS = 1;
CLIP_HEIGHT = 10;

FRAME_WIRE_WIDTH = 5;
FRAME_WIRE_THICKNESS = 2;
FRAME_WIRE_LENGTH = 235;
FRAME_WIRE_HOLE_RADIUS = 1.5;

module side_stopper_on_x_axis(l=WIDTH) {
    difference() {
        translate([0, 0, STOPPER / 2])
        rotate(a = 90, v = [0, 1, 0])
        cylinder(h= l, r1 = STOPPER/2, r2 = STOPPER/2, center = false, $fn = 100);
        translate([-1, -STOPPER, -1])
        cube([l + 2, STOPPER, STOPPER + 2]);
    }
}

module side_stoppers() {
    side_stopper_on_x_axis();
    translate([WIDTH, 0, 0])
    rotate(a = 90, v=[0, 0, 1])
    side_stopper_on_x_axis();
    translate([0, WIDTH, 0])
    rotate(a = -90, v=[0, 0, 1])
    side_stopper_on_x_axis();
    translate([WIDTH, WIDTH, 0])
    rotate(a = 180, v=[0, 0, 1])
    side_stopper_on_x_axis();
}

module middle() {
    difference() {
        cube([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS, STOPPER]);
        translate([THICKNESS, THICKNESS, -1])
        cube([WIDTH, WIDTH, STOPPER + 2]);
    }
    translate([THICKNESS, THICKNESS, 0])
    side_stoppers();
}

module middle_no_stoppers() {
    difference() {
        cube([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS, STOPPER]);
        translate([THICKNESS, THICKNESS, -1])
        cube([WIDTH, WIDTH, STOPPER + 2]);
    }
}

module end() {
    difference() {
    cube([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS, HEIGHT]);
        translate([THICKNESS, THICKNESS, -1])
            cube([WIDTH, WIDTH, HEIGHT + 2]);
    }
}

module corner_base() {
    translate([WIDTH + THICKNESS, WIDTH + THICKNESS, 0])
    cube([THICKNESS, THICKNESS, WIDTH + 2 * THICKNESS]);
    cube([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS,THICKNESS]);
    cube([WIDTH + 2 * THICKNESS, THICKNESS, WIDTH + 2 * THICKNESS]);
    cube([THICKNESS, WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS]);
    translate([THICKNESS, THICKNESS, WIDTH + THICKNESS])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([THICKNESS, WIDTH + 2 * THICKNESS, WIDTH + THICKNESS])
    rotate(a = -90, v=[0, 0, 1])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([THICKNESS, WIDTH + 2 * THICKNESS, THICKNESS])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS, THICKNESS])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + 2 * THICKNESS, THICKNESS, THICKNESS])
    rotate(a = -90, v=[1, 0, 0])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([THICKNESS, WIDTH + THICKNESS, THICKNESS])
    rotate(a = 90, v=[0, 1, 0])
    rotate(a = 180, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + THICKNESS, WIDTH + THICKNESS, WIDTH + 2 * THICKNESS])
    rotate(a = -90, v=[0, 1, 0])
    rotate(a = 180, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + THICKNESS, WIDTH + THICKNESS, THICKNESS])
    rotate(a = -90, v=[1, 0, 0])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = -90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
}

module k_base() {
    translate([WIDTH + THICKNESS, WIDTH + THICKNESS, 0])
    cube([THICKNESS, THICKNESS, WIDTH + 2 * THICKNESS]);
    translate([0, WIDTH + THICKNESS, 0])
    cube([THICKNESS, THICKNESS, WIDTH + 2 * THICKNESS]);
    cube([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS,THICKNESS]);
    cube([WIDTH + 2 * THICKNESS, THICKNESS, WIDTH + 2 * THICKNESS]);
    translate([0, THICKNESS, WIDTH + THICKNESS])
    side_stopper_on_x_axis(WIDTH + 2 * THICKNESS);
    translate([THICKNESS, WIDTH + 2 * THICKNESS, THICKNESS])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS, THICKNESS])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([THICKNESS, WIDTH + 2 * THICKNESS, THICKNESS])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + 2 * THICKNESS, THICKNESS, THICKNESS])
    rotate(a = -90, v=[1, 0, 0])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([THICKNESS, THICKNESS, THICKNESS])
    rotate(a = -90, v=[1, 0, 0])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([THICKNESS, WIDTH + THICKNESS, THICKNESS])
    rotate(a = 90, v=[0, 1, 0])
    rotate(a = 180, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + THICKNESS, WIDTH + THICKNESS, WIDTH + 2 * THICKNESS])
    rotate(a = -90, v=[0, 1, 0])
    rotate(a = 180, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + THICKNESS, WIDTH + THICKNESS, THICKNESS])
    rotate(a = -90, v=[1, 0, 0])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = -90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([0, WIDTH + THICKNESS, THICKNESS])
    rotate(a = -90, v=[1, 0, 0])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = -90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
}

module chapeau(l = HEIGHT) {
    difference() {
        translate([0, (WIDTH /2 + THICKNESS), -(WIDTH /2 + THICKNESS)])
        rotate(a = 45, v = [1, 0, 0])
        difference() {
            cube([l, (WIDTH / 2 + THICKNESS) * sqrt(2), (WIDTH / 2 + THICKNESS) * sqrt(2)]);
            translate([-1, THICKNESS / sqrt(2), THICKNESS / sqrt(2)])
            cube([l + 2, WIDTH / sqrt(2), WIDTH / sqrt(2)]);
        }
        translate([-1, 0, -(WIDTH + 2 * THICKNESS) * 2])
            cube([l + 2, (WIDTH + 2 * THICKNESS) * 2, (WIDTH + 2 * THICKNESS) * 2]);
    }
}

module chapeau_tightener() {
    difference() {
        translate([0, (WIDTH /2 + THICKNESS), -(WIDTH /2 + THICKNESS)])
        rotate(a = 45, v = [1, 0, 0])
        translate([0, THICKNESS / sqrt(2), THICKNESS / sqrt(2)])
            cube([HEIGHT, WIDTH / sqrt(2), WIDTH / sqrt(2)]);
        translate([-1, 0, -(WIDTH + 2 * THICKNESS) * 2])
            cube([HEIGHT + 2, (WIDTH + 2 * THICKNESS) * 2, (WIDTH + 2 * THICKNESS) * 2]);
    }
}

module side_end_x_axis(l=HEIGHT) {
    difference() {
        cube([l, WIDTH + 2 * THICKNESS, WIDTH + THICKNESS]);
            translate([-1, THICKNESS, THICKNESS])
                cube([l + 2, WIDTH, WIDTH + THICKNESS + 1]);
    }
    translate([0, 0, WIDTH + THICKNESS])
    chapeau(l);
}

module corner() {
    corner_base();
    translate([WIDTH + 2 * THICKNESS, 0, 0])
    side_end_x_axis();
    translate([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS, 0])
    rotate(a = 90, v = [0, 0, 1])
    side_end_x_axis();
    translate([0, 0, WIDTH + 2 * THICKNESS])
    difference() {
        cube([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS, HEIGHT]);
        translate([THICKNESS, THICKNESS, -1])
        cube([WIDTH, WIDTH, HEIGHT + 2]);
    }
}

module k() {
    k_base();
    translate([WIDTH + 2 * THICKNESS, 0, 0])
    side_end_x_axis();
    translate([-HEIGHT, 0, 0])
    side_end_x_axis();
    translate([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS, 0])
    rotate(a = 90, v = [0, 0, 1])
    side_end_x_axis();
    translate([0, 0, WIDTH + 2 * THICKNESS])
    difference() {
        cube([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS, HEIGHT]);
        translate([THICKNESS, THICKNESS, -1])
        cube([WIDTH, WIDTH, HEIGHT + 2]);
    }
}

module center_base() {
    translate([WIDTH + THICKNESS, WIDTH + THICKNESS, 0])
    cube([THICKNESS, THICKNESS, WIDTH + 2 * THICKNESS]);
    translate([0, WIDTH + THICKNESS, 0])
    cube([THICKNESS, THICKNESS, WIDTH + 2 * THICKNESS]);
    cube([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS,THICKNESS]);
    cube([WIDTH + 2 * THICKNESS, THICKNESS, WIDTH + 2 * THICKNESS]);
    translate([0, THICKNESS, WIDTH + THICKNESS])
    side_stopper_on_x_axis(WIDTH + 2 * THICKNESS);
    translate([THICKNESS, WIDTH + 2 * THICKNESS, THICKNESS])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + 2 * THICKNESS, WIDTH + 2 * THICKNESS, THICKNESS])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([THICKNESS, WIDTH + 2 * THICKNESS, THICKNESS])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + 2 * THICKNESS, THICKNESS, THICKNESS])
    rotate(a = -90, v=[1, 0, 0])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([THICKNESS, THICKNESS, THICKNESS])
    rotate(a = -90, v=[1, 0, 0])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([THICKNESS, WIDTH + THICKNESS, THICKNESS])
    rotate(a = 90, v=[0, 1, 0])
    rotate(a = 180, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + THICKNESS, WIDTH + THICKNESS, WIDTH + 2 * THICKNESS])
    rotate(a = -90, v=[0, 1, 0])
    rotate(a = 180, v=[0, 0, 1])
    rotate(a = 90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([WIDTH + THICKNESS, WIDTH + THICKNESS, THICKNESS])
    rotate(a = -90, v=[1, 0, 0])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = -90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
    translate([0, WIDTH + THICKNESS, THICKNESS])
    rotate(a = -90, v=[1, 0, 0])
    rotate(a = -90, v=[0, 0, 1])
    rotate(a = -90, v=[1, 0, 0])
    side_stopper_on_x_axis(WIDTH + THICKNESS);
}

module center() {
    translate([-HEIGHT, 0 , 0])
    side_end_x_axis(2 * HEIGHT + WIDTH + 2 * THICKNESS);
    translate([WIDTH + 2 * THICKNESS, 0 , 0])
    rotate(a = 90, v = [0, 0, 1])
    translate([-HEIGHT, 0 , 0])
    side_end_x_axis(2 * HEIGHT + WIDTH + 2 * THICKNESS);
}

module 2dcorner() {
    difference() {
        center();
        translate([-HEIGHT-2, -(HEIGHT-1), -1])
        cube([HEIGHT + 2, 2 * HEIGHT + WIDTH + 2 * THICKNESS + 2, 2 * (WIDTH + 2*THICKNESS) + 2]);
        translate([-HEIGHT-1, -(HEIGHT+2), -1])
        cube([2 * HEIGHT + WIDTH + 2 * THICKNESS + 2, HEIGHT + 2, 2 * (WIDTH + 2*THICKNESS) + 2]);
    }
}

module t() {
    difference() {
        center();
        translate([-HEIGHT-2, -(HEIGHT-1), -1])
        cube([HEIGHT + 2, 2 * HEIGHT + WIDTH + 2 * THICKNESS + 2, 2 * (WIDTH + 2*THICKNESS) + 2]);
    }
}

module straight_joint() {
    end();
    translate([0, 0, HEIGHT])
    middle();
    translate([0, 0, HEIGHT + STOPPER])
    end();
}

module straight_joint_no_stoppers() {
    end();
    translate([0, 0, HEIGHT])
    middle_no_stoppers();
    translate([0, 0, HEIGHT + STOPPER])
    end();
}

module hold(base_length, base_width) {
    cube([base_length, base_width, BUMP_RADIUS]);
    translate([(base_length - BUMP_DISTANCE) / 2, base_width / 2, BUMP_RADIUS])
    sphere(r=BUMP_RADIUS, $fn = 100);
    translate([(base_length + BUMP_DISTANCE) / 2, base_width / 2, BUMP_RADIUS])
    sphere(r=BUMP_RADIUS, $fn = 100);
    translate([0, 0, BUMP_RADIUS + BUMP_BUMPER_HEIGHT])
    cube([base_length, BUMP_BUMPER_PADDING + BUMP_BUMPER_OVERHANG, BUMP_BUMPER_PADDING]);
    cube([base_length, BUMP_BUMPER_PADDING, BUMP_RADIUS + BUMP_BUMPER_HEIGHT]);
    translate([0, base_width, 0])
    mirror([0, 1, 0]) {
        translate([0, 0, BUMP_RADIUS + BUMP_BUMPER_HEIGHT])
        cube([base_length, BUMP_BUMPER_PADDING + BUMP_BUMPER_OVERHANG, BUMP_BUMPER_PADDING]);
        cube([base_length, BUMP_BUMPER_PADDING, BUMP_RADIUS + BUMP_BUMPER_HEIGHT]);
    }
}

module clip() {
    translate([WIDTH + 2 * THICKNESS, 0, 0])
    rotate(a = 90, v=[0, 1, 0])
    translate([-(HEIGHT + HEIGHT + STOPPER), 0, 0])
    hold(base_length=HEIGHT + HEIGHT + STOPPER, base_width = WIDTH + 2 * THICKNESS);
    straight_joint_no_stoppers();
}

module clip2() {
    translate([WIDTH + 2 * THICKNESS, 0, 0]) {
        difference() {
            union() {
                translate([0, (WIDTH/2 + THICKNESS) - CLIP_SPACING / 2 - CLIP_THICKNESS, 0])
                cube([CLIP_HEIGHT, CLIP_THICKNESS, HEIGHT + STOPPER + HEIGHT]);
                translate([0, (WIDTH/2 + THICKNESS) + CLIP_SPACING / 2, 0])
                cube([CLIP_HEIGHT, CLIP_THICKNESS, HEIGHT + STOPPER + HEIGHT]);
            }
            rotate(a = 45, v = [0, 1, 0])
            cube([WIDTH + 10 * THICKNESS, WIDTH + 10 * THICKNESS, WIDTH + 10 * THICKNESS]);
        }
    }
    straight_joint_no_stoppers();
}

module chapeau_tightener_smaller(d=0) {
    difference() {
        translate([0, 0, -d])
        chapeau_tightener();
        translate([-1, -1, -(d + 1)])
        cube([HEIGHT + 2, WIDTH + 2*THICKNESS + 2, d+1]);
        translate([-1, -1, -1])
        cube([d+1, WIDTH + 2*THICKNESS + 2, WIDTH + 2 * THICKNESS + 1]);
    }
        
}

module frame_stick() {
    difference() {
        union() {
            translate([0, FRAME_WIRE_WIDTH / 2, 0])
            cylinder(h = FRAME_WIRE_THICKNESS, r1 = FRAME_WIRE_WIDTH / 2, r2 = FRAME_WIRE_WIDTH / 2, $fn = 100);
            translate([FRAME_WIRE_LENGTH, FRAME_WIRE_WIDTH / 2, 0])
            cylinder(h = FRAME_WIRE_THICKNESS, r1 = FRAME_WIRE_WIDTH / 2, r2 = FRAME_WIRE_WIDTH / 2, $fn = 100);
            cube([FRAME_WIRE_LENGTH, FRAME_WIRE_WIDTH, FRAME_WIRE_THICKNESS]);
        }
        translate([0, FRAME_WIRE_WIDTH / 2, -1])
        cylinder(h = FRAME_WIRE_THICKNESS + 2, r1 = FRAME_WIRE_HOLE_RADIUS, r2 = FRAME_WIRE_HOLE_RADIUS, $fn = 100);
        translate([FRAME_WIRE_LENGTH, FRAME_WIRE_WIDTH / 2, -1])
        cylinder(h = FRAME_WIRE_THICKNESS + 2, r1 = FRAME_WIRE_HOLE_RADIUS, r2 = FRAME_WIRE_HOLE_RADIUS, $fn = 100);
    }
}

rotate(45, [0, 0, 1])
translate([-FRAME_WIRE_LENGTH / 2, -2 * (FRAME_WIRE_WIDTH + 1), 0]) {
    rows = 1;
    columns = 4;
    distance_rows = HEIGHT + 4;
    distance_columns = FRAME_WIRE_WIDTH + 3;

    for(row = [0:(rows - 1)]) {
        for(column = [0:(columns - 1)]) {
            translate([row * distance_rows, column * distance_columns, 0])
            frame_stick();
         }
    }
}

/*
// 25

rows = 8;
columns = 13;
distance_rows = HEIGHT + 4;
distance_columns = WIDTH + 2 * THICKNESS;

for(row = [0:(rows - 1)]) {
    for(column = [0:(columns - 1)]) {
        translate([row * distance_rows, column * distance_columns, 0])
        chapeau_tightener_smaller(0.5);
     }
}
*/