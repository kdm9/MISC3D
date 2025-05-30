include <BOSL2/std.scad>
include <BOSL2/hinges.scad>
include <../utils/box.scad>
use <davel/davel.scad>

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
        translate([wall, wall, wall]) cube([inner_x, inner_y, inner_z+1]);
    }
}

module tbevel(lx, ry, rz) {
    rotate([0, 0, 180])
    translate([-lx/2, 0, 0])
    rotate([0, 90, 0])
    linear_extrude(lx)
    polygon([
        [0, 0],
        [rz, 0],
        [0, ry]
    ]);
}


module mitered_bevel_butress(x, y, ry, rz, cr=0, cro=[0, 0, 0]) { // x, y are inner
    // bottom
    translate([0, -y/2, 0]) rotate([0, 0, 0])  tbevel(x, ry, rz);
    // top
    translate([0, y/2, 0]) rotate([0, 0, 180]) tbevel(x, ry, rz);
    // left
    translate([-x/2, 0, 0]) rotate([0, 0, 270]) tbevel(y, ry, rz);
    // right
    translate([x/2, 0, 0]) rotate([0, 0, 90]) tbevel(y, ry, rz);

    // bl
    translate([-x/2, -y/2, 0])
        intersection() {
            rotate([0, 0, 0]) tbevel(2*ry, ry, rz);
            rotate([0, 0, 270]) tbevel(2*ry, ry, rz);
            if(cr > 0) {
                translate([-cro[0], -cro[1], 0]) 
                rotate([0, 0, 90])
                union() {
                    translate([0, 0, -rz]) cylinder(h=rz, r=cr);
                    translate([0, 0, -rz]) cube([cr, cr, rz]);
                    translate([-cr, -cr, -rz]) cube([cr, cr, rz]);
                }
            }
        }
    //br
    translate([x/2, -y/2, 0])
        intersection() {
            rotate([0, 0, 0]) tbevel(2*ry, ry, rz);
            rotate([0, 0, 90]) tbevel(2*ry, ry, rz);
            if(cr > 0) {
                translate([cro[0], -cro[1], 0]) 
                union() {
                    translate([0, 0, -rz]) cylinder(h=rz, r=cr);
                    translate([0, 0, -rz]) cube([cr, cr, rz]);
                    translate([-cr, -cr, -rz]) cube([cr, cr, rz]);
                }
            }
        }
    // tl
    translate([-x/2, y/2, 0])
        intersection() {
            rotate([0, 0, 180]) tbevel(2*ry, ry, rz);
            rotate([0, 0, 270]) tbevel(2*ry, ry, rz);
            if(cr > 0) {
                translate([-cro[0], cro[1], 0]) 
                union() {
                    translate([0, 0, -rz]) cylinder(h=rz, r=cr);
                    translate([0, 0, -rz]) cube([cr, cr, rz]);
                    translate([-cr, -cr, -rz]) cube([cr, cr, rz]);
                }
            }
        }
    //tr
    translate([x/2, y/2, 0])
        intersection() {
            rotate([0, 0, 180]) tbevel(2*ry, ry, rz);
            rotate([0, 0, 90]) tbevel(2*ry, ry, rz);
            if(cr > 0) {
                translate([cro[0], cro[1], 0]) 
                rotate([0, 0, 90])
                union() {
                    translate([0, 0, -rz]) cylinder(h=rz, r=cr);
                    translate([0, 0, -rz]) cube([cr, cr, rz]);
                    translate([-cr, -cr, -rz]) cube([cr, cr, rz]);
                }
            }
        }
}

module mitered_buttress(x, y, r) { // x, y are inner
    // bottom
    translate([0, -y/2, 0]) davel_buttress(x, [0, -1, 0], [0, 0, -1], r);
    // top
    translate([0, y/2, 0]) davel_buttress(x, [0, 1, 0], [0, 0, -1], r);
    // left
    translate([-x/2, 0, 0]) davel_buttress(y, [-1, 0, 0], [0, 0, -1], r);
    // right
    translate([x/2, 0, 0]) davel_buttress(y, [1, 0, 0], [0, 0, -1], r);

