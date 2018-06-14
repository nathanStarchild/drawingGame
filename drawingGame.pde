import controlP5.*;
import java.awt.Color;

float symmetry;
float dx;
float dy;
ControlFrame cf;
Brush myBrush;
Palette myPalette;
ControlP5 cp5;
MyColorPicker cp;
Slider abc;
int menuX = 110;
int menuY = 110;
int fTime;
int cpAction = 1;
boolean rot = false;
boolean rot1 = false;
boolean rot2 = false;
boolean rot3 = false;
boolean rot4 = false;
float rotRate = 1;
boolean spiral = false;
float spiralOffset = 1;
boolean fadeOn = false;

PImage tSkull;
boolean tSkullOn = false;
boolean instaOn = false;

PFont instaFont, labelsFont, scalesFont;

public void settings() {
   //size(1700, 1100, P2D);
  fullScreen(P2D, SPAN);
}
  

void setup() {
  //size(1500, 1000, P2D);
  //noSmooth();
  cursor(CROSS);
  //frameRate(30);
  background(255, 255, 255);
  dx = width/2;
  dy = height/2;
  symmetry = 6;

  myBrush = new Brush(1, 1, 1, color(0, 220, 100), color(55, 100, 155));
  myBrush.setBrushSize(8, 8);

  myPalette = new Palette(1);
  
  tSkull = loadImage("turtle skull.png");
  
  instaFont = createFont("Georgia", 87);
  labelsFont = createFont("Noto Sans CJK KR Regular", 10);
  scalesFont = createFont("Noto Sans CJK KR Regular", 14);
  //textFont(myFont);

  // cf = new ControlFrame(this, 170, 300, "Controls");


  //////////
  //Menu
  //////////
  int menuBuff = 5;
  int buttonSize = 30;
  int menuWidth = 100;
  int cpHeight = 60;
  int slHeight = 10;
  cp5 = new ControlP5(this);
  cp5.addButton("buttonFill")
    .setPosition(menuBuff, menuBuff)
    .setSize(buttonSize, buttonSize)
    .setCaptionLabel("Fill")
    .hide()
    ;
  cp5.addButton("buttonStroke")
    .setPosition(menuBuff * 2 + buttonSize, menuBuff)
    .setSize(buttonSize, buttonSize)
    .setCaptionLabel("Strk")
    .setColorLabel(155)
    .hide()
    ;
  cp5.addButton("buttonBkg")
    .setPosition(menuBuff * 3 + buttonSize * 2, menuBuff)
    .setSize(buttonSize, buttonSize)
    .setCaptionLabel("Bkg")
    .hide()
    ;
  cp = new MyColorPicker(cp5, "picker");
  cp
    .setPosition(menuBuff, menuBuff + buttonSize)
    .setSize(menuWidth, cpHeight)
    .setColorValue(color(255, 128, 0, 128))
    .hide()
    ;
  myBrush.setColourBody(cp.getColorValue());
  cp5.addSlider("sizeSlider")
    .setPosition(menuBuff, menuBuff * 2 + buttonSize + cpHeight)
    .setSize(menuWidth, slHeight)
    .setRange(0,1600)
    //.setNumberOfTickMarks(201)
    //.showTickMarks(false)
    .setCaptionLabel("Size")
    .setValue(5);
    ;
  cp5.addSlider("symmetrySlider")
    .setPosition(menuBuff, menuBuff * 3 + buttonSize + cpHeight + slHeight)
    .setSize(menuWidth, slHeight)
    .setRange(0,72)
    .setCaptionLabel("Symmetry")
    .setValue(12)
    .setNumberOfTickMarks(73)
    .showTickMarks(false)
    ;
    menuX = menuBuff + menuWidth;
    menuY = menuBuff * 4 + buttonSize + cpHeight + slHeight * 2;
  
  
}


