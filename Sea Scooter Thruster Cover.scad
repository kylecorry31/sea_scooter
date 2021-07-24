$fn=50;

spacing = 8;
radius = 46;
thickness = 2;
height = 20;

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
}