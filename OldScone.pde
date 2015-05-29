class OldScone {
  int sides;
  float[] topVerts;
  float[] botVerts;
  float h;
  PImage topTexture;
  PImage midTexture;
  
  public OldScone(int sides, float r1, float r2, float h, float ent) {
    
    r1 = min(r1,r2);
    r2 = max(r1,r2);
    sides = sides/2*2;
    
    Entropy entropy = new Entropy(ent);
    this.topVerts = new float[(sides+1)*3];
    this.botVerts = new float[(sides+1)*3];
    this.h = h;
    this.sides = sides;

    float angle = 360 / sides;
    

    for (int i=0; i<sides+1; i++) {
        float x = cos(radians(i*angle))* r1 * entropy.get();
        float y = sin(radians(i*angle))* r1 * entropy.get();
        float z = h/2 * entropy.get(); 
        topVerts[i*3] = x;
        topVerts[i*3+1] = y;
        topVerts[i*3+2] = z;
    }
    for (int i=0; i<sides+1; i++) {
        float x = cos(radians(i*angle)) * r2 * entropy.get();
        float y = sin(radians(i*angle)) * r2 * entropy.get();
        float z = -h/2 * entropy.get();
        botVerts[i*3] = x;
        botVerts[i*3+1] = y;
        botVerts[i*3+2] = z;
    }
    
    topTexture = loadImage("top2.jpg");
    midTexture = loadImage("mid1.jpg");
  }

  public OldScone() {
    this(int(20+random(20)), 30+random(50), 30+random(50), 30+random(10), 0.05);
  }
  
  void draw() {
    noStroke();
    beginShape();
    textureWrap(REPEAT);
    texture(topTexture);

    for (int i=0; i<sides; i++) {
        vertex(topVerts[i*3], topVerts[i*3+1], topVerts[i*3+2], topVerts[i*3], topVerts[i*3+1]);
    }
    endShape(CLOSE);

    beginShape();
    textureWrap(REPEAT);
    texture(topTexture);

    for (int i=0; i<sides; i++) {
        vertex(botVerts[i*3], botVerts[i*3+1], botVerts[i*3+2], botVerts[i*3], botVerts[i*3+1]);
    }
    endShape(CLOSE);

    beginShape(TRIANGLE_STRIP);
    textureWrap(REPEAT);
    texture(midTexture);

    for (int i=0; i<sides+1; i++) {
        vertex(topVerts[i*3], topVerts[i*3+1], topVerts[i*3+2], topVerts[i*3], 0);
        vertex(botVerts[i*3], botVerts[i*3+1], botVerts[i*3+2], botVerts[i*3], h);
    }
    vertex(topVerts[0], topVerts[1], topVerts[2], topVerts[0],0);
    vertex(botVerts[0], botVerts[1], botVerts[2], topVerts[0],0);
    
    endShape(CLOSE);
  }
}

