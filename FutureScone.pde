import java.nio.file.*;

Scone scone;
LaserGrid grid;
TotuClient totu;
PFont font;
PFont fontSmall;
String path;
int screen = 0;
int loop = 30;

void setup() {
  size(240,320,P3D);
  
  grid = new LaserGrid();
  font = loadFont("HydrogenWhiskey-Regular-32.vlw");
  fontSmall = loadFont("HydrogenWhiskey-Regular-24.vlw");
  findPath();
  
  //totu = new TotuClient(this, "192.168.1.251", 9000, false);
}

void findPath() {
  int i=0;
  File f;
  
  do {
    path = dataPath("run" + i);
    f = new File(path);
    i++;
  } 
  while (f.exists());
  
  f.mkdirs();
  println("Saving to " + path);
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
  screen++;
  if (screen > 31) {
    screen = 0;
    findPath();
  }
}

String zp(int n) {
  return n<10 ? "0" + n : "" + n;
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

  
  int f = (frameCount-1) % loop;
  String fp = path + "/" + zp(f) + "-" + (screen < 16 ? "A" + zp(screen) : "B" + zp(screen-16)) + ".png";
  saveFrame(fp);
  println("Saved to '"+fp+"'");
  

 // totu.sendDataNormal(0xFFFF,-90);
}

