// this is the diameter of the outside of the fan casing for calculating
// the curvature in the bracket. Approximation is sufficent.
outer_fan_diameter=130;
// the inner spacing of the fan, i.e., where the bracket goes. So, height of
// the bracket.
inner_height=28;
// generate extra screw holes. Those can be used for screwing the fan stack
// into something as well as screwing something into the side of the fan stack.
// Disabling this might speed up prints a little bit.
screw_holes=true;
// number of fans to connect together. 1 just
mount_points=2;
// diameter of the fan screws. This should work with pretty much any fan srews.
fan_screw_diameter=4.5;
// diameter of the mounting holes. Enlarge to 4.5 if you want to use fan screws.
screw_diameter=4;

$fn=30;


module copy_mirror(vec=[0,1,0])
{
    children();
    mirror(vec) children();
}

module fan_bracket(){
  difference(){
    linear_extrude(inner_height){
      difference(){
        square(size=[30,30], center = false);
        translate([6.8, 6.8]){
          circle(d=fan_screw_diameter);
        }
        translate([60, 60]){
          circle(d=outer_fan_diameter);
        }
        translate([15, 15]){
          rotate([0, 0, -45]){
            square(size=[2, 10], center=true);
          }
        }
      }
    }
    if (screw_holes==true){
      translate([0,0,inner_height/2]){
        translate([25,0,0]){
          rotate([-90,0,0]){
            cylinder(h=10, d=screw_diameter);
          }
        }
        translate([0,25,0]){
          rotate([0,90,0]){
            cylinder(h=10, d=screw_diameter);
          }
        }
      }
    }
  }
}

fan_bracket();
if (mount_points>=2){
  copy_mirror([1, 0, 0]){fan_bracket();}
}
if (mount_points>=3){
  copy_mirror([1, 1, 0]){fan_bracket();}
}
if (mount_points>=4){
  copy_mirror([0, 1, 0]){fan_bracket();}
}
