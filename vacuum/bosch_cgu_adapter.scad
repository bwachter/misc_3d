tool_inner_diameter=26.4;
wall_thickness=3;
extrusion_thickness=1.6;
extrusion_width=4.5;
extrusion_height=8;
overshoot=1;
tool_height=30;
connection_height=6;
adapter_height=30;
adapter_inner_diameter=31;

$fn=50;

difference(){
  cylinder(h=tool_height,r=tool_inner_diameter/2+wall_thickness);
  cylinder(h=tool_height+overshoot,r=tool_inner_diameter/2);
  translate([tool_inner_diameter/2-overshoot,extrusion_width/2*-1,0])
    cube([extrusion_thickness+overshoot,extrusion_width,extrusion_height]);
  translate([(tool_inner_diameter/2+extrusion_thickness)*-1,extrusion_width/2*-1,0])
    cube([extrusion_thickness+overshoot,extrusion_width,extrusion_height]);
}

translate([0,0,tool_height]){
  difference(){
    cylinder(h=connection_height,r1=tool_inner_diameter/2+wall_thickness,r2=adapter_inner_diameter/2+wall_thickness);
    cylinder(h=connection_height,r1=tool_inner_diameter/2,r2=adapter_inner_diameter/2);
  }
}


translate([0,0,tool_height+connection_height]){
  difference(){
    cylinder(h=adapter_height,r=adapter_inner_diameter/2+wall_thickness);
    cylinder(h=adapter_height,r=adapter_inner_diameter/2);
  }
}
