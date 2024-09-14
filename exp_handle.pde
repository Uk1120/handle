Handle[] handles;
int barX, barY;
int barSize;
int tabSize;
int barInt;
int initialVal;
float min;
float max;

float a, b, c, d;

void setup() {
  size(600, 600);
  handles = new Handle[4];
  barSize = width/4;
  barX = width/2 - barSize/2;
  barY = height*3/5;
  tabSize = min(width/40, height/40);
  barInt = height/20;
  initialVal = barSize/2;
  min = 0;
  max = 100;

  handles[0] = new Handle(barX, barY + 0*barInt, initialVal, tabSize, barSize, handles, min, max);
  handles[1] = new Handle(barX, barY + 1*barInt, initialVal, tabSize, barSize, handles, min, max);
  handles[2] = new Handle(barX, barY + 2*barInt, initialVal, tabSize, barSize, handles, min, 20);
  handles[3] = new Handle(barX, barY + 3*barInt, 0, tabSize, barSize, handles, min, 360);
}
void draw() {
  background(200);
  a = handles[0].val();
  b = handles[1].val();
  c = handles[2].val();
  d = handles[3].val();
  
  pushMatrix();
  rectMode(CENTER);
  translate(width/2+a, height/4+b);
  rotate(radians(d));
  scale(c);
  noStroke();
  fill(255);
  rect(0, 0, 10, 10);
  fill(0,255,0);
  rect(3, 3, 4, 4);
  fill(0);
  rectMode(CORNER);
  popMatrix();

  for (int i = 0; i < handles.length; i++) {
    handles[i].update();
    handles[i].display();
  }
}
