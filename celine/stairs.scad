module base() {
    rotate(a=-52.6, v=[1, 0, 0])
    cube([10, 800, 800]);
}

translate([0, -100, 10])
rotate(a=90, v=[0, 1, 0])
intersection() {
    difference() {
        base();
        translate([-5, 10, 0])
        base();
        translate([-100, -10, -1000])
        cube([200, 2000, 1000]);
    }
    translate([-20, 100, -10])
    cube([50, 150, 1000]);
}