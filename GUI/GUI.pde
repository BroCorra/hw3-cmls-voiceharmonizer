import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;

PFont font;
int[] semitones = {4, 7};    //By default on major chord
int selectedParam=0;        //Selected parameter in the collaborative mode (0: harmony, 1:grain, 2:reverb, 3:delay)
boolean isMain=false, individualMode=false, host=true;
ArrayList<Pad> pads = new ArrayList<Pad>();

StartScene startScene;
MainScene mainScene;



void setup(){
  size(880, 900);
  
  oscP5 = new OscP5(this, 12000);
  remoteLocation  = new NetAddress("127.0.0.1", 57120);
  
  font = createFont("Moon2.0-Regular.otf", 26);
  startScene = new StartScene(this);
}

void draw(){
  background(0, 0, 0);    //Background color (R, G, B)
  
  fill(255, 255, 255);    //Text color
  textFont(createFont("Moon2.0-Regular.otf", 60));
  textAlign(CENTER, TOP);
  text("H A R M O N I Z E R", width/2, 60);
  
  if(isMain){
    if(individualMode){
      
      //In individual mode it shows all the pads
      for(Pad pad : pads) {
        pad.paint();
      }
      fill(255, 255, 255);
      textFont(font);
      text("HARMONY", 260, height/2+10);
      text("REVERB", 605, height/2+10);
      text("DELAY", 955, height/2+10);
    }
    else{
      //In collaborative mode it shows only one pad at a time (depending on the selected parameter)
      pads.get(selectedParam).paint();     
    }
  }
}

void changeScene(){
  if(individualMode){
    
    //Set the individual mode buttons layout
    surface.setSize(1200, 900);
    mainScene = new MainScene(this, remoteLocation, oscP5);
    pads.add(new Pad(100, height-400, "/harmony", remoteLocation,oscP5));
    pads.add(new Pad(450, height-400, "/reverb", remoteLocation,oscP5));
    pads.add(new Pad(800, height-400, "/delay", remoteLocation,oscP5));
  }
  else{
    
    //Set the collaborative mode buttons layout
    int padY;
    surface.setSize(880, 900);
    mainScene = new MainScene(this, remoteLocation, oscP5, host);
    //Add all the pads in the same location (only one at a time will be shown from the draw function)
    if(host){
      padY = height - 370;
    }
    else{
      padY = height - 400;
    }
    pads.add(new Pad(290, padY, "/harmony", remoteLocation,oscP5));
    pads.add(new Pad(290, padY, "/reverb", remoteLocation,oscP5));
    pads.add(new Pad(290, padY, "/delay", remoteLocation,oscP5));
  }
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
