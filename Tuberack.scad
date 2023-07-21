// Parameters
plate_thickness = 12;
post_thickness = 12;
post_height = 70;  // adjusted to 70
tube_radius = 15.5;  // adjusted to 15.5
hole_depth = 4;  // depth to dig into the bottom plate for the tube to sit
plate_x_length = 85.48;
plate_y_length = 127.76;
lift_amount = 10;  // new parameter to control the lift amount
drill_radius_increase = 3;  // new parameter to control the radius increase of the drilled sphere
text_size = 15;  // size of the text
text_depth = 4;  // depth of the text increased to 4

// Derived parameters
x_gap = (plate_x_length - 2 * 2 * tube_radius) / 3;
y_gap = (plate_y_length - 2 * 3 * tube_radius) / 4;

// Create the bottom plate with tube holes
difference() {
    // Bottom plate
    translate([0, 0, 0])
    cube([plate_x_length, plate_y_length, plate_thickness]);

    // Tube holes
    for (x=[x_gap + tube_radius, 2*x_gap + 3*tube_radius]) {
        for (y=[y_gap + tube_radius, 2*y_gap + 3*tube_radius, 3*y_gap + 5*tube_radius]) {
            translate([x, y, plate_thickness + hole_depth + lift_amount])  // Lift the sphere
            rotate([180,0,0])
            sphere(r=tube_radius + drill_radius_increase);  // Create a half-sphere shape with increased radius
        }
    }

    // Text to be engraved
    translate([plate_x_length / 2, plate_y_length / 2, -text_depth])
    rotate([0,0,90])
    mirror([0,1,0])
    linear_extrude(height = text_depth+4)
    text("Yaghi Lab", size = text_size, halign = "center", valign = "center");
}

// Create the four corner posts
for (x=[0 : plate_x_length - post_thickness : plate_x_length - post_thickness]) {
    for (y=[0 : plate_y_length - post_thickness : plate_y_length - post_thickness]) {
        translate([x, y, plate_thickness])
        cube([post_thickness, post_thickness, post_height]);
    }
}

// Create the top plate with tube slots
difference() {
    // Top plate
    translate([0, 0, post_height + plate_thickness])
    cube([plate_x_length, plate_y_length, plate_thickness]);

    // Tube slots
    for (x=[x_gap + tube_radius, 2*x_gap + 3*tube_radius]) {
        for (y=[y_gap + tube_radius, 2*y_gap + 3*tube_radius, 3*y_gap + 5*tube_radius]) {
            translate([x, y, post_height + 2*plate_thickness -6])
            cylinder(h=plate_thickness + 6, r=tube_radius, center=true); 
        }
    }
}
