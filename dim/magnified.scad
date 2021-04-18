import("AI3M_dim_magnified.stl");

difference() {
    translate([-70, -70, 0])
    cube([140, 140, 10]);

    translate([-59, -59, 0])
    cube([118, 118, 11]);
}