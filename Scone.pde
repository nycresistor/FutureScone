class Scone {
  int levels;
  int sides;
  float[] verts;
  float h;
  PImage topTexture;
  PImage midTexture;
  
  public Scone(int levels, int sides, float r1, float r2, float h, float ent) {
    
    r1 = min(r1,r2);
    r2 = max(r1,r2);
    sides = sides/2*2;
    
    Entropy entropy = new Entropy(ent);
    this.verts = new float[levels*sides*3];
    this.h = h;
    this.sides = sides;
    this.levels = levels;

    float angle = 360 / sides;
    
    for (int i=0; i<levels; i++) {
      for (int j=0; j<sides; j++) {
        int idx = (i*sides+j)*3;
        float r = r1 + (r2-r1) * sin(PI*i/levels);
        float x = cos(radians(j*angle))* r * entropy.get();
        float y = sin(radians(j*angle))* r * entropy.get();
        float z = (h/2 - h/levels * i) * entropy.get(); 

        verts[idx] = x;
        verts[idx+1] = y;
        verts[idx+2] = z;
      }
    }
    
    topTexture = loadImage("top2.jpg");
    midTexture = loadImage("mid2.jpg");
  }

  public Scone() {
    this(10,int(20+random(20)), 20+random(20), 30+random(20), 20+random(20), 0.05);
  }
  
  void draw() {
    int i,j,k,t,b;
    
    noStroke();
    
    // TOP
    beginShape();
    textureWrap(REPEAT);
    texture(topTexture);
    for (i=0; i<sides*3; i+=3) {      
        vertex(verts[i], verts[i+1], verts[i+2], verts[i], verts[i+1]);
    }
    endShape(CLOSE);

    // BOTTOM
    beginShape();
    textureWrap(REPEAT);
    texture(topTexture);
    for (i=(levels-1)*sides*3; i<verts.length-2; i+=3) {
        vertex(verts[i], verts[i+1], verts[i+2], verts[i], verts[i+1]);
    }
    endShape(CLOSE);

    // SIDES   
    beginShape(TRIANGLE_STRIP);
    textureWrap(REPEAT);
    texture(midTexture);
    for (i=0; i<levels-1; i++) {
      // Do two extra sides to make sure we fill any holes
      for (j=0; j<sides+2; j++) {
        k = j<sides ? j : j-sides; 
        t = (i*sides+k)*3;
        b = ((i+1)*sides+k)*3;
        
        vertex(verts[t], verts[t+1], verts[t+2], verts[t], verts[t+2]);
        vertex(verts[b], verts[b+1], verts[b+2], verts[b], verts[b+2]);
      }
    }

//    vertex(topVerts[0], topVerts[1], topVerts[2], topVerts[0],0);
//    vertex(botVerts[0], botVerts[1], botVerts[2], topVerts[0],0);
    
    endShape(CLOSE);
  }
}

