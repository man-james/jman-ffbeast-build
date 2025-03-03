include <BOSL2/std.scad>
$fn = 100;

module motor_holder() {
    difference() {
        union() {
            cuboid([62+7,40+7,47.41]);
            
            //lip to surround the T-shaped aluminum axel clamp
            up(47.41/2)rect_tube(size=[69,47], wall=3.3, h=6);
            
            down(21+0.205) {
            //Left ear to attach from bottom of case
                left(41)cuboid([13,12,5],rounding=5, edges=[FWD+LEFT, BACK+LEFT]);
                back(5)left(34)zrot(90)linear_extrude(height=5, center=true)mask2d_roundover(r=10);
                fwd(5)left(34)zrot(180)linear_extrude(height=5, center=true)mask2d_roundover(r=10);
                left(34)zrot(180)xrot(90)linear_extrude(height=12, center=true)mask2d_roundover(r=9);
                
                
                //Right ear to attach from bottom of case
                right(41)cuboid([13,12,5],rounding=5, edges=[FWD+RIGHT, BACK+RIGHT]);
                back(5)right(34)zrot(0)linear_extrude(height=5, center=true)mask2d_roundover(r=10);
                fwd(5)right(34)zrot(-90)linear_extrude(height=5, center=true)mask2d_roundover(r=10);
                right(34)xrot(90)linear_extrude(height=12, center=true)mask2d_roundover(r=9);
            }
        }
        
        //4 m6 holes
        move([25,-10,0])zcyl(r=6.2/2, l=48);
        move([-25,-10,0])zcyl(r=6.2/2, l=48);
        move([25,10,0])zcyl(r=6.2/2, l=48);
        move([-25,10,0])zcyl(r=6.2/2, l=48);
        
        //hole for ears
        left(42)zcyl(r=5.2/2,h=48);
        right(42)zcyl(r=5.2/2,h=48);
        
        //20mm holes apart for m3 heat inserts to attach fan and odrive mounting boards
        up(47/2-5) {
            up(6/3)right(69/2-3)xcyl(r=4.25/2, l=6.1);
            up(6/3)left(69/2-3)xcyl(r=4.25/2, l=6.1);
        }
        up(47/2-25) {
            up(6/3)right(69/2-3)xcyl(r=4.25/2, l=6.1);
            up(6/3)left(69/2-3)xcyl(r=4.25/2, l=6.1);
        }
    }
}
motor_holder();

