import controlP5.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

ControlP5 cp5;
Knob Grain_knob;
Knob PitchShiftRatio_knob;
Knob PitchDispersion_knob;
Knob TimeDispersion_knob;

float Grain;
float PitchShiftRatio;
float PitchDispersion;
float TimeDispersion;

void setup(){
  size(1000,1000);
  background(255);
  smooth();
  noStroke();
  
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",57120);
  
  cp5 = new ControlP5(this);
  Grain_knob = cp5.addKnob("Grain")
    .setPosition(250,100)
    .setRadius(80)
    .setRange(0,4000)
    .setValue(1)
    .setColorForeground(color(201,112,112))
    .setColorBackground(color(201,112,112))
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))  
    .setFont(createFont("Georgia",40));
    
  PitchShiftRatio_knob = cp5.addKnob("PitchShiftRatio")
    .setPosition(250,300)
    .setRadius(80)
    .setRange(0,10)
    .setValue(1)
    .setColorForeground(color(201,112,112))
    .setColorBackground(color(201,112,112))
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))
    .setFont(createFont("Georgia",40));
  PitchDispersion_knob = cp5.addKnob("PitchDispersion")
    .setPosition(250,500)
    .setRadius(80)
    .setRange(0,10)
    .setValue(1)
    .setColorForeground(color(201,112,112))
    .setColorBackground(color(201,112,112))
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))
    .setFont(createFont("Georgia",40));
  TimeDispersion_knob = cp5.addKnob("TimeDispersion")
    .setPosition(250,700)
    .setRadius(80)
    .setRange(0,10)
    .setValue(1)
    .setColorForeground(color(201,112,112))
    .setColorBackground(color(201,112,112))
    .setColorActive(color(201,112,112))
    .setColorCaptionLabel(color(20,11,11))
    .setFont(createFont("Georgia",40));
}
void draw(){
  background(200,200,200);
  
}
void controlEvent(ControlEvent theEvent){
 OscMessage myMessage = new OscMessage("/pos");
 
 myMessage.add(Grain);
 myMessage.add(PitchShiftRatio);
 myMessage.add(PitchDispersion);
 myMessage.add(TimeDispersion);
 
 oscP5.send(myMessage, myRemoteLocation);
 myMessage.print();
}
