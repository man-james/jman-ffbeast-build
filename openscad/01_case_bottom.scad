include <BOSL2/std.scad>
$fn = 100;

h=8.1;
ha = 6; //8.1+6 = 14.1
l=150;
clamp=11.1; 
ca = 3; //11.1+3 = 14.1

module bottom_a() {
    diff() cuboid([clamp+ca,l,h+ha], chamfer=1, edges=[TOP+LEFT])attach(LEFT, LEFT, inside=true,shiftout=0.01)cuboid([clamp,l,h]);
}
//bottom_a();

module bottom_corner() {
    difference() {
        union() {
            right(11.1)down(11.1)rotate([0,-90,180])bottom_a();            
            right(11.1)cuboid([clamp+ca,l,h+ha], chamfer=5, edges=[RIGHT+TOP]);
        }
    }
}
//bottom_corner();

m10_dist_x = 108;
m10_dist_y = 100;
m10_r = 10.1/2;

module all_m10_holes(hole_z=alum_z) {
    module m10_holes_left() {
        move([-m10_dist_x/2, -m10_dist_y/2])cyl(h=hole_z, r=m10_r);
        move([-m10_dist_x/2, m10_dist_y/2])cyl(h=hole_z, r=m10_r);
    }
    
    m10_holes_left();
    xflip()m10_holes_left();
    
    //Hole in the center. May need to remove if it blocks motor
    move([0, -m10_dist_y/2])cyl(h=hole_z, r=m10_r);
}

module m10_nut_holes() {
    module m10_nut_holes_left() {
        move([-m10_dist_x/2, -m10_dist_y/2])regular_prism(6,r=9.3,h=8.1+0.1);
        move([-m10_dist_x/2, m10_dist_y/2])regular_prism(6,r=9.3,h=8.1+0.1);
    }
    m10_nut_holes_left();
    xflip()m10_nut_holes_left();
    move([0, -m10_dist_y/2])regular_prism(6,r=9.3,h=8.1+0.15);
}

module bottom_plate() {
    difference() {
        zz = 10.2; //13.2
        down((16.2-zz)/2 - 1.05)
        diff() cuboid([150+2,150,zz])
        attach(TOP, TOP, inside=true, shiftout=0.01) m10_nut_holes();
        all_m10_holes(zz+10);
        
        //m5 holes in 4 corners to attach the aluminum plate
        left(65)fwd(65)zcyl(r=5.25/2,h=zz+10);
        right(65)fwd(65)zcyl(r=5.25/2,h=zz+10);
        left(65)back(65)zcyl(r=5.25/2,h=zz+10);
        right(65)back(65)zcyl(r=5.25/2,h=zz+10);
        
        //m5 hex bolt head in 4 corners in the bottom face
        r5 = (2*sqrt(3)/3)*4;
        down(5.155)left(65)fwd(65)regular_prism(6,r=r5+0.2,h=3.7+0.1);
        down(5.155)right(65)fwd(65)regular_prism(6,r=r5+0.2,h=3.7+0.1);
        down(5.155)left(65)back(65)regular_prism(6,r=r5+0.2,h=3.7+0.1);
        down(5.155)right(65)back(65)regular_prism(6,r=r5+0.2,h=3.7+0.1);
        
        //2 m5 holes left & right to attach the axle clamp holder to the aluminum plate
        back(22)left(42)zcyl(r=5.15/2,h=zz+10);
        back(22)right(42)zcyl(r=5.15/2,h=zz+10);
        
        //2 m5 hex bolt heads in bottom face
        back(22)left(42)down(5.155)regular_prism(6,r=r5+0.2,h=3.7+0.1);
        back(22)right(42)down(5.155)regular_prism(6,r=r5+0.2,h=3.7+0.1);
        
        //4 m6 holes for t-shaped axle clamp to screw underneath the aluminum plate
        left(25)back(12.0)zcyl(r=6.2/2, h=60);
        right(25)back(12.0)zcyl(r=6.2/2, h=60);
        left(25)back(32.0)zcyl(r=6.2/2, h=60);
        right(25)back(32.0)zcyl(r=6.2/2, h=60);
        
        //4 m6 hex nuts
        //9.8/2 = 4.9 = a
        r6 = (2*sqrt(3)/3)*4.9;
        up_val = zz-9.4;
        up(up_val)left(25)back(12.0)regular_prism(6,r=r6+0.1,h=4.6+0.1);
        up(up_val)right(25)back(12.0)regular_prism(6,r=r6+0.1,h=4.6+0.1);
        up(up_val)left(25)back(32.0)regular_prism(6,r=r6+0.1,h=4.6+0.1);
        up(up_val)right(25)back(32.0)regular_prism(6,r=r6+0.1,h=4.6+0.1);
        
        
    }
}
//This can be used as a drill guide for the aluminum plate
//bottom_plate();

//This is to screw the case bottom to the front and back plates
module screwplate() {
    difference() {
        color("blue")cuboid([h+3, 4, h+3]);
        ycyl(r=3.1/2,l=10);
    }
}

module case_bottom() {
    difference() {
        union() {
            bottom_plate();
            right(70.96)zflip()bottom_corner();
            left(70.96)xflip()zflip()bottom_corner();
            
            fwd(150/2-(4)/2)up(11.1+ca/2)left(ca/2+68)screwplate();
            back(150/2-(4)/2)up(11.1+ca/2)left(ca/2+68)screwplate();
            fwd(150/2-(4)/2)up(11.1+ca/2)right(ca/2+68)screwplate();
            back(150/2-(4)/2)up(11.1+ca/2)right(ca/2+68)screwplate();
        }
    }
}
case_bottom();



