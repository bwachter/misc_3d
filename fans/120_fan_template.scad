$fn=50;

include <fantools.scad>

translate([119/2,-119/2,0]){
  difference(){
    cylinder(r=60, h=5);
    cylinder(r=59, h=5);
  }
}

translate([0,-119,0]) fan_side_support(hole_offset=7, hole_distance=119, height=2);
mirror([0,1,0]) fan_side_support(hole_offset=7, hole_distance=119, height=2);
rotate([0,0,270]) fan_side_support(hole_offset=7, hole_distance=119, height=2);
translate([119,0,0]) mirror([1,0,0]) rotate([0,0,270]) fan_side_support(hole_offset=7, hole_distance=119, height=2);
