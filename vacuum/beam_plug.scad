module hollow_cylinder(d, h, w){
  difference(){
    cylinder(d=d, h=h);
    cylinder(d=d-w*2, h=h);
  }
}

hollow_cylinder(d=15, h=3, w=1);