void draw() {
  
  fTime = millis()*60/1000;
  if (fadeOn) {
    pushStyle();
    fill(200, 200, 200, 20);
    rect(0, 0, 2000, 1500);
    popStyle();
  }
  
  fill(myBrush.colourBody);
  stroke(myBrush.colourStroke);
  tint(255, myBrush.alphaBody);
  pushMatrix();
  translate(width/2.0, height/2.0);
  
  if (rot){
      rotate(fTime * rotRate * PI/360);
    }
  
  myBrush.fibSize(mouseX, mouseY);
  myBrush.rainbowSequence();
  if (mousePressed) {
    if (!((mouseX < menuX + 5) && (mouseY < menuY))) {
      if (mouseButton == LEFT) {
        iter1(mouseX, mouseY);
      } else {
        dx = mouseX;
        dy = mouseY;
      }
    }
  }
  popMatrix();
  //if (frameCount % 10 == 0) {
    //saveFrame("frames002/frame#####.tga");
  //}
  pushStyle();
  fill(0);
  fill(100, 100, 100);
  rect(5, menuY, 160, 40);
  fill(255, 255, 255);
  textSize(10);
  textFont(labelsFont);
  text("f", 20, menuY - 5 + 20);
  text("v", 40, menuY - 5 + 20);
  text("b", 60, menuY - 5 + 20);
  text("n", 80, menuY - 5 + 20);
  text("m", 100, menuY - 5 + 20);
  text("R", 120, menuY - 5 + 20);
  text(myBrush.rainbowRate, 140, menuY - 5 + 20);
  
  pushStyle();
  textFont(scalesFont);
  textSize(14);
  text(rotRate, 20, menuY - 5 + 40);
  text(int(frameRate), 70, menuY - 5 + 40);
  text(myBrush.alphaBody, 100,  menuY - 5 + 40);
  popStyle();
  
  fill(255, 0, 255);
  if(myBrush.fibOn){
    text("f", 20, menuY - 5 + 20);
  }
  if(rot1){
    text("v", 40, menuY - 5 + 20);
  }
  if(rot2){
    text("b", 60, menuY - 5 + 20);  
  }
  if(rot3){
    text("n", 80, menuY - 5 + 20);
  }
  if(rot4){
    text("m", 100, menuY - 5 + 20);
  }
  if(myBrush.rainbowOn){
    text("R", 120, menuY - 5 + 20);
    text(myBrush.rainbowRate, 140, menuY - 5 + 20);
  }
  
  popStyle();
  
  
}

void iter1(float x, float y) {
  pushMatrix();
  if(rot1){
    rotate(fTime * rotRate * PI/360);
  }
  for (int i=0; i<symmetry; i++) {
    if (rot2){
      rotate(2*PI/symmetry + fTime * rotRate * PI/360);
    }else {
      rotate(2*PI/symmetry);
    }
    pushMatrix();
    if (spiral) {
      spiralOffset = pow((sqrt(5)/2), i);
    } else {
      spiralOffset = 1;
    }
    translate((dx-width/2.0) * sqrt(spiralOffset), (dy-height/2.0) * sqrt(spiralOffset));
    iter2(x, y);
    popMatrix();
  }
  popMatrix();
}

void iter2(float x, float y) {
  pushMatrix();
  if (rot3) {
    rotate(2*PI/symmetry + fTime * rotRate * PI/360);
  }
  for (int i=0; i<symmetry; i++) {
    //ellipse(x-dx, y-dy, myBrush.a, myBrush.b);
    if (rot4){
      rotate(2*PI/symmetry + fTime * rotRate * PI/360);
    }else {
      rotate(2*PI/symmetry);
    }
    myBrush.drawIt(x, y);
  }
  popMatrix();
}