    // bl
    translate([-x/2, -y/2, 0])
        intersection() {
            davel_buttress(2*r, [0, -1, 0], [0, 0, -1], r);
            davel_buttress(2*r, [-1, 0, 0], [0, 0, -1], r);
        }
    //br
    translate([x/2, -y/2, 0])
        intersection() {
            davel_buttress(2*r, [0, -1, 0], [0, 0, -1], r);
            davel_buttress(2*r, [1, 0, 0], [0, 0, -1], r);
        }
    // tl
    translate([-x/2, y/2, 0])
        intersection() {
            davel_buttress(2*r, [0, 1, 0], [0, 0, -1], r);
            davel_buttress(2*r, [-1, 0, 0], [0, 0, -1], r);
        }
    //tr
    translate([x/2, y/2, 0])
        intersection() {
            davel_buttress(2*r, [0, 1, 0], [0, 0, -1], r);
            davel_buttress(2*r, [1, 0, 0], [0, 0, -1], r);
        }
}



module box2(inner_x=90, inner_y=60, inner_z_base=40, inner_z_lid=5, wall=3, screw_diam=3, sp_z=15, screwposts=true, separate=false) {
    union() {
        halfbox(inner_x, inner_y, inner_z_base, wall);
        if (screwposts) {
            sp_diam=screw_diam+2*wall;
            sp_oh = screw_diam+wall; //overhang
            wr = sqrt(wall^2/2);

            translate([inner_x/2+wall, inner_y/2+wall, inner_z_base+wall-sp_z])
                mitered_bevel_butress(inner_x+2*wr, inner_y+2*wr, sp_oh+(wall-wr), 15, cr=screw_diam/2+wall, cro=[wall/2+(wall-wr), wall/2+(wall-wr), 0]);
            translate([wall, -sp_oh, inner_z_base+wall-sp_z])
                cube([inner_x, sp_oh, sp_z ]);
            translate([-sp_oh, wall, inner_z_base+wall-sp_z])
                cube([sp_oh, inner_y, sp_z ]);
            translate([wall, inner_y+2*wall, inner_z_base+wall-sp_z])
                cube([inner_x, sp_oh, sp_z ]);
            translate([inner_x+2*wall, wall, inner_z_base+wall-sp_z])
                cube([sp_oh, inner_y, sp_z ]);

            translate([-sp_oh, -sp_oh, inner_z_base+wall-sp_z])
                screwpost(sp_z, screw_diam, sp_diam, centre=false, rot=0,   square=[false, true, true, true]);
            translate([inner_x+1*wall, -sp_oh, inner_z_base+wall-sp_z])
                screwpost(sp_z, screw_diam, sp_diam, centre=false, rot=90,  square=[false, true, true, true]);
            translate([-sp_oh, inner_y+1*wall, inner_z_base+wall-sp_z])
                screwpost(sp_z, screw_diam, sp_diam, centre=false, rot=270, square=[false, true, true, true]);
            translate([inner_x+1*wall, inner_y+1*wall, inner_z_base+wall-sp_z])
                screwpost(sp_z, screw_diam, sp_diam, centre=false, rot=180, square=[false, true, true, true]);
        }
    }

}



module hexcyl(d=10, h=10) {
    // envision the triangle between the centre of a hexagon and its "point"
    // θ=30, adj=r, hyp=x; c=a/h; hyp=adj/cos(30)
    r=d/2;
    crad = r/cos(30);
    cylinder(r=crad, h=h, $fn=6);
}

module pg7_cutout(rot=[0, 90, 0], nut_depth=1.6, wall_depth=4, depth=7) {
    rotate(rot)
        rotate([0, 0, 60])
        hexcyl(d=17.5, h=nut_depth);
    rotate(rot)
        cylinder(d=13.5, h=depth+2*eps, $fn=100);
    rotate(rot)
        translate([0, 0, wall_depth])
        cylinder(d=22, h=depth+2*eps, $fn=100);
}


module pg7() {
    translate([-6.7,0, 0])
    color("#222222")
    import("3d/pg/pg7.stl");
}
