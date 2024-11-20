module fan_corner(height=40, screw_height=26, screw_diameter=3.4, screw_head_diameter=7.8, hole_offset=5, outside_wall_length=25, inner_cutout_r=22, fan_mounts=false){
  difference(){
    linear_extrude(height=height){
      polygon(points=[[0,0],[outside_wall_length,0],[0,outside_wall_length]], paths=[[0,1,2]],convexity=10);
    }
    translate([hole_offset, hole_offset, 0]){
      cylinder(r=screw_diameter/2,h=screw_height);
      translate([0,0,screw_height]){
        cylinder(r=screw_head_diameter/2,height-screw_height);
      }
    }
    translate([outside_wall_length,outside_wall_length,0]){
      cylinder(r=inner_cutout_r,h=height);
    }
  }
  if (fan_mounts == true){
    translate([hole_offset, hole_offset, -4]){
      cylinder(r=2.2,h=6);
    }
  }
}

// this builds supports for one corner with a wall section to the
// middle of the radiator
module fan_corner_support(height=40, screw_height=26, screw_diameter=3.4, screw_head_diameter=7.8, hole_offset=5, hole_distance=136, outside_wall_length=25, wall_width=3, inner_cutout_r=22){
  fan_corner(height, screw_height, screw_diameter, screw_head_diameter, hole_offset, outside_wall_length, inner_cutout_r);
  translate([hole_offset+screw_head_diameter,0,0]){
    linear_extrude(height=height){
      square(size=[hole_distance/2-hole_offset-screw_head_diameter,wall_width], center=false);
    }
  }
}

// this just mirrors and moves a second corner support, generating a full
// leg mountable on two corners with a thin wall, suitable for the legs
// left and right of the radiator
module fan_side_support(height=40, screw_height=26, screw_diameter=3.4, screw_head_diameter=7.8, hole_offset=5, hole_distance=136, outside_wall_length=25, wall_width=3, inner_cutout_r=22){
  fan_corner_support(height, screw_height, screw_diameter, screw_head_diameter, hole_offset, hole_distance, outside_wall_length, wall_width, inner_cutout_r);

  translate([hole_distance,0,0]){
    mirror([1,0,0]){fan_corner_support(height, screw_height, screw_diameter, screw_head_diameter, hole_offset, hole_distance, outside_wall_length, wall_width, inner_cutout_r);}
  }
}
