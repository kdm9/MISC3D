ch=80;
cod=180;
platew=60;
wall=3;
eps=0.1;

module snail(ch, cod, platew) {
    cylinder(h=ch, d=cod);
    translate([cod/2-platew, 0, 0])
        cube([platew, cod/2, ch]);
}

if(1){
color("grey", 0.9)
difference() {
    snail(ch, cod, platew);
    translate([0, 0, wall]) 
        snail(ch-wall+eps, cod-wall, platew-wall);
}
}



translate([0,0, ch])
mirror([0, 0, 1])
color("red")
difference(){
    linear_extrude(20, scale=cod/(cod+8*wall))
    union(){
        circle(d=cod+8*wall);
        translate([cod/2-platew, 0, 0])
            square([platew+2*wall, cod/2+2*wall]);
    };
    translate([0, 0, -eps/2])
    linear_extrude(20+eps, scale=cod/(cod-2*wall))
    union(){
        circle(d=cod-4*wall);
        translate([cod/2-platew+wall, 0, 0])
            square([platew+-3*wall, cod/2-3*wall]);
    };
    /*
    union(){
        circle(d=cod-4*wall);
        translate([cod/2-platew, 0, 0])
            square([platew-4*wall, cod/2-4*wall]);
    }
    // circle(d=cod-4*wall);
    */
}