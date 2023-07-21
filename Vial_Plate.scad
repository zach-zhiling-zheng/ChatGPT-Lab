// Parameters
footprint_length = 127.76;
footprint_width = 85.48;
plate_thickness = 20;
hole_depth = 10;
tube_diameter = 28;
x_spacing = 30;
y_spacing = 40;
x_offset = 19;
y_offset = 23;
rows = 2;
columns = 4;

// Plate
difference() {
    cube([footprint_length, footprint_width, plate_thickness]);

    // Holes
    for (row = [0:rows-1]) {
        for (col = [0:columns-1]) {
            translate([x_offset + col*x_spacing, y_offset + row*y_spacing, plate_thickness - hole_depth]) {
                cylinder(d=tube_diameter, h=hole_depth+plate_thickness, $fn=100);
            }
        }
    }
}