public class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  //ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  void settings() {
    size(w, h, P2D);
  }
  
  public void setup() {
    //////////
    //Menu
    //////////
    int menuBuff = 5;
    int buttonSize = 30;
    int menuWidth = 100;
    int cpHeight = 60;
    int slHeight = 10;
    cp5 = new ControlP5(this);
    cp5.addButton("buttonFill")
      .plugTo(parent)
      .setPosition(menuBuff, menuBuff)
      .setSize(buttonSize, buttonSize)
      .setCaptionLabel("Fill")
      ;
    cp5.addButton("buttonStroke")
      .plugTo(parent)
      .setPosition(menuBuff * 2 + buttonSize, menuBuff)
      .setSize(buttonSize, buttonSize)
      .setCaptionLabel("Strk")
      .setColorLabel(155)
      ;
    cp5.addButton("buttonBkg")
      .plugTo(parent)
      .setPosition(menuBuff * 3 + buttonSize * 2, menuBuff)
      .setSize(buttonSize, buttonSize)
      .setCaptionLabel("Bkg")
      .hide()
      ;
    cp = new MyColorPicker(cp5, "picker");
    cp
      .plugTo(parent)
      .setPosition(menuBuff, menuBuff + buttonSize)
      .setSize(menuWidth, cpHeight)
      .setColorValue(color(255, 128, 0, 128))
      ;
    myBrush.setColourBody(cp.getColorValue());
    cp5.addSlider("sizeSlider")
      .plugTo(parent)
      .setPosition(menuBuff, menuBuff * 2 + buttonSize + cpHeight)
      .setSize(menuWidth, slHeight)
      .setRange(0,1600)
      //.setNumberOfTickMarks(201)
      //.showTickMarks(false)
      .setCaptionLabel("Size")
      .setValue(5);
      ;
    cp5.addSlider("symmetrySlider")
      .plugTo(parent)
      .setPosition(menuBuff, menuBuff * 3 + buttonSize + cpHeight + slHeight)
      .setSize(menuWidth, slHeight)
      .setRange(0,72)
      .setCaptionLabel("Symmetry")
      .setValue(12)
      .setNumberOfTickMarks(73)
      .showTickMarks(false)
      ;
      menuX = menuBuff + menuWidth;
      menuY = menuBuff * 4 + buttonSize + cpHeight + slHeight * 2;
  }
  
  void draw() {
    background(180);
    fill(0);
    fill(100, 100, 100);
    rect(5, menuY, 160, 40);
    fill(255, 255, 255);
    textSize(10);
    text("f", 20, menuY - 5 + 20);
    text("v", 40, menuY - 5 + 20);
    text("b", 60, menuY - 5 + 20);
    text("n", 80, menuY - 5 + 20);
    text("m", 100, menuY - 5 + 20);
    text("R", 120, menuY - 5 + 20);
    text(myBrush.rainbowRate, 140, menuY - 5 + 20);
    
    fill(255, 0, 255);
    if(myBrush.fibOn){
     text("f", 20, menuY - 5 + 20);
    }
    if(rot1){
      text("v", 40, menuY - 5 + 20);
    }
    if(rot2){
      text("b", 60, menuY - 5 + 20);  
    }
    if(rot3){
      text("n", 80, menuY - 5 + 20);
    }
    if(rot4){
      text("m", 100, menuY - 5 + 20);
    }
    if(myBrush.rainbowOn){
      text("R", 120, menuY - 5 + 20);
      text(myBrush.rainbowRate, 140, menuY - 5 + 20);
    }
    text(rotRate, 20, menuY - 5 + 40);
    text(frameRate, 60, menuY - 5 + 40);
    text(myBrush.alphaBody, 100,  menuY - 5 + 40);
    
  }
}

class Palette {
  int n;
  color b1, s1, b2, s2, b3, s3, b4, s4, b5, s5, b6, s6, b7, s7, b8, s8, b9, s9;
  Palette (int n) {
    this.n = n;
    this.loadScheme();
    
  }
  
