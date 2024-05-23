inner_diameter=32;
outer_diameter=34.6;
rim_height=1.2;
rim_width=1.6;
adapter_height=30;
$fn=50;

difference(){
  cylinder(h=rim_height,r=outer_diameter/2+rim_width);
  cylinder(h=rim_height,r=inner_diameter/2);
}

translate([0,0,rim_height]){
  difference(){
    cylinder(h=adapter_height,r=outer_diameter/2);
    cylinder(h=adapter_height,r=inner_diameter/2);
  }
}
