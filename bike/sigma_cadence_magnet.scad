$fn=50;


magnet_height=8;

screw_diameter=2.9;
magnet_diameter=20;
wall_thickness=3;
screw_head_height=3;
screw_head_diameter=5.25;
ziptie_width=2.6;
ziptie_depth=1.4;


screw_head_radius=screw_head_diameter/2;
magnet_radius=magnet_diameter/2;
screw_radius=screw_diameter/2;




module ziptie_side_cutout(top_height, top_cutout=false){
  translate([magnet_radius+wall_thickness-2,magnet_radius+screw_radius/2+wall_thickness,0]){
    cube([ziptie_depth,ziptie_width,top_height]);
    translate([(magnet_diameter+wall_thickness)*-1,0,0])
      cube([ziptie_depth,ziptie_width,top_height]);
    if (top_cutout)
      translate([(magnet_diameter+wall_thickness)*-1,0,top_height-ziptie_depth])
        cube([magnet_diameter+wall_thickness,ziptie_width,top_height]);
  }
}

module screw_cutout(top_height, with_screwheads=false){
    cylinder(h=top_height, r=screw_radius);
    if (with_screwheads)
      translate([0,0,top_height-screw_head_height])
        cylinder(h=screw_head_height, r=screw_head_radius);
    translate([0,magnet_diameter+screw_diameter+wall_thickness*2,0]){
      cylinder(h=top_height, r=screw_radius);
      if (with_screwheads)
        translate([0,0,top_height-screw_head_height])
          cylinder(h=screw_head_height, r=screw_head_radius);
    }
}

module cover_plate(with_magnet=true, with_screwheads=true, with_ziptie=true, top_height=10){
  difference(){
    hull(){
      cylinder(h=top_height, r=screw_radius+wall_thickness/2);
      translate([0,magnet_radius+screw_radius+wall_thickness,0])
        cylinder(h=top_height, r=magnet_radius+wall_thickness/2);
      translate([0,magnet_diameter+screw_diameter+wall_thickness*2,0]){
        cylinder(h=top_height, r=screw_radius+wall_thickness/2);
      }
    }
    screw_cutout(top_height, with_screwheads);
    if (with_magnet)
      translate([0,magnet_radius+screw_radius+wall_thickness,0])
        cylinder(h=magnet_height, r=magnet_radius);
    if (with_ziptie){
      ziptie_side_cutout(top_height, true);
    }
  }
}

cover_plate();

pedal_insert_width=15;
pedal_insert_height=6;
pedal_insert_top_height=8;

translate([50,50,0]){
  difference(){
    hull(){
      // From here...
      translate([pedal_insert_width/2*-1,magnet_radius-screw_radius-wall_thickness/2,0])
        cube([pedal_insert_width, magnet_diameter-5, pedal_insert_height]);
      // .. to here do whatever you need to get it fit your pedal, and has the
      // correct height
      translate([0,0,pedal_insert_height]){
        cover_plate(with_magnet=false, with_screwheads=false, top_height=pedal_insert_top_height);
      }
    }
    ziptie_side_cutout(pedal_insert_top_height+pedal_insert_height);
    translate([0,0,pedal_insert_height]){
      screw_cutout(10, false);
    }
  }
}
