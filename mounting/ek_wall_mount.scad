// this is an alternative mount for the EK Kinetic TBE D5
include <nutsnbolts/cyl_head_bolt.scad>;

$fn=64;
// that's the diameter with the rubber anti-vibration sleeve
cylinder_diameter=70;
// that's the height of the cutout in the rubber
cylinder_height=22;
wall_thickness=5;

module screw_protrusion() {
  difference() {

    hull() {
      // side points for the wall mount
      translate([cylinder_diameter,cylinder_diameter/2,0])
        cylinder(h=cylinder_height, r=2, center=true);
      translate([cylinder_diameter*-1,cylinder_diameter/2,0])
        cylinder(h=cylinder_height, r=2, center=true);

      // main cylinder
      cylinder(h=cylinder_height, r=cylinder_diameter/2+wall_thickness/2, center=true);

      // side "bosses" for screws to connect the halves
      translate([cylinder_diameter/2+5, 0, 0]) cylinder(h=cylinder_height, r=6, center=true);
      translate([cylinder_diameter/-2-5, 0, 0]) cylinder(h=cylinder_height, r=6, center=true);
    }

    // wall mount screw cutouts
    for(x_pos = [cylinder_diameter-5, -cylinder_diameter+5]) {
      translate([x_pos, cylinder_diameter/2-18, 0]) rotate([90, 0, 0]) {
        hole_through(name="M4", l=60, h=14);
      }
    }

    // main hole with the diameter of the pump + rubber sleeve
    cylinder(h=cylinder_height+2, r=cylinder_diameter/2, center=true);

    for(x_pos = [cylinder_diameter/2+5, -cylinder_diameter/2-5]) {
      translate([x_pos, -15, 0]) rotate([90, 0, 0]) {
        hole_through(name="M3", l=60, h=10);

        translate([0, 0, -17])
          rotate([0,0,90])
          nutcatch_sidecut(name="M3");
      }
    }
  }
}

// now cut the object at the x-axis by creating two copies where half of each
// is missing

split_offset = 10; // distance for moving the split parts apart

// front half (y > 0)
translate([0, split_offset, 0])
intersection() {
    screw_protrusion();
    // a huge cube covering the positive y space
    translate([-100, 0, -50]) cube([200, 100, 100]);
}

// back half (y < 0)
translate([0, -split_offset, 0])
difference() {
    screw_protrusion();
    // and the same cube again for the negative y space
    translate([-100, 0, -50]) cube([200, 100, 100]);
}
