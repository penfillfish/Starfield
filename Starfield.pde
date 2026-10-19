boolean[] direction = {false,false,false,false};
Human person;
int Width = 1000;
int Height = 1000;
ArrayList<Particle> asteroids = new ArrayList<Particle>();
ArrayList<OddballParticle> stars = new ArrayList<OddballParticle>();
int score = 0;
void setup()
{
  size(1000,1000);
  person = new Human();
  asteroids = new ArrayList<Particle>();
  stars = new ArrayList<OddballParticle>();
  score = 0;
}

void generate(){
  asteroids.add(new Particle());
  if(Math.random()<0.01){
    stars.add(new OddballParticle());
  }
}

void draw()
{
  background(0);
  generate();
  person.move();
  for(int i=asteroids.size()-1;i>=0;i--){
    if(asteroids.get(i).isOutOfBounds()){
      asteroids.remove(i);
    } else{
      asteroids.get(i).move();
    }
  }
  for(int i=stars.size()-1;i>=0;i--){
    if(stars.get(i).isOutOfBounds()){
      stars.remove(i);
    } else{
      stars.get(i).move();
    }
  }
}

class Particle
{
  float angle,speed;
  PVector pos,vel;
  Particle(){
    angle = (float)(Math.random()*(2*Math.PI));
    speed = (float)(Math.random()*10);
    pos = new PVector(Width/2,Height/2);
    vel = new PVector(cos(angle),sin(angle));
    vel.mult(speed);
  }
  void move(){
    pos.add(vel);
    show();
  }
  void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    fill(81,81,85);
    ellipse(0,0,10,10);
    popMatrix();
  }
  boolean isOutOfBounds(){
    return pos.x<0||pos.y<0||pos.x>Width||pos.y>Height;
  }
}

class OddballParticle extends Particle
{
  OddballParticle(){
    angle = (float)(Math.random()*(2*Math.PI));
    speed = (float)(Math.random()*5);
    pos = new PVector(Width/2,Height/2);
    vel = new PVector(cos(angle),sin(angle));
    vel.mult(speed);
  }
  void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    fill(253,204,13);
    popMatrix();
  }
}

class Human{
  PVector vel,pos;
  float acceleration = 0.5;
  float friction = 0.99;
  int maxSpeed = 20;
  Human(){
    vel = new PVector(0,0);
    pos = new PVector(Width/2,Height/2);
  }
  void move(){
    if(direction[0]) vel.y-=acceleration;
    if(direction[1]) vel.x-=acceleration;
    if(direction[2]) vel.y+=acceleration;
    if(direction[3]) vel.x+=acceleration;
    vel.limit(maxSpeed);
    vel.mult(friction);     
    pos.add(vel);
    person.show();
  }
  void show(){
    fill(255);
    pos.x = constrain(pos.x,10,Width-10);
    pos.y = constrain(pos.y,10,Height-10);     
    ellipse(pos.x,pos.y,20,20);
  }
}
 
void keyPressed(){
  if(key=='w') direction[0]=true;
  if(key=='a') direction[1]=true;
  if(key=='s') direction[2]=true;
  if(key=='d') direction[3]=true;
}
 
void keyReleased(){
  if(key=='w') direction[0]=false;
  if(key=='a') direction[1]=false;
  if(key=='s') direction[2]=false;
  if(key=='d') direction[3]=false;
}
