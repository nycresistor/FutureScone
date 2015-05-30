import java.nio.file.*;

Scone scone;
LaserGrid grid;
TotuClient totu;
PFont font;
PFont fontSmall;
int loop = 30;

/* CORRECT 251 */
//int rotations[] = new int[] {    
//  -90,-90,-90,-90,-90,-90,-90,90,90,90,90,90,90,90,-90,90,
//   90,90,90,90,-90,-90,-90,-90,90,90,90,-90,-90,-90,-90,90
//}; 

/* CORRECT 250 */
int rotations[] = new int[] {    
  -90,-90,90,90,-90,-90,90,90,90,90,90,-90,-90,-90,-90,90,
   90,90,90,90,-90,-90,-90,-90,90,-90,90,90,90,90,-90,90
}; 


void setup() {
  size(240,320,P3D);
  
  grid = new LaserGrid();
  font = loadFont("HydrogenWhiskey-Regular-32.vlw");
  fontSmall = loadFont("HydrogenWhiskey-Regular-24.vlw");
  
  totu = new TotuClient(this, "192.168.1.251", 9000, TotuClient.SAVE);
}


float r = 0;
float r2 = 1;
float r2s = 1/50.0;
int c = 50;
int cs = 1;

void reset() {
  scone = new Scone();
  r = 0;
  r2 = 1;
  r2s = 1.0/(loop/2);
  c = 50;
  cs = 1;
//  screen++;
//  if (screen > 31) {
//    screen = 0;
//  }
}


void draw() {

  if ((frameCount-1) % loop == 0) {
    reset();
  }


  background(0);  
  fill(255);
  lights();

  grid.draw();
  
  pushMatrix();
  translate(width/2,height/2,50);
  rotateX(r2);
  rotateZ(r);
  scone.draw();
  popMatrix();
  
  r=r + TWO_PI/loop;
  r2=r2+r2s;
  if (frameCount % loop == loop/2 || frameCount % loop == 0) 
    r2s = -r2s;

  textAlign(CENTER, TOP);
  textFont(font);

  c += cs;
  if (c <= 50 || c >= 100) cs = -cs;  
  fill(255,c,c);
  text("FUTURE SCONE", width/2, 10);
  
  textFont(fontSmall);
  text("1984", width/2, 42);

  int screen = frameCount % 32;
  int mask = 0;
  if (screen > 15) {
    mask = 0x10000 | (1<<(screen-16));
  }
  else  {
    mask = 1<<screen;
  }

  //textFont(font);
  //text(screen, width/2, 100);
  
  //println(screen);
  //totu.sendData(mask, rotations[screen]);
   
}

