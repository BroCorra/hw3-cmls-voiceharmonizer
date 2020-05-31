import controlP5.*;

class StartScene {
  private ControlP5 cP5;
  
  StartScene(PApplet parent){

    cP5 = new ControlP5(parent);
    ;
    //Setting the "choose modality" label
    cP5.addLabel("C H O O S E  M O D A L I T Y")
      .setFont(font)
      .setPosition(width/2-210, height/2-150);
      
    //INDIVIDUAL button setup
    cP5.addButton("INDIVIDUAL")
      .setSize(300, 100)
      .setPosition(width/2 - 150, height/2 - 100)
      .setFont(font)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            individualSetup(true);
          }
      });
    
    //COLLABORATIVE button setup
    cP5.addButton("COLLABORATIVE")
      .setSize(300, 100)
      .setPosition(width/2 - 150, height/2 + 20)
      .setFont(font)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            individualSetup(false);
          }
      });
  }
  
  //Called when a button is pressed
  private void individualSetup(boolean value){
    individualMode = value;
    changeScene();
    cP5.hide();
  }
  
}
