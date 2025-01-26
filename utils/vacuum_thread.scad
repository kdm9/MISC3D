// (C) Kevin Murray 2025
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

include <BOSL2/std.scad>
use <threadlib/threadlib.scad>

MY_THREAD_TABLE = [
   ["vactube", [-5.55, -20, 39.5, [ [0, 1.6], [0, -1.6], [2.4, -0.7], [2.4, 0.7]]]]
];


module vacuum_hose_thread(h=40, od=45) {
    id=39.5;
    union() {
        difference() {
            cylinder(h=h, d=od);
            translate([0, 0, -eps/2])
                cylinder(h=h+eps, d=id);
        }
        intersection() {
                cylinder(h=h, d=od);
                translate([0, 0, h + -1.1])
                    thread("vactube", turns=10, table=MY_THREAD_TABLE);
        }
    }
}