  void loadScheme() {
    switch(this.n) {
      case(1)://album cover
        this.s1 = color(0);
        this.s2 = color(0);
        this.s3 = color(0);
        this.s4 = color(0);
        this.s5 = color(0);
        this.s6 = color(0);
        this.s7 = color(0);
        this.s8 = color(0);
        this.s9 = color(0);
        this.b1 = color(184, 215, 0);
        this.b2 = color(0, 181, 8);
        this.b3 = color(251, 81, 3);
        this.b4 = color(251, 153, 20);
        this.b5 = color(247, 221, 0);
        this.b6 = color(239, 192, 114);
        this.b7 = color(248, 238, 203);
        this.b8 = color(88, 206, 210);
        this.b9 = color(69, 1, 148);
        break;
      case(3):
        this.b1 = color(250, 250, 250);
        this.s1 = color(5, 5, 5);
        this.b2 = color(5, 5, 5);
        this.s2 = color(250, 250, 250);
      break;


      case(4):
        this.b1 = color(104,0,160,18);
        this.s1 = color(55,198,155,255);
        this.b2 = color(28,243,211,13);
        this.s2 = color(255,252,107,255);
        this.b3 = color(255,122,64,17);
        this.s3 = color(38,155,242,255);
        this.b4 = color(255, 0, 0);
        this.s4 = color(70, 0, 0);
        this.b5 = color(200, 5, 5);
        this.s5 = color(100, 0, 0);
        this.b6 = color(155, 0, 0);
        this.s6 = color(255, 100, 100);
        this.b7 = color(100, 0, 0);
        this.s7 = color(255, 155, 155);
        this.b8 = color(50, 0, 0);
        this.s8 = color(255, 200, 200);
        
      break;
    }
  }

  void pressed(char key) {
    switch(key) {
      case('1'):
        myBrush.setColourBody(this.b1);
        myBrush.setColourStroke(this.s1);
      break;
      case('2'):
        myBrush.setColourBody(this.b2);
        myBrush.setColourStroke(this.s2);
      break;
      case('3'):
        myBrush.setColourBody(this.b3);
        myBrush.setColourStroke(this.s3);
      break;
      case('4'):
        myBrush.setColourBody(this.b4);
        myBrush.setColourStroke(this.s4);
      break;
      case('5'):
        myBrush.setColourBody(this.b5);
        myBrush.setColourStroke(this.s5);
      break;
      case('6'):
        myBrush.setColourBody(this.b6);
        myBrush.setColourStroke(this.s6);
      break;
      case('7'):
        myBrush.setColourBody(this.b7);
        myBrush.setColourStroke(this.s7);
      break;
      case('8'):
        myBrush.setColourBody(this.b8);
        myBrush.setColourStroke(this.s8);
      break;
      case('9'):
        myBrush.setColourBody(this.b9);
        myBrush.setColourStroke(this.s9);
      break;        
    }
  }
}

//class Movement  
  

class Brush {
  int a, b, strokeSize, rainbowRate, alphaBody, alphaStroke;
  color colourBody, colourStroke;
  boolean fibOn, rainbowOn, keepAlpha;
  float fibFactor;
  Brush (int a, int b, int s, color bod, color stk) {
    a = a;
    b = b;
    strokeSize = s;
    colourBody = bod;
    colourStroke = stk;
    fibOn=false;
    fibFactor = 0.1;
    rainbowOn = false;
    rainbowRate = 1;
    alphaBody = 255;
    alphaStroke = 255;
    keepAlpha = true;
  }
  
  void drawIt(float x, float y) {
    if (!tSkullOn) {
      ellipse(x-dx, y-dy, this.a, this.b);
    } else {
      image(tSkull, x-dx, y-dy, this.a, this.b);
    }
  }
  
  void fibToggle() {
    this.fibOn = !(this.fibOn);
  }
  
  void setFibFactor(float f) {
    this.fibFactor = f;
  }
  
