MINKOWSKI_EXPANSION = 2;

PAD_BRIDGE = 16 + (2 * MINKOWSKI_EXPANSION);
STRING_WIDTH = 1 + (2 * MINKOWSKI_EXPANSION);
WIDTH = 10;
PADDING = 5;
STRING_INDENT = 15;
INDENT_PAD = 15;
INDENT_WALL = 25;

CUBE = 30;

$fn=50;
minkowski() {
    difference() {
        cube([INDENT_WALL + STRING_WIDTH + PADDING, PADDING + PAD_BRIDGE + PADDING + STRING_INDENT, WIDTH]);
        translate([-1, PADDING, -1])
        cube([INDENT_WALL + STRING_WIDTH + 1, PAD_BRIDGE , WIDTH + 2]);
        translate([-1, -1, -1])
        cube([INDENT_WALL - INDENT_PAD + 1, PADDING + 2,  WIDTH + 2]);
        translate([INDENT_WALL, PADDING + PAD_BRIDGE + PADDING, -1])
        cube([STRING_WIDTH, STRING_INDENT + 1, WIDTH + 2]);
        translate([0, PADDING + PAD_BRIDGE + (CUBE / sqrt(2)), 0])
        rotate(45, [0, 0, 1])
        cube([CUBE, CUBE, CUBE], center=true);
        translate([INDENT_WALL + (STRING_WIDTH / 2), PADDING + PAD_BRIDGE + PADDING + STRING_INDENT+ (CUBE / sqrt(2)) - PADDING, 0])
        rotate(45, [0, 0, 1])
        cube([CUBE, CUBE, CUBE], center=true);
    }
    sphere(MINKOWSKI_EXPANSION, $fn=100); 
}
