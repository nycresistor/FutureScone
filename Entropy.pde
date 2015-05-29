public class Entropy {
  float step = 0;
  float ent = 0.25;
  
  public Entropy() {
    this.ent = 0.25;
  }
  
  public Entropy(float ent) {
    this.ent = ent;
  }
  
  public float get() {
      step += 0.01;
      return constrain(random(1) + 0.5, 1-ent, 1+ent);
      //return constrain(noise(step) + 0.5, 1-ent, 1+ent);
  }
}

