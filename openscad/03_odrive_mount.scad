include <BOSL2/std.scad>
include <03b_brake_resistor.scad>
$fn = 100;

//A model of the outer dimensions of the ODrive-S
module odrive() {
    difference() {
        m3_d = 54.3/2;
        cuboid([60,35,60]);
        up(m3_d)left(m3_d)ycyl(r=4.06/2, l=35+1);
        down(m3_d)left(m3_d)ycyl(r=4.06/2, l=35+1);
        up(m3_d)right(m3_d)ycyl(r=4.06/2, l=35+1);
        down(m3_d)right(m3_d)ycyl(r=4.06/2, l=35+1);
        //20mm apart holes to attach to the side of motor mount
        left(3)ycyl(r=3.2/2, l=35+1);
        left(23)ycyl(r=3.2/2, l=35+1);
    }
}
//odrive();

y = 5; //Board thickness
spacer = 5; //Cylindrical spacer

module odrive_mount() {   
    difference() {
        m3x_d = 54.3/2;
        m3z_d = 54.3/2;

        back(spacer/2)union() {
            cuboid([60+1.5,y,60+1.5], rounding=4, edges=[LEFT+BOTTOM, LEFT+TOP,  RIGHT+TOP]);
           
            //4 spacers so that board isn't flush with mount
            fwd(spacer/2+y/2) {
                up(m3z_d)left(m3x_d)ycyl(r=7/2, l=spacer);
                down(m3z_d)left(m3x_d)ycyl(r=7/2, l=spacer);
                up(m3z_d)right(m3x_d)ycyl(r=7/2, l=spacer);
                down(m3z_d)right(m3x_d)ycyl(r=7/2, l=spacer);
            }
            
            //L-shaped mount for brake resistor
            down(5.5)right(33.5)cuboid([10,5,50.5]);
            down(5.5)fwd(25/2)right(61.5/2+2.5+7.7)yrot(90)brake_resistor_mount();
        }
        
        //4 m3 heat insert screwholes
        up(m3z_d)left(m3x_d)ycyl(r=4.25/2, l=20+1);
        down(m3z_d)left(m3x_d)ycyl(r=4.25/2, l=20+1);
        up(m3z_d)right(m3x_d)ycyl(r=4.25/2, l=20+1);
        down(m3z_d)right(m3x_d)ycyl(r=4.25/2, l=20+1);
        
        //Cut out holes to make room for capacitors
        //Main square
        cuboid([43,y+spacer+1,43]);
        //Rectangle near brake resistor
        down(4.5)right(26)cuboid([9.0,y+spacer+1,34]);
        //Triangle to cut off corner near a capacitor
        up(12.5)right(21.5)rotate([90,0,0])down(y+1)linear_extrude(height=y+5)right_triangle([9.0,9.0]);

        //Hole for the heat insert of brake resistor
        right(40)down(25.5)back(1.0)xcyl(r=4.25/2, h=10);
    }
    
    //Extra protrusion for the bottommost screwhole
    difference() {
        back(spacer/2)left(25)cuboid([28,y,8], rounding=4, edges=[LEFT+BOTTOM, LEFT+TOP, RIGHT+TOP, RIGHT+BOTTOM]);

        //2 m3 holes to screw into motor mount
        left(15)ycyl(r=3.2/2, l=20+1);
        left(35)ycyl(r=3.2/2, l=20+1);
    }
}
odrive_mount();


