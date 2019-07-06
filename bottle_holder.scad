HEIGHT=2;
OUTER_D=45;
INNER_D=39;

HOLDER_WIDTH=14;
HOLDER_LENGTH=14;
HOLDER_HOLE_D=11;

module ring() {
    linear_extrude(height=HEIGHT)
    difference() {
        circle(d=OUTER_D,$fn=100);
        circle(d=INNER_D,$fn=100);
    }
}

module holder() {
    minkowski() {
        linear_extrude(height=HEIGHT-1) {
            difference() {
                translate([-HOLDER_WIDTH/2,-HOLDER_LENGTH/2])
                square([HOLDER_WIDTH,HOLDER_LENGTH]);
                circle(d=HOLDER_HOLE_D,$fn=100);
            }
        }
        sphere(r=0.5,center=true,$fn=10);
    }
}

union() {
    ring();
    translate([OUTER_D/2 + 6,0,0.5])
    holder();
}