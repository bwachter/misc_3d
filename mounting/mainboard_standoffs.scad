$fn=100;

standoff_diameter=8;
standoff_height=10;
pcb_height=2;
mounting_hole_diameter=4;
screw_diameter=3;

difference(){
  union(){
    cylinder(h=standoff_height,r=standoff_diameter/2);
    translate([0,0,standoff_height])
      cylinder(h=pcb_height,r=mounting_hole_diameter/2);
  }
  cylinder(h=standoff_height+pcb_height,r=screw_diameter/2);
}
