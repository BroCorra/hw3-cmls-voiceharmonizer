import oscP5.*;
import netP5.*;

OscP5 oscP5;
OscMessage semitoneMsg;
NetAddress remoteLocation;

PFont font;
int[] semitones = {4, 7};    //By default on major chord
boolean isMain=false, individualMode=false;

StartScene startScene;
MainScene mainScene;
Pad harmony, grain, reverb, delay;

void setup(){
  size(880, 800);
  
  /*oscP5 = new OscP5(this, 12000);
  semitoneMsg = new OscMessage("/sem");
  remoteLocation  = new NetAddress("127.0.0.1", 57120);*/
  
  font = createFont("Moon2.0-Regular.otf", 26);
  startScene = new StartScene(this);
  harmony = new Pad(100, height-380);
  grain = new Pad(450, height-380);
  reverb = new Pad(800, height-380);
  delay = new Pad(1150, height-380);
}

void draw(){
  background(0, 0, 0);    //Background color (R, G, B)
  
  fill(255, 255, 255);    //Text color
  textFont(createFont("Moon2.0-Regular.otf", 60));
  textAlign(CENTER, TOP);
  text("H A R M O N I Z E R", width/2, 50);
  
  if(isMain){
    if(individualMode){
      harmony.paint();
      grain.paint();
      reverb.paint();
      delay.paint();
      fill(255, 255, 255);
      textFont(font);
      text("HARMONY", 260, height/2-10);
      text("GRAIN", 605, height/2-10);
      text("REVERB", 955, height/2-10);
      text("DELAY", 1295, height/2-10);
    }
  }
}

void changeScene(){
  surface.setSize(1550, 800);
  mainScene = new MainScene(this);
  isMain = true;
}

void mousePressed(){
  if(isMain){
    harmony.mousePress();
    grain.mousePress();
    reverb.mousePress();
    delay.mousePress();
  }
}

void mouseDragged(){
  if(isMain){
    harmony.mouseDrag();
    grain.mouseDrag();
    reverb.mouseDrag();
    delay.mouseDrag();
  }
}

void mouseReleased(){
  if(isMain){
    harmony.mouseRelease();
    grain.mouseRelease();
    reverb.mouseRelease();
    delay.mouseRelease();
  }
}
/*semitoneMsg.add(semitones);
oscP5.send(semitoneMsg, remoteLocation);
semitoneMsg.print();
semitoneMsg.clearArguments();*/
