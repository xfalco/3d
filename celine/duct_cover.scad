module sidePiece() {
    difference() {
        cube([155,207,14]);
        translate([-1, 5, 7]) cube([151,197,8]);
        translate([-1, 30, 4]) cube([121, 147, 11]);
    }
}

module centerPiece() {
    difference() {
        cube([150,207,14]);
        translate([-1, 5, 7]) cube([152,197,8]);
        translate([-1, 30, 4]) cube([152, 147, 11]);
    }
}

// rotate because Cura Ultimaker prints vertically - too close to wipe
rotate(90, [0, 0, 1])
sidePiece();