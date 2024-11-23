outer_diameter = 51;
outer_height = 3.2;
rim_width = 3.2;
$fn=50;


module support_triangle(side_length, side_height){
  polygon(points=[[0,0],[0,side_length],[side_height,0]], paths=[[0,1,2]]);
}

module hollow_cylinder(d, h, w){
  difference(){
    cylinder(d=d, h=h);
    cylinder(d=d-w*2, h=h);
  }
}

module connector(length=7.6, width=3.4, wire_width=2.4){
  difference(){
    union(){
      rotate([90,0,90]){
        hollow_cylinder(d=length, h=width, w=wire_width);
      }
      translate([0,2,-2])
        cube([width,1.8,2]);
      translate([0,-3.8,-4]){
        cube([width,2,4]);
        translate([0,0,1]){
          cube([width,length,1]);
        }
        translate([0,2,0])
        rotate([180,-90,1])
          linear_extrude(width)
          support_triangle(8,7);
      }
    }

    // this one is straight down - which is problematic with the springs
    /*
    translate([0,length/-2+wire_width+0.5,0])
      cube([width, wire_width-1, 10]);
    */

    // angled cut - better with springs, harder to mount
    /*
    translate([0,length/-2+4,-1])
      rotate([35,0,0])
      cube([width+1, wire_width-1, 5]);
    */

    // angled cut - better with springs, harder to mount
    /*
    translate([0,length/-2+7,-1])
      rotate([90,0,0])
      cube([width+1, wire_width-1, 5]);
    */
  }


}

difference(){
  union(){
    cylinder(d=outer_diameter, h=outer_height);
    translate([-12.5,outer_diameter/2-3,0])
      cube([25,10,2]);
    translate([-12.5,outer_diameter/-2+-6,0])
      cube([25,11,2]);
  }
  translate([0,0,outer_height/2]){
    cylinder(d=outer_diameter-rim_width, h=outer_height/2);
  }
}

hollow_cylinder(d=13, h=8+outer_height, w=1);

// this helps pressing the lid better into the seal
hollow_cylinder(d=32.75, h=0.76+outer_height/2, w=3);

translate([9,outer_diameter/2+5.2,5]){
  connector();
}

translate([-12.4,outer_diameter/2+5.2,5]){
  connector();
}

// bar for tensioning the spring
translate([-10,outer_diameter/2+6.5,2]){
  cube([20,3,1]);
}

radius=2;
angles=[0,90];
points = [
    for(a = [angles[0]:1:angles[1]]) [radius * cos(a), radius * sin(a)]
];

translate([-12.5,32.5,2])
rotate([0,90,0])
linear_extrude(25)
polygon(concat([[0, 0]], points));
