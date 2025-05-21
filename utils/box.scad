$fn=96;
eps=0.01;

// Dimensions are inner
module box_base(x, y, z, wall=4) {
        
    difference() {
       cube([x+2*wall, y+2*wall, z+wall]);
       translate([wall, wall, wall])
            cube([x, y, z+eps]);
    };
}



module screwpost(z, id, od, centre=true, rot=0) {
    translate(!centre ? [od/2, od/2, 0]: [0, 0, 0])
    rotate([0,0, rot])
    difference() {
            union() {
                //translate([-od/2, -od/2, 0])
                //    cube([od/2, od/2, z]);
                translate([-od/2, 0, 0])
                    cube([od/2, od/2, z]);
                translate([0, -od/2, 0])
                    cube([od/2, od/2, z]);
                cylinder(h=z, d=od);
            }
            thread_forming_hole(id, z);
        };
}

module threadform(id, z) {
    translate([id/2, id/2, 4*z/5])
        cylinder(h=z/5, d1=id*0.7, d2=id*0.45);
    translate([id/2, id/2, 0])
        cylinder(h=4*z/5, d=id*0.7);
};

module thread_forming_hole(id, z) {
    translate([0, 0, -eps])
    difference() {
        cylinder(h=z+2*eps, d=id);
        rotate([0, 0, 0])
            threadform(id, z+2*eps);
        rotate([0, 0, 120])
            threadform(id, z+2*eps);
        rotate([0, 0, 240])
            threadform(id, z+2*eps);
    }
}


module box_screwposts(x, y, z, wall, id, od) {
    inoff = id/2;
    
    translate([wall+inoff, wall+inoff, wall])
        screwpost(z, id, od);
    
    translate([wall+x-inoff, wall+inoff, wall])
        rotate([0,0,90])
        screwpost(z, id, od);
    translate([wall+inoff, wall+y-inoff, wall])
        rotate([0,0,90])
        screwpost(z, id, od);
    
    translate([wall+x-inoff, wall+y-inoff, wall])
        screwpost(z, id, od);
    
}

module box_lid(x, y, inset, wall, id, od, gap=0.5) {
    // upper
    difference() {
        cube([x+2*wall, y+2*wall, wall]);
        translate([wall+id/2, wall+id/2, -eps])
            cylinder(h=wall+2*eps, d=id);
        translate([x + wall-id/2, wall+id/2, -eps])
            cylinder(h=wall+2*eps, d=id);
        translate([wall+id/2, y + wall-id/2, -eps])
            cylinder(h=wall+2*eps, d=id);
        translate([x+wall-id/2, y + wall-id/2, -eps])
            cylinder(h=wall+2*eps, d=id);
    }
    //lower
    translate([0, 0, -wall])
    difference() {
        translate([wall+gap, wall+gap, 0])
            cube([x-2*gap, y-2*gap, wall]);
        
        square = id + (od-id)/2 + gap;
        translate([wall+gap-eps, wall+gap-eps, -eps])
            cube([square+eps, square+eps, wall+2*eps]);
        
        translate([x+wall-gap-square+eps, wall+gap-eps, -eps])
            cube([square+eps, square+eps, wall+2*eps]);
        
        translate([wall+gap-eps, y+wall-gap-square+eps, -eps])
            cube([square+eps, square+eps, wall+2*eps]);
        
        translate([x+wall-gap-square+eps, y+wall-gap-square+eps, -eps])
            cube([square+eps, square+eps, wall+2*eps]);
    }
}
