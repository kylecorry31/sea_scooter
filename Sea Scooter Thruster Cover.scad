$fn=50;

spacing = 8;
radius = 47.25;
thickness = 2;

// Front: 20, Back: 68
height = 68;

draw_side_screws = true;
side_scew_radius = 2.5;
side_scew_height_offset = height - 19;

// Horizontal bar
translate([-radius + thickness / 2, -thickness/2, 0])
cube([radius * 2 - thickness, thickness, thickness]);

// Vertical bar
translate([-thickness/2, -radius + thickness / 2, 0])
cube([thickness, radius * 2 - thickness, thickness]);

// Inner circles
for(i = [spacing:spacing + thickness:radius]){
    difference(){
        cylinder(thickness, i , i);
        cylinder(thickness, i - thickness, i - thickness);
    }
}

// Outer cylinder
difference(){
    cylinder(height, radius, radius);
    cylinder(height, radius - thickness, radius - thickness);
    
    translate([radius-5,-12,thickness])
    cube([10, 24, height - thickness]);
    
    if (draw_side_screws){
        // Screw holes
        for (i = [90:90:270]){
            rotate([0, 0, i])
            translate([radius-thickness/2,thickness/2,side_scew_height_offset])
            rotate([0, 90, 0])
            cylinder(h = thickness * 2, r = side_scew_radius, center=true);
        }
    }
}