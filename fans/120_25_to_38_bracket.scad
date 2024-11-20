$fn=50;

include <fantools.scad>

translate([0,-119,0]) fan_side_support(hole_offset=7, hole_distance=119, height=13);
mirror([0,1,0]) fan_side_support(hole_offset=7, hole_distance=119, height=13);
rotate([0,0,270]) fan_side_support(hole_offset=7, hole_distance=119, height=13);
translate([119,0,0]) mirror([1,0,0]) rotate([0,0,270]) fan_side_support(hole_offset=7, hole_distance=119, height=13);
