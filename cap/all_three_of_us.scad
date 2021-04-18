import("AI3M_all_three_of_us.stl");

difference() {
    translate([-89.75, -69.25, 0])
    cube([179.5, 138.5, 10]);

    translate([-73.75, -56.25, 0])
    cube([147.5, 112.5, 11]);
}