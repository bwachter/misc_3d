height=6;
diameter=42;
hole_diameter=6;

$fn=32;

difference(){
  cylinder(h=height,r=diameter/2);
  cylinder(h=height,r=hole_diameter/2);
}
