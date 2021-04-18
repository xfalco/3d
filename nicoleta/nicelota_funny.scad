import("nicoleta_funny_pic_obv.stl");

difference() {
    translate([-71, -56, 0])
    cube([142, 112, 10]);

    translate([-60, -45, 0])
    cube([120, 90, 11]);
}