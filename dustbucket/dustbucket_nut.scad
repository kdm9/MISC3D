bend_r=30;
wall=3;
bend_angle=85;
tube_od=40+2*wall;
eps=0.1;

include <BOSL2/std.scad>
use <threadlib/threadlib.scad>
include <../utils/vacuum_thread.scad>
$fn=96;

LOOSE_MTHREAD = [
   // to allow for shitty printing, we make smaller thread indents so it fits
   ["M64loose-int", [6, -33, 65, [[0, 2.5], [0, -2.5], [2.8, -0.4], [2.8, 0.4]]]],
];
rotate([90, 0, 0])
translate([30, 100, -20])
nut("M64loose", turns=2, Douter=85, nut_sides=6, table=LOOSE_MTHREAD);


