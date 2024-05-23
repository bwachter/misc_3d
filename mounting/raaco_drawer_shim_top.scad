length = 185;
width = 19/2;
height = 3;


difference(){
  cube([length, width, height]);
  linear_extrude(height){
    // small cutout to compensate for rounded edges
    polygon(points=[[0,0],[2,0],[0,2]],paths=[[0,1,2]]);
  }
}
