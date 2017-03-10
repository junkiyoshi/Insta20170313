import de.voidplus.leapmotion.*;

ArrayList<Tower> towers;
float _power;

LeapMotion leap;

void setup()
{
  size(800, 800, P3D);
  frameRate(30);
  colorMode(HSB);
  
  towers = new ArrayList<Tower>();
  for(int x = 0; x < width; x += 25)
  {
    for(int z = 0; z < height; z += 25)
    {
      towers.add(new Tower(x, 0, z, 20, 20));
    }
  }
  
  leap = new LeapMotion(this);
  _power = 80;
}

void draw()
{
  PVector target = new PVector(-10000, -10000, 0);
  
  for(Hand hand : leap.getHands())
  {
    if(hand.isRight())
    {
      Finger index = hand.getIndexFinger();
      
      target = index.getPosition().copy();
    }
  }
  
  println(target.x + ", " + target.y);
  
  background(255);
  
  camera(width / 2, -height, 800, 
         width / 2, 0, height / 2, 
         0, 1, 0);
  
  for(Tower t : towers)
  {
    t.addHeight(target.x, target.y);
    t.update();
    t.display();
  }
}