  void fibSize(float x,float y) {
    if(this.fibOn) {
    float r = sqrt(sq(x - (width/2)) + sq(y-height/2));
    int rInt = int(this.fibFactor*r*((1*sqrt(5))/2));
    this.setBrushSize(rInt, rInt);
    }
  }
  
  void rainbowToggle() {
    this.rainbowOn = !(this.rainbowOn);
  }
  
  void incRainbowRate() {
    this.rainbowRate++;
  }
  
  void decRainbowRate() {
    this.rainbowRate = max((this.rainbowRate - 1), 1);
  }
  
  void setBrushSize(int s1, int s2) {
    this.a = s1;
    this.b = s2;
  }
  
  void incBrushSize() {
    int tmpA = int(a + 1);
    int tmpB = int(b + 1);
    ///print(a==round(a));
    cp5.getController("sizeSlider").setValue(tmpA);
    this.a = tmpA;
    this.b = tmpB;
    //println(a);
    
  }
  
  void decBrushSize() {
    this.a--;
    this.b--;    
    cp5.getController("sizeSlider").setValue(a);
  }
  
  void brushSize10() {
    this.a = 10;
    this.b = 10;    
    cp5.getController("sizeSlider").setValue(a);
  }
  
  void setStrokeSize(int ss) {
    this.strokeSize = ss;
    strokeWeight(ss);
  }
  
