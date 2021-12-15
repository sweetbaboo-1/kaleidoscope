// everything has to be a factor of 0.4m

stroke = 2;
notch_width = 20.5;
notch_depth = 1;
distance_apart = 33 + 1/3;
wall_depth = 20;
triangle_height = (distance_apart * sqrt(3)) / 2;
num_rings = 10;
radius = distance_apart * num_rings;


diffuser_thickness = 0.4;


standoff_distance_from_edge = 2;

standoff_height = 5;
standoff_radius = 2;
standoff_length = 5; // this is how far out the standoff is from the backplate_chin

countersink_radius = 8;
countersink_depth = 2;

backplate_thickness = 5;


fudge = 1;

//diffuser();
//honeycomb();
//backplate_honeycomb();
backplate_chin();

module honeycomb()
{
    
    difference()
    {
        rotate(30) cylinder(h=wall_depth, r=radius /*+ stroke / 2*/, $fn=6);
    
    for (i = [num_rings / 2 - 1:-1:(-2 * num_rings) + (num_rings / 2)]) // draws the square
        {
            orgin = [triangle_height * -10, distance_apart * i  + (triangle_height - notch_width) / 2, wall_depth - notch_depth];
                                                                           //the + 1 is needed to finish the etch
            translate(orgin) rotate(30)cube([distance_apart * (num_rings * 2 + 1), notch_width, notch_depth + fudge]); 
        }
    
        for (y = [num_rings:-1:-num_rings]) 
        {
            for (x = [-num_rings:2:num_rings])
            {          
                translate([x * triangle_height + (triangle_height * (2/3)), y * distance_apart, -2]) rotate(60) cylinder (h=wall_depth+4, r=(triangle_height* 2/3) - stroke, $fn=3);
                translate([x * triangle_height - (triangle_height * (2/3)), y * distance_apart, -2]) rotate(0) cylinder (h= wall_depth+4, r=(triangle_height* 2/3) - stroke, $fn=3);
            
                translate([(x+1) * triangle_height + (triangle_height * (2/3)), (y) * distance_apart + distance_apart / 2, -2]) rotate(60) cylinder (h=wall_depth+4, r=(triangle_height* 2/3) - stroke, $fn=3);
                translate([(x+1) * triangle_height - (triangle_height * (2/3)), (y) * distance_apart + distance_apart / 2, -2]) rotate(0) cylinder (h=wall_depth+4, r=(triangle_height* 2/3) - stroke, $fn=3);        
            }
        }

        //trimming for print
        /* 
        translate([0,0,-5]) rotate(60) cube([1000,1000,100]);
        translate([0,0,-5]) rotate(120) cube([1000,1000,100]);
        translate([0,0,-5]) rotate(180) cube([1000,1000,100]);
        translate([0,0,-5]) rotate(-0) cube([1000,1000,100]);
        translate([0,0,-5]) rotate(-30) cube([1000,1000,100]);
        translate([0,-7 * distance_apart,-1]) rotate(30) cube([1000,1000,100]);
        translate([0,-6 * distance_apart,-1]) rotate(-30) cube([1000,1000,100]); 
        */
    }
}

module diffuser() difference() //union()
{
    
    translate([0,0,-diffuser_thickness])rotate(30) cylinder(h=diffuser_thickness, r=radius /* + stroke / 2 */, $fn=6);
    /*
    translate([0,0,-5]) rotate(60) cube([1000,1000,100]);
    translate([0,0,-5]) rotate(120) cube([1000,1000,100]);
    translate([0,0,-5]) rotate(180) cube([1000,1000,100]);
    translate([0,0,-5]) rotate(-0) cube([1000,1000,100]);
    translate([0,0,-5]) rotate(-30) cube([1000,1000,100]);
    translate([0,-7 * distance_apart,-1]) rotate(30) cube([1000,1000,100]);
    translate([0,-6 * distance_apart,-1]) rotate(-30) cube([1000,1000,100]); 
    */    
}

module backplate_honeycomb()
{
    // draw the backplate
    translate([0, 0, wall_depth + standoff_height]) rotate(30) cylinder(h=backplate_thickness, r=radius /*+ stroke / 2*/, $fn=6);
    
    
    
}


module backplate_chin() 
{
    rotate(30) cylinder(h=backplate_thickness, r=radius /*+ stroke / 2*/, $fn=6);
    
    
    // make the standoffs
    union() 
    {
    // center
    translate([0, 0, backplate_thickness]) cylinder(h=standoff_length, r=countersink_radius, $fn=100);
    }
    
    
    
    difference()
    {
    // drill the holes for the screws and the countersinks
    
    // top center
    translate([0, distance_apart * (num_rings - standoff_distance_from_edge), 0]) cylinder(h=standoff_height, r=standoff_radius, $fn=100);
    
    translate([0, distance_apart * (num_rings - standoff_distance_from_edge), 0]) cylinder(h=countersink_depth, r=countersink_radius, $fn=100);
    
    // top right
    translate([triangle_height * (num_rings - standoff_distance_from_edge), distance_apart * num_rings / 2, 0]) cylinder(h=standoff_height, r=standoff_radius, $fn=100);
    
    translate([triangle_height * (num_rings - standoff_distance_from_edge), distance_apart * num_rings / 2, 0]) cylinder(h=countersink_depth, r=countersink_radius, $fn=100);
    
    // bottom right
    translate([triangle_height * (num_rings - standoff_distance_from_edge), -distance_apart * num_rings / 2, 0]) cylinder(h=standoff_height, r=standoff_radius, $fn=100);
    
    translate([triangle_height * (num_rings - standoff_distance_from_edge), -distance_apart * num_rings / 2, 0]) cylinder(h=countersink_depth, r=countersink_radius, $fn=100);

    // bottom center
    translate([0, -distance_apart * (num_rings - standoff_distance_from_edge), 0]) cylinder(h=standoff_height, r=standoff_radius, $fn=100);
    
    translate([0, -distance_apart * (num_rings - standoff_distance_from_edge), 0]) cylinder(h=countersink_depth, r=countersink_radius, $fn=100);
    
    // bottom left
    translate([-triangle_height * (num_rings - standoff_distance_from_edge), -distance_apart * num_rings / 2, 0]) cylinder(h=standoff_height, r=standoff_radius, $fn=100);
    
    translate([-triangle_height * (num_rings - standoff_distance_from_edge), -distance_apart * num_rings / 2, 0]) cylinder(h=countersink_depth, r=countersink_radius, $fn=100);
    
    // top left
    translate([-triangle_height * (num_rings - standoff_distance_from_edge), distance_apart * num_rings / 2, 0]) cylinder(h=standoff_height, r=standoff_radius, $fn=100);
    
    translate([-triangle_height * (num_rings - standoff_distance_from_edge), distance_apart * num_rings / 2, 0]) cylinder(h=countersink_depth, r=countersink_radius, $fn=100);
    
    // center
    translate([0, 0, 0]) cylinder(h=countersink_depth, r=countersink_radius, $fn=100);
}
}
































