include <BOSL2/std.scad>
$fn = 100;

hole_x = 40;
hole_y = 22;
hole_r = 3.5/2;

//This is just a model of the brake resistor
module brake_resistor() {
    difference() {
        union()  {
            cuboid([50, 16.3, 15.5]);
            
            ear_z = 2;
            ear_y = (29-16.3)/2;
            ear_x = 10;

            
            move([(50-ear_x)/2, (16.3+ear_y)/2,-(15.5-ear_z)/2])cuboid([ear_x, ear_y, ear_z]);
            move([-(50-ear_x)/2, -(16.3+ear_y)/2,-(15.5-ear_z)/2])cuboid([ear_x, ear_y, ear_z]);
            
            xcyl(r=2/2, h=71);
        
        }
    
        fwd(hole_y/2)left(hole_x/2)zcyl(r=hole_r, h=15.5+0.1);
        back(hole_y/2)right(hole_x/2)zcyl(r=hole_r, h=15.5+0.1);
    }
}

module brake_resistor_mount() {
    mount_z = 5;
    difference() {
        union() {
            cuboid([50.5, 29+1, mount_z], rounding=4, edges=[LEFT+FWD,  RIGHT+FWD]);
        }
        //Brass heat insert holes m3
        hole_z = 22;
        back(hole_z/2)right(hole_x/2)zcyl(r=4.25/2, h=mount_z+0.1);
        fwd(hole_z/2)left(hole_x/2)zcyl(r=4.25/2, h=mount_z+0.1);
        
        //Hole to allow the 2 aux wires to reach the ODrive board
        cuboid([34,16,mount_z+0.1]);
    }
}

//up(15)brake_resistor();
//brake_resistor_mount();