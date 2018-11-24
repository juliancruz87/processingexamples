PImage mainTexture;
PShape moon;
PShape pillar;
PShape terrain;

float rotation;
float speedRot = 0.1;
float light = 0;
boolean autoRotate = true;
boolean showDecoration = true;

void setup()  
{
  size(1024, 768, P3D);
  setCameraPosition (false);
  loadDecoration ();
  noStroke();
}

void draw()  
{
  background(0);
  directionalLight(255, 255, 255, 50, -30, 0);
  lights(); 
  
  pushMatrix ();
    rotateZ(radians(-rotation*3));
    drawPyramid ();
    drawDecoration();
  popMatrix ();
  rotateCamera ();
}

void drawPyramid ()
{   
  setLight ();
  
  beginShape();
  texture(mainTexture);
  vertex(-100, -100, -100, 0,0);
  vertex(100, -100, -100, 512,0);
  vertex(100, 100, -100, 512,512);
  vertex(-100, 100, -100, 0,512);
  endShape();
  
  beginShape();
  texture(mainTexture);
  vertex(-100, -100, -100, 0, 0);
  vertex( 100, -100, -100, 512, 0);
  vertex(   0,    0,  100, 512/2, 512);
  endShape();
  
  beginShape();
  texture(mainTexture);
  vertex( 100, -100, -100, 0,0);
  vertex( 100,  100, -100, 512, 0);
  vertex(   0,    0,  100, 512/2, 512);
  endShape();
  
  beginShape();
  texture(mainTexture);
  vertex( 100, 100, -100, 0, 0);
  vertex(-100, 100, -100, 512, 0);
  vertex(   0,   0,  100, 512/2, 512);
  endShape();
  
  beginShape();
  texture(mainTexture);
  vertex(-100,  100, -100, 0, 0);
  vertex(-100, -100, -100, 512, 0);
  vertex(   0,    0,  100, 512/2, 512);
  endShape();
}

void drawDecoration ()
{
  if(!showDecoration)
    return;
    
  shape(pillar,0,0);
  shape(terrain,0,0);
  shape(moon, 0,0);
}

void setCameraPosition (boolean seeFromTop)
{
  beginCamera ();
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0); //set default camera according to the documentation
  translate(width/2, height/2, 0);
  if(!seeFromTop)
  {
    rotateX(PI/2);
    rotateZ(-PI/6);
  }
  endCamera ();
}

void rotateCamera ()
{
  if(autoRotate)
    rotation -= speedRot;
    
  if (!keyPressed) 
     return;
     
    if(keyCode == LEFT)
      rotation += speedRot;
    
    if(keyCode == RIGHT)
      rotation -= speedRot;
}

void loadDecoration ()
{
  mainTexture = loadImage("assets/pyramidTexture.png");
  terrain = loadShape("assets/terrain/dome.obj");
  terrain.rotateX(radians(90));
  terrain.scale(2);
  terrain.translate(0,0,-200);
  
  moon = loadShape("assets/moon/moon.obj");
  moon.translate (600,-600,300);
  
  pillar = loadShape("assets/pillar/Sand_Pillar.obj");
  pillar.scale (.15);
  pillar.rotateX(radians(70));
  pillar.translate (130,130,-120);
}

void setLight ()
{
  if(light == 0)
    directionalLight(0, 128, 0, 50, -30, 0);
  else if(light ==1)
    directionalLight(176, 0, 118, 50, -30, 0);
  else if(light ==2)
    directionalLight(255, 232, 160, 50, -30, 0);
  else if(light ==3)
    directionalLight(100, 100, 110, 50, -30, 0);
}

void keyPressed()
{
  if (key == 'f' || key == 'F') 
   setCameraPosition (false);
   
  if (key == 't' || key == 'T') 
   setCameraPosition (true);   
   
  if (key == 'r' || key == 'R') 
     autoRotate = !autoRotate; 
     
  if (key == 'd' || key == 'D') 
     showDecoration = !showDecoration;  
   
   if (key == '0') 
     light =0;
   if (key == '1') 
     light =1;
   if (key == '2') 
     light =2;
   if (key == '3') 
     light =4; 
}
