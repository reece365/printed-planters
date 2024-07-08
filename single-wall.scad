//Planter height
height = 80;

//Top radius
top_radius = 45;

//Bottom radius
bottom_radius = 35;

//Wall thickness
wall_thickness = 2;

//Bottom thickness
bottom_thickness = 2;


//low poly fan? this is your friend
sides=rands(4, 8, 1)[0];
twist=rands(10, 180, 1)[0];
//low poly fan? 0.01-low poly, 3-smooth(will take years to compile)
slice_factor=rands(0.02, 0.05, 1)[0];


module planter() {
    ////////////////////////////////////////////




    ///////////////////////////////////
    //difference(){
    //    difference(){
    //        shell(all_h,l_r_bottom+wall,l_r_top+wall,sides);
    //        difference(){
    //            shell(all_h,l_r_bottom,l_r_top,sides);
    //            cylinder(h=bot_thick,r=l_r_bottom*2);
    //            difference(){
    //                cylinder(h=all_h,r=2*l_r_top);
    //                cylinder(h=all_h,r=bracket_r,$fa=insert_fa);}
    //                }
    //        }
    //    translate([0,0,all_h-lip]) // //cylinder(h=lip,r=bracket_r+lip_dr,$fa=insert_fa);
    //}
    
    difference() {
        shell(height, bottom_radius, top_radius, sides);
        translate([0, 0, bottom_thickness])
            shell(height - bottom_thickness, bottom_radius - wall_thickness, top_radius - wall_thickness, sides);
    } 
    
    ///////////////////////////////////
    module shell(h,r_bottom,r_top,n_sides){
        linear_extrude(height=h,scale=r_top/r_bottom,,twist=twist,slices=all_h*slice_factor)
            circle(r_bottom/cos(180/n_sides),$fn=n_sides);
    }
    
}

//Render the planter and add the JAW emblem to the bottom
scale([0.75, 0.75, 0.75]) 
    difference() {
        planter();
        translate([0, 0, -1]) 
            linear_extrude(2)
                //Workaround to "retrace" the broken SVG
                offset(delta=0.001)
                    mirror() 
                        import(file = "jaw-bottom-emblem.svg", center = true, dpi = 412);
        
    }
