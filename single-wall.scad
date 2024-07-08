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


//Number of sides (default randomized)
sides=rands(4, 8, 1)[0];

//Twist from top to bottom (default randomized)
twist=rands(10, 180, 1)[0];

//Slice factor, number of subdivisions (default randomized)
slice_factor=rands(0.02, 0.05, 1)[0];


//Path to an SVG emblem placed at the bottom of the planter
emblem_path = "jaw-bottom-emblem.svg";

//Emblem depth
emblem_depth = 1;

//Emblem scale (dpi)
emblem_scale = 412;

module planter() {
    module shell(h,r_bottom,r_top,n_sides){
        linear_extrude(height=h,scale=r_top/r_bottom,,twist=twist,slices=all_h*slice_factor)
            circle(r_bottom/cos(180/n_sides),$fn=n_sides);
    }
    
    difference() {
        shell(height, bottom_radius, top_radius, sides);
        translate([0, 0, bottom_thickness])
            shell(height - bottom_thickness, bottom_radius - wall_thickness, top_radius - wall_thickness, sides);
    } 
}

//Render the planter and add an emblem to the bottom
difference() {
    planter();
    translate([0, 0, -emblem_depth]) 
        linear_extrude(emblem_depth * 2)
            //Workaround to "retrace" potentially broken SVGs
            offset(delta=0.001)
                mirror() 
                    import(file = emblem_path, center = true, dpi = emblem_scale);
    
}
