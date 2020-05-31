/**
 * Pad. 
 * 
 * Click on the box and drag it across the screen. 
 */

class Pad {
  private float xPad, yPad, boxX, boxY, xOffset, yOffset, xMsg, yMsg;
  private int boxSize=10, padSize=300;
  private boolean overBox=false, locked=false;
  private NetAddress remoteLocation;
  private OscMessage msg;
  private OscP5 oscP5;
  
  Pad(int x, int y, String msg, NetAddress remoteLocation, OscP5 oscP5){
    //Position of the pad in the window
    xPad = x;
    yPad = y;
    this.remoteLocation = remoteLocation;
    this.msg = new OscMessage(msg);
    this.oscP5 = oscP5;
    
    //Initial position of the rectangle in the pad
    boxX = xPad + padSize/2;
    boxY = yPad + padSize/2;
    
  }
  
  public void paint(){
    //Draw the pad
    stroke(100, 100, 100);
    strokeWeight(3);
    fill(15, 15, 15);
    rect(xPad, yPad, padSize, padSize);
    
    // Test if the cursor is over the box 
    strokeWeight(1);
    if (mouseX > boxX && mouseX < boxX+boxSize && 
      mouseY > boxY && mouseY < boxY+boxSize) {
      overBox = true;  
      if(!locked) { 
        stroke(255);
        fill(153);
      } 
    } else {
      stroke(153);
      fill(153);
      overBox = false;
    }
  
    // Draw the box
    rect(boxX, boxY, boxSize, boxSize);
  }
  
  public void mousePress() {  
    if(overBox) { 
      locked = true; 
      fill(255, 255, 255);
    } else {
      locked = false;
    }
    xOffset = mouseX-boxX; 
    yOffset = mouseY-boxY;  
  }
  
  public void mouseDrag(){
    if(locked) {
      boxX = mouseX-xOffset; 
      boxY = mouseY-yOffset;
      
      boxX = (boxX<xPad) ? xPad : boxX;
      boxX = (boxX>xPad+padSize-boxSize) ? (xPad+padSize-boxSize) : boxX;
      boxY = (boxY<yPad) ? yPad : boxY;
      boxY = (boxY>yPad+padSize-boxSize) ? (yPad+padSize-boxSize) : boxY; 
      
      
      float x = boxX-xPad;
      float y = boxY-yPad;
      
      if(x != xMsg || y != yMsg) {
        xMsg = x;
        yMsg = y;
        //SEND OSC MESSAGE (boxX-xPad) AND (boxY-yPad)
        print("x: " + xMsg  + " - y: " + yMsg + "\n");
        
        msg.add(xMsg);
        msg.add(yMsg);
        msg.print();
        oscP5.send(msg, remoteLocation);
        msg.clearArguments();
      }
      
      
    }
  }
  
  public void mouseRelease() {
    locked = false;
  }
}
