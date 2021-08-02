$fn = 60;

// The hole radius for the screws
hole_radius = 2;

hole_x_dist = 30;
hole_y_dist = 15;

plate_width = 40;
plate_depth = 25;
plate_height = 6;

mounting_width = 47.25;
mounting_height = 12;

mounting_hole_radius = 4.25;
mounting_hole_x_dist = 46;
mounting_hole_y_dist = 46;

module corner_holes(x_dist, y_dist, radius, depth){
    for(i = [0:1]){
        for(j = [0:1]){
            translate([i * x_dist - x_dist / 2, j * y_dist - y_dist / 2, 0])
            cylinder(depth, r1=radius, r2=radius, center=true);
        }
    }
}

difference(){
    // Create plate
    translate([-plate_width/2, -plate_depth/2, 0])
    cube([plate_width, plate_depth, plate_height]);

    corner_holes(hole_x_dist, hole_y_dist, hole_radius, plate_height * 2);
}


// Mounting plate
difference(){
    translate([0, 0, mounting_height/2])
    cylinder(mounting_height, r1=mounting_width, r2=mounting_width, center=true);
    
    // Inner plate
    translate([-plate_width/2, -plate_depth/2, 0])
    cube([plate_width, plate_depth, mounting_height]);
    
    corner_holes(mounting_hole_x_dist, mounting_hole_y_dist, mounting_hole_radius, mounting_height * 2);
}
