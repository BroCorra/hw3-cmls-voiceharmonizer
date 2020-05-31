import controlP5.*;
import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress myRemoteLocation;

ControlP5 cp5;
Knob grain_knob;
Knob pitchShiftRatio_knob;
Knob pitchDispersion_knob;
Knob timeDispersion_knob;
Knob amp_knob;
Knob offset_knob;
Knob pan_knob;
Button Play_Stop_Button;

boolean Play_Stop = false ;
int vlas=0;
float grain;
float pitchShiftRatio;
float pitchDispersion;
float timeDispersion;
float pan;
float amp;
float offset;




void setup(){
  
  size(1000,1000);
  smooth();
  noStroke();
  background(100, 150,200);
  
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",57120);
  
  cp5 = new ControlP5(this);
  
  Play_Stop_Button = cp5.addButton("Play_Stop")
    .setPosition(3*width/10, 3*height/10) 
    .setSize(160,160)
    .setValue(1)
    .setColorForeground(color(201,112,112))   
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(255))  
    .setFont(createFont("Georgia",22));
  
  
  grain_knob = cp5.addKnob("grain")
    .setPosition(3*width/10, 1*height/10)
    .setRadius(80)
    .setRange(3,40)
    .setValue(1)
    .setColorForeground(color(201,112,112))   
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))  
    .setFont(createFont("Georgia",22));
    
  pitchShiftRatio_knob = cp5.addKnob("pitchShiftRatio")
    .setPosition(1*width/10, 1*height/10)
    .setRadius(80)
    .setRange(0,4)
    .setValue(1)
    .setColorForeground(color(201,112,112))    
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))
    .setFont(createFont("Georgia",22));
    
  pitchDispersion_knob = cp5.addKnob("pitchDispersion")
    .setPosition(7*width/10, 1*height/10)
    .setRadius(80)
    .setRange(0,10)
    .setValue(1)
    .setColorForeground(color(201,112,112))     
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))
    .setFont(createFont("Georgia",22));
    
  timeDispersion_knob = cp5.addKnob("timeDispersion")
    .setPosition(5*width/10, 1*height/10)
    .setRadius(80)
    .setRange(0,10)
    .setValue(1)
    .setColorForeground(color(201,112,112))
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))
    .setFont(createFont("Georgia",22));
    
  pan_knob = cp5.addKnob("pan")
    .setPosition(1*width/10, 3*height/10)
    .setRadius(80)
    .setRange(-1,1)
    .setValue(1)
    .setColorForeground(color(201,112,112))     
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))
    .setFont(createFont("Georgia",22));
    
  amp_knob = cp5.addKnob("amp")
    .setPosition(5*width/10, 3*height/10)
    .setRadius(80)
    .setRange(0,100)
    .setValue(1)
    .setColorForeground(color(201,112,112))     
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))
    .setFont(createFont("Georgia",22));
    
  offset_knob = cp5.addKnob("offset")
    .setPosition(7*width/10, 3*height/10)
    .setRadius(80)
    .setRange(-10,10)
    .setValue(1)
    .setColorForeground(color(201,112,112))     
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))
    .setFont(createFont("Georgia",22));
    

}
void draw(){
  background(100,150,200);
  textSize(44);
  {
  fill(0, 0, 0);
  text("Harmonizer", 2*width/5, height/12);
  
  };
  
  {
  if(Play_Stop){
    textSize(30);
    fill(50, 100, 50);
    text( "Resume",40,40 );
    
  }else{
    textSize(30);
    fill(100, 50, 50);
    text( "Stoped",40,40  );
 
  }};
}


public void Play_Stop(){
  if(!Play_Stop){
    vlas=1;
    Play_Stop = true;
  }else{
    vlas=0;
    Play_Stop=false ;
  }
}

void controlEvent(ControlEvent theEvent){
 OscMessage myMessage = new OscMessage("/pos");
 
 myMessage.add(grain);
 myMessage.add(pitchShiftRatio);
 myMessage.add(pitchDispersion);
 myMessage.add(timeDispersion);
 myMessage.add(pan);
 myMessage.add(vlas);
 myMessage.add(amp);
 myMessage.add(offset);
 
 oscP5.send(myMessage, myRemoteLocation);
 myMessage.print();
}
