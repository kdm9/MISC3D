include <../utils/box.scad>
$fn=96;
module roundcube(inner_x=90, inner_y=60, inner_z=30, wall=3) {
    hull() {
        translate([wall, wall, wall]) sphere(wall); 
        translate([inner_x+wall, wall, wall]) sphere(wall); 
        translate([wall, inner_y+wall, wall]) sphere(wall); 
        translate([inner_x+wall, inner_y+wall, wall]) sphere(wall); 
        translate([wall, wall, inner_z+wall]) sphere(wall); 
        translate([inner_x+wall, wall, inner_z+wall]) sphere(wall); 
        translate([wall, inner_y+wall, inner_z+wall]) sphere(wall); 
        translate([inner_x+wall, inner_y+wall, inner_z+wall]) sphere(wall); 
    }
}

module halfbox(inner_x=90, inner_y=60,  inner_z=30, wall=3) {
    difference() {
        roundcube(inner_x, inner_y, inner_z, wall);
        translate([0, 0, inner_z+wall]) cube([inner_x+2*wall, inner_y+2*wall, wall]);
        translate([wall, wall, wall]) cube([inner_x, inner_y, inner_z+0.01]);
    }
}


module box_with_lid(inner_x=90, inner_y=60, inner_z_base=40, inner_z_lid=5, wall=3, screw_diam=3, screwposts=true, separate=false) {

    union() {
        halfbox(inner_x, inner_y, inner_z_base, wall);
        if (screwposts) {
            sp_diam=screw_diam+2*wall;
            translate([0, 0, wall])
                screwpost(inner_z_base, screw_diam, sp_diam, centre=false, rot=0);
            translate([inner_x+2*wall-sp_diam, 0 , wall])
                screwpost(inner_z_base, screw_diam, sp_diam, centre=false, rot=90);
            translate([0, inner_y+2*wall-sp_diam, wall])
                screwpost(inner_z_base, screw_diam, sp_diam, centre=false, rot=270);
            translate([inner_x+2*wall-sp_diam, inner_y+2*wall-sp_diam, wall])
                screwpost(inner_z_base, screw_diam, sp_diam, centre=false, rot=180);
        }
    }


    /*
    if (separate) {
        translate([0, inner_y+4*wall + 5, 0]) halfbox(inner_x, inner_y, inner_z_lid, wall);
    } else {
        translate([0, 0, inner_z_base+wall + inner_z_lid + wall + 5])
            mirror([0, 0, 1]) halfbox(inner_x, inner_y, inner_z_lid, wall);
    }
    */
}

box_with_lid(76, 38, 38, wall=4);
