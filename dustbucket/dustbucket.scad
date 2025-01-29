bend_r=30;
wall=3;
bend_angle=85;
tube_od=40+2*wall;
eps=0.1;

include <BOSL2/std.scad>
use <threadlib/threadlib.scad>
include <../utils/vacuum_thread.scad>
$fn=96;

translate([0, 50, 0])
union() {
    rotate_extrude(angle=bend_angle)
        translate([bend_r, 0, 0])
        difference() {
            circle(d=tube_od);
            circle(d=tube_od-2*wall);
        };

    translate([bend_r, 0, 0])
    rotate([90, 0, 0])    
      union() {
          difference() {  
              translate([0, 0, 3])
                bolt("M64", turns=7);
              translate([0, 0, -0.1])
                cylinder(d=45, h=60);
          };
          vacuum_hose_thread(h=50);
          difference() {
              cylinder(d=85, h=5);
              translate([0, 0, -eps/2])
              cylinder(d=36, h=5+eps);
          }
      }
}

