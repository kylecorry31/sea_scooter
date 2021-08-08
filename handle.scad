$fn=50;

module corner_holes(x_dist, y_dist, radius, depth){
    for(i = [0:1]){
        for(j = [0:1]){
            translate([i * x_dist - x_dist / 2, j * y_dist - y_dist / 2, 0])
            cylinder(depth, r1=radius, r2=radius, center=true);
        }
    }
}

module rounded_cube(width, length, height, corner_radius){
    cube_width = width - 2 * corner_radius;
    cube_height = height - 2 * corner_radius;
    
    translate([0, -cube_width/2, 0])
    cube([length, cube_width, height]);
    
    translate([0, -width/2, corner_radius])
    cube([length, width, cube_height]);
    
    // Bottom left
    translate([length / 2, width / 2 - corner_radius, corner_radius])
    rotate([0, 90, 0])
    cylinder(h = length, r = corner_radius, center=true);
    
    // Bottom right
    translate([length / 2, -width / 2 + corner_radius, corner_radius])
    rotate([0, 90, 0])
    cylinder(h = length, r = corner_radius, center=true);
    
    // Top right
    translate([length / 2, -width / 2 + corner_radius, height - width / 2 + corner_radius])
    rotate([0, 90, 0])
    cylinder(h = length, r = corner_radius, center=true);
    
    // Top left
    translate([length / 2, width / 2 - corner_radius, height - width / 2 + corner_radius])
    rotate([0, 90, 0])
    cylinder(h = length, r = corner_radius, center=true);
}

length = 125;
corner_radius = 10;
width = 40;
height = 30;
height_offset = 5;

inner_radius = 6;
center_hole_offset = 6;

hole_radius = 2;

hole_x_dist = 30;
hole_y_dist = 15;

plate_width = 40;
plate_depth = 25;
plate_height = 12;

thruster_radius = 48;


// Mounting point
translate([0, 0, -plate_height / 2])
rotate([0, 0, 90])
difference(){
    // Create plate
    translate([-width/2, -plate_depth/2, 0])
    cube([width, plate_depth, plate_height]);

    corner_holes(hole_x_dist, hole_y_dist, hole_radius, plate_height * 2);
}

// Handle
difference(){
    cube_width = width - 2 * corner_radius;
    cube_height = height - 2 * corner_radius;
    
    translate([plate_depth / 2, 0, -height / 2 + height_offset])
    rounded_cube(width, length, height, corner_radius);
    
    // Thruster
    translate([0, 0, -thruster_radius - plate_height / 2 + 1.75])
    rotate([90, 0, 0])
    cylinder(width, thruster_radius, thruster_radius, center=true);
    
    // Center hole
    translate([plate_depth / 2, 0, height - plate_height - center_hole_offset])
    rotate([0, 90, 0])
    cylinder(h = length, r = inner_radius / 2);
    
}


