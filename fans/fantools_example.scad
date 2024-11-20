include <fantools.scad>

height=20;
fan_corner_support();
translate([0,30,0])fan_corner();
translate([0,60,0])fan_side_support(hole_offset=7);
