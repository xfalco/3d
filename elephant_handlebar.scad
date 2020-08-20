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
    rotate([0, 90, 0])
    import("external_models/Flexible+Bike+Smartphone+Mount/files/ring_22mm-v38.stl", convexity = 5);
}

module inner_ring_old() {
    scale([7, 7, 7])
    rotate([0, 90, 0])
    import("external_models/Flexible+Bike+Smartphone+Mount/files/ring_32mm-v38.stl", convexity = 5);
}

module ring() {
    difference() {
        translate([0, 0, -0.35])
        scale([1, 1, 0.95])
        intersection() {
            inner_ring();
            cube([200, 64, 13], center=true);
        }
        translate([20.5, 0, 0])
        cube([8, 71, 28], center=true);
        translate([35, 0, 30])
        minkowski() {
            cube([80, 80, 40], center = true);
            sphere(r=10, $fn = 100);
        }
        translate([0, 0, -13])
        cube([60, 60, 13], center= true);
    }
    translate([15.5, 0, 0])
    intersection() {
        minkowski() {
            cube([20, 57, 7], center=true);
            sphere(r=4, $fn = 100);
        }
        translate([0, -35, -6.5])
        cube([5, 70, 13]);
    }
}

module old_ring() {
    difference() {
        intersection() {
            inner_ring_old();
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

module new_new_ring() {
    difference() {
            translate([0, 0, -0.35])
            scale([1, 1, 0.95])
            intersection() {
                inner_ring();
                cube([200, 64, 13], center=true);
            }
            translate([18.5, 0, 0])
            cube([8, 71, 28], center=true);
        }
}

module left_ring() {
    intersection() {
        rotate([0, 0, 5])
        new_new_ring();
        translate([-20, 8, 0])
        cube([15, 14, 16], center=true);
    }
}

module right_ring() {
    intersection() {
        rotate([0, 0, -4.5])
        new_new_ring();
        translate([-20, -8, 0])
        cube([15, 14, 16], center=true);
    }
}

module ring_without_ends() {
    intersection() {
        difference() {
            rotate([0, 0, 5])
            new_new_ring();
            translate([-20, 8, 0])
            cube([15, 14, 16], center=true);
        }
        translate([-50, 0, -50])
        cube([100, 50, 100]);
    }
    intersection() {
        difference() {
            rotate([0, 0, -4.5])
            new_new_ring();
            translate([-20, -8, 0])
            cube([15, 14, 16], center=true);
        }
        translate([-50, -50, -50])
        cube([100, 50, 100]);
    }
}

module half_ring() {
    intersection() {
        ring_without_ends();
        translate([0, -28, 0])
        cube([100, 50, 100], center = true);
    }
    translate([-0.5, 0, 0])
    rotate([0, 0, 180])
    left_ring();
    right_ring();
}

module half_ring_with_base() {
    half_ring();
    translate([26, 0, 0])
    intersection() {
        minkowski() {
            cube([20, 37, 7], center=true);
            sphere(r=4, $fn = 100);
        }
        translate([0, -35, -6.5])
        cube([5, 70, 13]);
        translate([0, 0, 4.75])
        cube([100, 50, 22.5], center=true);
    }
}

half_ring_with_base();
/*
translate([0, 0, 4.75])
cube([100, 50, 22.5], center=true);*/

/*
translate([-50, 0, 0])
cube([100, 50, 100]);*/

/*


new_new_ring();*/

/*
new_new_ring();

color("red")
translate([-20, -8, 0])
cube([15, 14, 16], center=true);*/

//elephant();

//old_ring();
//ring();

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

//color("blue")
//cylinder(h=20, r=11.1, $fn=100);