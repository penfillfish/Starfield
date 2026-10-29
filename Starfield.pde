boolean[] direction = {false,false,false,false};
int Width = 1000;
int Height = 1000;
ArrayList<Particle> asteroids = new ArrayList<Particle>();
ArrayList<OddballParticle> stars = new ArrayList<OddballParticle>();
int score = 0;
PVector velocity = new PVector(0,0);
float acceleration = 0.01;
float friction = 0.99;
int maxSpeed = 10;
int blinkTimer =0;
int blinkDuration =30;
void setup()
{
  size(1000,1000);
  asteroids = new ArrayList<Particle>();
  stars = new ArrayList<OddballParticle>();
  background(0);
}

void generate(){
  if(Math.random()<0.9){
    asteroids.add(new Particle());
  }
  if(Math.random()<0.01){
    stars.add(new OddballParticle());
  }
}

void draw()
{
  fill(0, 70);
  rect(0,0,width,height);
  generate();
  move();
  float num;
  for(int i=asteroids.size()-1;i>=0;i--){
    Particle a = asteroids.get(i);
    if(a.isOutOfBounds()){
      if(a.bounces>0&&velocity!= new PVector(0,0)){
        a.bounce();
      }else{asteroids.remove(i);}
    }else{
      a.vel.add(velocity);
      a.move();
    }
  }
  for(int i=stars.size()-1;i>=0;i--){
    OddballParticle s = stars.get(i);
    if(s.isOutOfBounds()){
      if(s.bounces>0&&velocity!= new PVector(0,0)){
        s.bounce();
      }else{stars.remove(i);}
    } else{
      s.vel.add(velocity);
      s.move();
    }
  }
  if(mousePressed){
    blinkTimer++;
    float progress = map(blinkTimer, 0, blinkDuration, 0, PI);
    num = sin(progress);
    for(Particle a:asteroids){
      a.pos.y+=(Height/2-a.pos.y)*0.85*num;
    }
    for(Particle s:stars){
      s.pos.y+=(Height/2-s.pos.y)*0.85*num;
    }
  }else{
    blinkTimer =0;
  }
}

void move(){
  if(direction[0]) velocity.y-=acceleration;
  if(direction[1]) velocity.x-=acceleration;
  if(direction[2]) velocity.y+=acceleration;   
  if(direction[3]) velocity.x+=acceleration;
  velocity.limit(maxSpeed);
  velocity.mult(friction);
}

class Particle
{
  int bounces;
  float angle,speed,size,distance;
  PVector pos,vel;
  Particle(){
    bounces = 2;
    angle = (float)(Math.random()*(2*Math.PI));
    speed = (float)(Math.random()*10)+5;
    size = 0;
    distance = 0.0;
    pos = new PVector(Width/2,Height/2);
    vel = new PVector(cos(angle),sin(angle));
    vel.mult(speed);
  }
  void move(){
    pos.add(vel);
    if(bounces!=2){pos.lerp(new PVector(Width/2,Height/2),0.04);}
    distance = dist(pos.x,pos.y,Width/2,Height/2);
    size = distance*0.03;
    speed -= 0.01*distance;
    show();
  }
  void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    fill(81,81,85);
    ellipse(0,0,size,size);
    popMatrix();
  }
  boolean isOutOfBounds(){
    return pos.x<0||pos.y<0||pos.x>Width||pos.y>Height;
  }
  void bounce(){
    if(pos.x<0){
      pos.x=0;
      vel.x*=-1;
    }else if(pos.x>Width){
      pos.x=Width;
      vel.x*=-1;
    }
    if(pos.y<0){
      pos.y=0;
      vel.y*=-1;
    }else if(pos.y>Height){
      pos.y=Height;
      vel.y*=-1;
    }
    bounces--;
  }
}

class OddballParticle extends Particle
{
  OddballParticle(){
    bounces = 8;
    angle = (float)(Math.random()*(2*Math.PI));
    speed = (float)(Math.random()*5)+5;
    size = 10;
    distance = 0.0;
    pos = new PVector(Width/2,Height/2);
    vel = new PVector(cos(angle),sin(angle));
    vel.mult(speed);
  }
  void show(){
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    fill(253,204,13);
    ellipse(0,0,size,size);
    popMatrix();
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