  void setColourBody(color bod) {
    int a = (bod >> 24) & 0xFF;
    int r = (bod >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (bod >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = bod & 0xFF;          // Faster way of getting blue(argb
    if (this.keepAlpha) {
      a = this.alphaBody;
    }
    this.alphaBody = a;
    this.colourBody = color(r, g, b, a);
    fill(color(r, g, b, a));
  }

  void setColourStroke(color stk) {
    int a = (stk >> 24) & 0xFF;
    int r = (stk >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (stk >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = stk & 0xFF;          // Faster way of getting blue(argb
    if (this.keepAlpha) {
      a = this.alphaStroke;
    }
    this.alphaStroke = a;
    this.colourStroke = color(r, g, b, a);
    stroke(color(r, g, b, a));
  }
  
  void decAlphaBody() {
    int a = (this.colourBody >> 24) & 0xFF;
    a--;
    this.alphaBody = a;
    int r = (this.colourBody >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (this.colourBody >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = this.colourBody & 0xFF;          // Faster way of getting blue(argb
    buttonFill();
    cp.setColorValue(color(r, g, b, a));
    this.setColourBody(color(r, g, b, a));
  }
  
  void incAlphaBody() {
    int a = (this.colourBody >> 24) & 0xFF;
    a++;
    this.alphaBody = a;
    int r = (this.colourBody >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (this.colourBody >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = this.colourBody & 0xFF;          // Faster way of getting blue(arg
    buttonFill();
    cp.setColorValue(color(r, g, b, a));
    this.setColourBody(color(r, g, b, a));
  }
  
  void transparentBody() {
    int r = (this.colourBody >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (this.colourBody >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = this.colourBody & 0xFF;          // Faster way of getting blue(argb
    this.alphaBody = 0;
    buttonFill();
    cp.setColorValue(color(r, g, b, 0));
    this.setColourBody(color(r, g, b, 0)); 
  } 
  
  void setAlphaBody(int alph) {
    int r = (this.colourBody >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (this.colourBody >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = this.colourBody & 0xFF;          // Faster way of getting blue(argb
    this.alphaBody = alph;
    buttonFill();
    cp.setColorValue(color(r, g, b, alph));
    this.setColourBody(color(r, g, b, alph)); 
  } 

  void incAlphaStroke() {
    int a = (this.colourStroke >> 24) & 0xFF;
    a++;
    this.alphaStroke = a;
    int r = (this.colourStroke >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (this.colourStroke >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = this.colourStroke & 0xFF;          // Faster way of getting blue(arg
    buttonStroke();
    cp.setColorValue(color(r, g, b, a));
    this.setColourStroke(color(r, g, b, a));
  }
  
  void decAlphaStroke() {
    int a = (this.colourStroke >> 24) & 0xFF;
    a--;
    this.alphaStroke = a;
    int r = (this.colourStroke >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (this.colourStroke >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = this.colourStroke & 0xFF;          // Faster way of getting blue(arg
    buttonStroke();
    cp.setColorValue(color(r, g, b, a));
    this.setColourStroke(color(r, g, b, a));
  }
  
  void transparentStroke() {
    int r = (this.colourStroke >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (this.colourStroke >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = this.colourStroke & 0xFF;          // Faster way of getting blue(arg
    this.alphaStroke = 0;
    buttonStroke();
    cp.setColorValue(color(r, g, b, 0));
    this.setColourStroke(color(r, g, b, 0));
  }
  
  void setAlphaStroke(int alph) {
    int r = (this.colourStroke >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (this.colourStroke >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = this.colourStroke & 0xFF;          // Faster way of getting blue(arg
    this.alphaStroke = alph;
    buttonStroke();
    cp.setColorValue(color(r, g, b, alph));
    this.setColourStroke(color(r, g, b, alph));
  } 
  
  
  void rainbowSequence() {
    int hue = int((fTime / rainbowRate) % 255);
    if (this.rainbowOn) {
      pushStyle();
      colorMode(HSB, 255);
      int a = (this.colourBody >> 24) & 0xFF;
      int as = (this.colourStroke >> 24) & 0xFF;
      color myColor = color(hue, 175, 175, a);
      color strokeColor = color((hue+(256/2))%255, 255, 255, as);
      //int a = (this.colourBody >> 24) & 0xFF;
      //int r = (myColor >> 16) & 0xFF;  // Faster way of getting red(argb)
      //int g = (myColor >> 8) & 0xFF;   // Faster way of getting green(argb)
      //int b = myColor & 0xFF; 
      
      //int rs = (strokeColor >> 16) & 0xFF;  // Faster way of getting red(argb)
      //int gs = (strokeColor >> 8) & 0xFF;   // Faster way of getting green(argb)
      //int bs = strokeColor & 0xFF; 
      popStyle();
      //buttonFill();
      //cp.setColorValue(myColor);
      this.setColourBody(myColor);
      //buttonStroke();
      //cp.setColorValue(strokeColor);
      this.setColourStroke(strokeColor);
      //buttonFill(); 
    }
  } 
}

public void picker(int col) {
  if (cpAction == 1) {
    myBrush.setColourBody(col);
  } else if (cpAction == 2) {
    myBrush.setColourStroke(col);
  }
}

public void keyPressed() {
  myPalette.pressed(key);
  switch(key) {

    case('q'):
      myBrush.decAlphaBody();
      break;
    case('Q'):
      for (int i=0; i<10; i++) {
        myBrush.decAlphaBody();
      }
    break;
    case('w'):
      myBrush.incAlphaBody();
    break;
    case('W'):
      for (int i=0; i<10; i++) {
        myBrush.incAlphaBody();
      }
    break;
    case('e'):
      myBrush.decAlphaStroke();
    break;
    case('E'):
      for (int i=0; i<10; i++) {
        myBrush.decAlphaStroke();
      }
    break;
    case('r'):
      myBrush.incAlphaStroke();
    break;
    case('R'):
      for (int i=0; i<10; i++) {
        myBrush.incAlphaStroke();
      }
    break;
    case('T'):
      tSkullOn = !tSkullOn;
    break;
    case('I'):
      //instaOn = !instaOn;
      //if (instaOn){
        //String[] fontList = PFont.list();
        //printArray(fontList);
        pushStyle();
        fill(69, 1, 148);
        textFont(instaFont);
        textSize(87);
        text("@starchildart", 1300, 1000);
        text("@turtleskullmusic", 50, 1000);
        popStyle();
      //}
      break;
    case('i'):
      //instaOn = !instaOn;
      //if (instaOn){
        //String[] fontList = PFont.list();
        //printArray(fontList);
        pushStyle();
        fill(255);
        textFont(instaFont);
        textSize(87);
        text("@starchildart", 1300, 1000);
        text("@turtleskullmusic", 50, 1000);
        popStyle();
      //}
      break;
    case('O'):
      myPalette = new Palette(3);
      symmetry = 1;
      cp5.getController("symmetrySlider").setValue(symmetry);
      myBrush.setBrushSize(1600, 1600);      
    break;
  //  case('t'):
  //    buttonFill();
  //    cp.setColorValue(color(104,0,160,18));
  //    buttonStroke();
  //    cp.setColorValue(color(55,198,155,255));
  //    //cp5.getController("sizeSlider").setValue(100);
  //  break;
  //  case('y'):
  //    buttonFill();
  //    cp.setColorValue(color(28,243,211,13));
  //    buttonStroke();
  //    cp.setColorValue(color(255,252,107,255));
  //    break;
  //  case('u'):
  //    buttonFill();
  //    cp.setColorValue(color(255,122,64,17));
  //    buttonStroke();
  //    cp.setColorValue(color(38,155,242,255));
  //    break;
    
    case('a'):
      if (!myBrush.fibOn) {
        myBrush.decBrushSize();
      } else {
        myBrush.setFibFactor(myBrush.fibFactor-0.1);
      }
    break;
    case('A'):
      for (int i=0; i<10; i++) {
        myBrush.decBrushSize();
      }
    break;
    case('s'):
      if (!myBrush.fibOn) {
        myBrush.incBrushSize();
      } else {
        myBrush.setFibFactor(myBrush.fibFactor+0.1);
      }
    break;
    case('S'):
      for (int i=0; i<10; i++) {
        myBrush.incBrushSize();
      }
    break;
    case('d'):
      myBrush.transparentBody();
    break;   
    case('D'):
      myBrush.transparentStroke();
    break;   
    case('f'):
      myBrush.fibToggle();
    break;    
   case('g'):
     myBrush.setFibFactor(myBrush.fibFactor+0.1);
     break;   
   case('h'):
     myBrush.setFibFactor(myBrush.fibFactor-0.1);
     break;
     
   case('k'):
     myBrush.transparentBody();
     for (int i=0; i<10; i++) {
       myBrush.incAlphaBody();
     }
     break;
     
     
    case('z'):
      symmetry--;
      cp5.getController("symmetrySlider").setValue(symmetry);
      break;
    case('x'):
      symmetry++;
      cp5.getController("symmetrySlider").setValue(symmetry);
      break;
   case('p'):
     myBrush.brushSize10();
     break;
     
   case('l'):
     save("savedImage"+int(random(10000))+".tif");
     break;
     
   //case('c'):
   //  rot = !(rot);
   //  break;
     
   case('v'):
     rot1 = !(rot1);
     break;
     
   case('b'):
     rot2 = !(rot2);
     break;
     
   case('n'):
     rot3 = !(rot3);
     break;
     
   case('m'):
     rot4 = !(rot4);
     break;
     
   case(','):
     rotRate *= 0.9;
     break;
     
   case('.'):
     rotRate *= 1.1;
     break;
   case('<'):
     rotRate = 0.1;
     break;
     
   case('>'):
     rotRate = 1;
     break;
   case('!'):
     myPalette = new Palette(1);
     break;
   case('@'):
     myPalette = new Palette(2);
     break;
   case('#'):
     myPalette = new Palette(3);
     break;
   case('$'):
     myPalette = new Palette(4);
     break;
     
   case(CODED):
     switch(keyCode) {
       case(LEFT):
           myBrush.rainbowToggle();
     //    left = max(0, left - 10);
         break;
     //  case(RIGHT):
     //    left = left + 10;
     //    break;
       case(UP):
         myBrush.incRainbowRate();
         break;
       case(DOWN):
         myBrush.decRainbowRate();
         break;
     }
     break;
      
 }
}

public class MyColorPicker extends ColorPicker {
  MyColorPicker(ControlP5 cp5, String theName) {
    super(cp5, cp5.getTab("default"), theName, 0, 0, 100, 10);
  }
 
  void setItemSize(int w, int h) {
    sliderRed.setSize(w, h);
    sliderGreen.setSize(w, h);
    sliderBlue.setSize(w, h);
    sliderAlpha.setSize(w, h);
  }
}

public void buttonFill() {
  cpAction = 1;
  cp.setColorValue(myBrush.colourBody);
  //cp5.getController("buttonFill").setLabelVisible(false);
  //cp5.getController("buttonStroke").setLabelVisible(true);
  cp5.getController("buttonFill").setColorLabel(255);
  cp5.getController("buttonStroke").setColorLabel(155);
}

public void buttonStroke() {
  cpAction = 2;
  cp.setColorValue(myBrush.colourStroke);
  //cp5.getController("buttonFill").setLabelVisible(true);
  //cp5.getController("buttonStroke").setLabelVisible(false);
  cp5.getController("buttonFill").setColorLabel(155);
  cp5.getController("buttonStroke").setColorLabel(255);
}

public void sizeSlider(float a) {
  myBrush.setBrushSize(int(a),int(a));
}

public void symmetrySlider(float a) {
  symmetry = int(a);
}


// switch(key) {
//         case('1'):
//           buttonFill();
//           cp.setColorValue(color(0, 255, 0, 15));
//           buttonStroke();
//           cp.setColorValue(color(0, 0, 255, 255));
//           cp5.getController("sizeSlider").setValue(100);
//         break;
//         case('2'):
//           buttonFill();
//           cp.setColorValue(color(#0B61A4));
//           buttonStroke();
//           cp.setColorValue(color(30,0,115,255));
//           //cp5.getController("sizeSlider").setValue(100);
//         break;
//         case('3'):
//           buttonFill();
//           cp.setColorValue(color(#25567B));
//           buttonStroke();
//           cp.setColorValue(color(#FFDC73));
//           //cp5.getController("sizeSlider").setValue(100);
//         break;
//         case('4'):
//           buttonFill();
//           cp.setColorValue(color(#033E6B));
//           buttonStroke();
//           cp.setColorValue(color(#66A3D2));
//           //cp5.getController("sizeSlider").setValue(100);
//         break;
//         case('5'):
//           buttonFill();
//           cp.setColorValue(color(#FFBF00));
//           buttonStroke();
//           cp.setColorValue(color(#3F92D2));
//           //cp5.getController("sizeSlider").setValue(100);
//         break;
//         case('6'):
//           buttonFill();
//           cp.setColorValue(color(#FFCF40));
//           buttonStroke();
//           cp.setColorValue(color(#A62F00));
//           //cp5.getController("sizeSlider").setValue(100);
//         break;
//         case('7'):
//           buttonFill();
//           cp.setColorValue(color(170, 140, 35, 125));
//           buttonStroke();
//           cp.setColorValue(color(63, 146, 210, 75));
//           //cp5.getController("sizeSlider").setValue(100);
//         break;
//         case('8'):
//           buttonFill();
//           cp.setColorValue(color(#FF4900));
//           buttonStroke();
//           cp.setColorValue(color(#FFDC73));
//           //cp5.getController("sizeSlider").setValue(100);
//         break;
//         case('9'):
//           buttonFill();
//           cp.setColorValue(color(68,15,112,255));
//           buttonStroke();
//           cp.setColorValue(color(255,89,214,255));
//         break;
//         case('0'):
//           buttonFill();
//           cp.setColorValue(color(#A62F00));
//           buttonStroke();
//           cp.setColorValue(color(#FF9B73));
//           //cp5.getController("sizeSlider").setValue(100);
//         break;
