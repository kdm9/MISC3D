include <../utils/vacuum_thread.scad>
include <../utils/misc.scad>
$fn=180;
thread_h=30;
thread_od=45;
flange_h=20;
nozzle_h=55;
nozzle_bd=60;
nozzle_td=55;
eps=0.05;



translate([0, 0, thread_h])
    rotate([180, 0, 0])  // by default the thread starts at the top but we want it facing down
    vacuum_hose_thread(h=thread_h);

translate([0, 0, thread_h-eps/10])
    conical_tube(flange_h+eps, nozzle_bd, thread_od, wall=3);

translate([0, 0, thread_h+flange_h-eps/10])
    conical_tube(nozzle_h+eps/10, nozzle_td, nozzle_bd, wall=3);
