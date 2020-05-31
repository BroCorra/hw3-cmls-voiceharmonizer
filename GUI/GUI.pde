import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;

PFont font;
int[] semitones = {4, 7};    //By default on major chord
boolean isMain=false, individualMode=false;
ArrayList<Pad> pads = new ArrayList<Pad>();

StartScene startScene;
MainScene mainScene;



void setup(){
  size(880, 800);
  
  oscP5 = new OscP5(this, 12000);
  remoteLocation  = new NetAddress("127.0.0.1", 57120);
  
  font = createFont("Moon2.0-Regular.otf", 26);
  startScene = new StartScene(this);
  pads.add(new Pad(100, height-380,"/pad1",remoteLocation,oscP5));
  pads.add(new Pad(450, height-380,"/pad2",remoteLocation,oscP5));
  pads.add(new Pad(800, height-380,"/pad3",remoteLocation,oscP5));
  pads.add(new Pad(1150, height-380,"/pad4",remoteLocation,oscP5));

}

void draw(){
  background(0, 0, 0);    //Background color (R, G, B)
  
  fill(255, 255, 255);    //Text color
  textFont(createFont("Moon2.0-Regular.otf", 60));
  textAlign(CENTER, TOP);
  text("H A R M O N I Z E R", width/2, 50);
  
  if(isMain){
    if(individualMode){
      for(Pad pad : pads) {
        pad.paint();
      }
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
  mainScene = new MainScene(this,remoteLocation,oscP5);
  isMain = true;
}

void mousePressed(){
  if(isMain){
    for(Pad pad : pads) {
      pad.mousePress();
    }
  }
}

void mouseDragged(){
  if(isMain){
    for(Pad pad : pads) {
      pad.mouseDrag();
    }
  }
}

void mouseReleased(){
  if(isMain){
    for(Pad pad : pads) {
      pad.mouseRelease();
    }
  }
}
/*semitoneMsg.add(semitones);
oscP5.send(semitoneMsg, remoteLocation);
semitoneMsg.print();
semitoneMsg.clearArguments();*/
