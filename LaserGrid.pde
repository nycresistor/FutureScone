class LaserGrid {
  int step = 0;
  
  public void draw() {
    stroke(255,100,100);

    for (int i=-width*2; i<width*4; i+=width/5) {
      line(i, height,0,i,height, -600);
    }
    
    for (int i=step; i<600; i+=60) {
      line(-width*2, height, -i, width*4, height, -i);
    }
    
    step += 1;
    if (step > 60) step = 0;
  }
}

