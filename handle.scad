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
    translate([length / 2, corner_radius, height / 2 - corner_radius])
    rotate([0, 90, 0])
    hull(){
        for(i = [0:1]){
        for(j = [0:1]){
            translate([i * height - height / 2 - 2 * i * corner_radius, j * width - width / 2 - 2 * j * corner_radius, 0])
            cylinder(length, r1=corner_radius, r2=corner_radius, center=true);
        }
    }
    }
}

length = 125;
corner_radius = 10;
width = 40;
height = 28;
height_offset = 5;

inner_radius = 7;
center_hole_offset = 9;

hole_radius = 2;

hole_x_dist = 30;
hole_y_dist = 15;

plate_width = 40;
plate_depth = 25;
plate_height = 8;

thruster_radius = 48;

mounting_plate_size = 80;
mounting_plate_depth = 5;
mounting_plate_hole_radius = 4.25;

button_length = 15;
button_radius = 6.5;
button_offset = 40;


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
    
    union(){
        translate([plate_depth / 2, 0, -height / 2 + height_offset])
        rounded_cube(width, length, height, corner_radius);
        
        // Mounting plate

        difference(){
        translate([length + mounting_plate_depth * 1.5, -mounting_plate_size / 2, -mounting_plate_size / 2 + height_offset])
        cube([mounting_plate_depth, mounting_plate_size, mounting_plate_size]);
            
            hole_spacing = mounting_plate_size - 20;
            
            translate([length + mounting_plate_depth * 1.5, 0, height_offset])
            rotate([0, 90, 0])
            corner_holes(hole_spacing, hole_spacing, mounting_plate_hole_radius, mounting_plate_depth * 2);
        }
    }
    
    // Thruster
    translate([0, 0, -thruster_radius - plate_height / 2 + 1.75])
    rotate([90, 0, 0])
    cylinder(width, thruster_radius, thruster_radius, center=true);
    
    // Center hole
    translate([plate_depth / 2, 0, height - plate_height - center_hole_offset])
    rotate([0, 90, 0])
    cylinder(h = length + mounting_plate_depth, r = inner_radius);
    
    // Button
    translate([length + plate_depth / 2 - button_offset, 0, -height/2 + button_length/2 + height_offset])
    cylinder(h = button_length, r = button_radius, center=true);
}





