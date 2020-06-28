

module elephant() {
    translate([0, 0, 20]) {
        rotate([0, 0, 90])
        translate([70, 0, 20])
        scale([1.5, 1.5, 1.5])
        scale([5, 5, 5])
        import("external_models/Elephant/files/Elephant.stl", convexity = 5);
        scale([6.5, 7.5, 1])
        cylinder(h=40, r=50, center=true, $fn = 100);
    }
}

module inner_ring() {
    scale([7, 7, 7])
    rotate([0, 90, 0])
    import("external_models/Flexible+Bike+Smartphone+Mount/files/ring_32mm-v38.stl", convexity = 5);
}

//rotate([0, -90, 0])

module ring() {
    difference() {
        intersection() {
            inner_ring();
            cube([2000, 400, 91], center=true);
        }
        translate([182, 0, 0])
        cube([60, 500, 200], center=true);
    }
    translate([142, 0, 0])
    intersection() {
        minkowski() {
            cube([50, 400, 71], center=true);
            sphere(r=10);
        }
        translate([0, -250, -50])
        cube([20, 500, 100]);
    }
}

//elephant();
ring();

module shape() {
    intersection() {
        minkowski() {
            cube([50, 400, 71], center=true);
            sphere(r=10);
        }
        translate([0, -250, -50])
        cube([20, 500, 100]);
    }
}

module outer_shape() {
    translate([1, 0, 0])
    difference() {
        translate([-1, 0, 0])
        scale([1, 5, 5])
        shape();
        translate([-10, 0, 0])
        scale([2, 1 ,1])
        shape();
    }
}

width = 10;
module outside() {
    difference() {
        minkowski() {
            shape();
            sphere(r=width);
        }
        scale([5, 1, 1])
        shape();
        translate([-20, 0, 0])
        scale([2, 5, 5])
        shape();
    }
}

module inside() {
    difference() {
        intersection() {
            minkowski() {
                outer_shape();
                sphere(r = width);
            }
            scale([5, 1, 1])
            shape();
        }
        translate([-20, 0, 0])
        scale([2, 5, 5])
        shape();
    }
}

/*
intersection() {
            minkowski() {
                outer_shape();
                sphere(r = width);
            }
translate([-30, 0, 0])
scale([5, 1, 1])
shape();
}
*/

//outside();
//inside();

//outer_shape();
//shape();

//color("blue")
//cube([2000, 400, 91], center=true);

//translate([0, 0, 200])
//cube([600, 700, 40], center=true);
//cylinder(h=200, r=111, $fn=100);