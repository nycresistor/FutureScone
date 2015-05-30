class LaserGrid {
  int step = 0;
  
  public void draw() {
    pushMatrix();
   
    fill(0);
    translate(0, 60, -500);
    rect(-1000, height / 2, width * 100, height * 2);
    popMatrix();
    
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

