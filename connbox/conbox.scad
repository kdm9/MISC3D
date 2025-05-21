include <../utils/box.scad>

x = 100; y=35; z=55; wall=5; screw=3;

usb_w=28;
usb_h=35;
usb_off_bottom=8;
n_usb= 3;
hole_to_edge = wall + 2*screw + (x-4*screw)/2 - (n_usb* usb_w)/2 + usb_w/2;
hole_to_bottom =  wall + (z-usb_off_bottom-usb_h)/2 + usb_h/2 + usb_off_bottom;

difference() {
    union() {
        box_base(x, y, z, wall);
        box_screwposts(x, y, z, wall, screw, screw*2);
    }

    for(i = [0:2]) {
    translate([hole_to_edge + i*usb_w, 0,  hole_to_bottom])
        usb_module_hole();
    }
}

    
translate([x+4*wall+10, 0, z+wall+5]) box_lid(x, y, wall, wall, screw, screw*2);

// Holes

module usb_module_hole(w=19.5, h=22, depth=10, lip_depth=0.8, lip_w=0, lip_h=1, gap=0.5) {
    translate([-(w+2*gap+2*lip_w)/2, -eps, -(h+2*gap+2*lip_h)/2])
    union() {
        translate([0, lip_depth-eps, 0])
            cube([w+2*gap+2*lip_w,  depth, h+2*gap+2*lip_h,]);
        translate([lip_w, 0, lip_h])
        cube([w+2*gap, lip_depth, h+2*gap]);
    }
    
}
