module cone(height=55, top_d=55, bottom_d=60) {
    linear_extrude(height=height, scale=(top_d/bottom_d))
        circle(d=bottom_d);
}


module conical_tube(height, top_d, bottom_d, wall) {
    difference() {
        cone(height, top_d, bottom_d);
        translate([0, 0, -eps/2])
            cone(height+eps, top_d-2*wall, bottom_d-2*wall);
    }
}

