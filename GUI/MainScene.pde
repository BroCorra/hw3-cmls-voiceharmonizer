import controlP5.*;

class MainScene{
  
  private RadioButton chordChoice, parameterChoice;
  private Toggle maj, min, aug, dim, harmony, grain, reverb, delay;
  private Textlabel chordLabel, parameterLabel;
  private ControlP5 cP5;
  private controlP5.Label l;
  private NetAddress remoteLocation;
  private OscMessage msg;
  private OscP5 oscP5;
  
  //Constructor for the INDIVIDUAL mode
  MainScene(PApplet parent,NetAddress remoteLocation, OscP5 oscP5){
    
    cP5 = new ControlP5(parent);
    this.remoteLocation = remoteLocation;
    this.msg = new OscMessage("/chord");
    this.oscP5 = oscP5;
    
    createChordLayout();
  }
  
  //Constructor for the COLLLABORATIVE mode (different for the host)
  MainScene(PApplet parent,NetAddress remoteLocation, OscP5 oscP5, boolean host){
    
    cP5 = new ControlP5(parent);
    this.remoteLocation = remoteLocation;
    this.msg = new OscMessage("/chord");
    this.oscP5 = oscP5;   
    
    if(host){
      //Set the host layout
      createChordLayout();
      chordChoice.setPosition(120, 195);
      chordLabel.setPosition(395, (195-(maj.getHeight()/3)));
      
      createParametersLayout();
      parameterChoice.setPosition(80, 370);
      parameterLabel.setPosition(370, (370-(harmony.getHeight()/3)));
    }
    else{
      //Set the non-host layout
      createParametersLayout();
      parameterChoice.setPosition(80, 270);
      parameterLabel.setPosition(370, (270-(harmony.getHeight()/2)));
    }
  }
  
  //Create the chord selection layout
  private void createChordLayout(){
    
    //MAJOR button setup
    maj = cP5.addToggle("MAJ")
      .setSize(130, 90)
      .setFont(font)
      .setState(true)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            setSemitones(4, 7);
          }
      });
    l = maj.getCaptionLabel();
    l.align(CENTER, CENTER);
  
    //MINOR button setup
    min = cP5.addToggle("MIN")
      .setSize(130, 90)
      .setFont(font)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            setSemitones(3, 7);
          }
      });
    l = min.getCaptionLabel();
    l.align(CENTER, CENTER);
  
    //AUGMENTED button setup  
    aug = cP5.addToggle("AUG")
      .setSize(130, 90)
      .setFont(font)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            setSemitones(4, 8);
          }
      });
    l = aug.getCaptionLabel();
    l.align(CENTER, CENTER);
  
    //DIMINISHED button setup  
    dim = cP5.addToggle("DIM")
      .setSize(130, 90)
      .setFont(font)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            setSemitones(3, 6);
          }
      });
    l = dim.getCaptionLabel();
    l.align(CENTER, CENTER);
    
    //CHORD label setup
    chordLabel = cP5.addLabel("CHORD")
      .setFont(font)
      .setPosition(775-45, (250-(maj.getHeight()/2)));
   
    //Adding all buttons to the same Radio Group (so that activating one button will deactivate the others)
    chordChoice = cP5.addRadioButton("chord")
      .setPosition(775-320, 250)
      .setSize(130, 90)
      .setItemsPerRow(4)
      .setSpacingColumn(40)
      .addItem(maj, 1)
      .addItem(min, 2)
      .addItem(aug, 3)
      .addItem(dim, 4);
  }
  
  //Create the parameters selection layout
  private void createParametersLayout(){
    
    //HARMONY button setup
    harmony = cP5.addToggle("HARMONY")
      .setSize(150, 90)
      .setFont(font)
      .setState(true)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            selectedParam = 0;
          }
      });
    l = harmony.getCaptionLabel();
    l.align(CENTER, CENTER);
  
    //GRAIN button setup
    grain = cP5.addToggle("GRAIN")
      .setSize(150, 90)
      .setFont(font)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            selectedParam = 1;
          }
      });;
    l = grain.getCaptionLabel();
    l.align(CENTER, CENTER);
  
    //REVERB button setup  
    reverb = cP5.addToggle("REVERB")
      .setSize(150, 90)
      .setFont(font)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            selectedParam = 2;
          }
      });;
    l = reverb.getCaptionLabel();
    l.align(CENTER, CENTER);
  
    //DELAY button setup  
    delay = cP5.addToggle("DELAY")
      .setSize(150, 90)
      .setFont(font)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            selectedParam = 3;
          }
      });
    l = delay.getCaptionLabel();
    l.align(CENTER, CENTER);
    
    //PARAMETER label setup
    parameterLabel = cP5.addLabel("PARAMETER")
      .setFont(font)
      .setPosition(775-45, (250-(harmony.getHeight()/2)));
   
    //Adding all buttons to the same Radio Group (so that activating one button will deactivate the others)
    parameterChoice = cP5.addRadioButton("parameter")
      .setPosition(775-320, 250)
      .setSize(150, 90)
      .setItemsPerRow(4)
      .setSpacingColumn(40)
      .addItem(harmony, 1)
      .addItem(grain, 2)
      .addItem(reverb, 3)
      .addItem(delay, 4);
  }
  
  //Set the intervals from the fundamental
  private void setSemitones(int first, int second){
    semitones[0] = first;
    semitones[1] = second;
    print(semitones[0]);
    print(semitones[1]);
    //SEND OSC MESSAGE
    msg.add(semitones);
    msg.print();
    oscP5.send(msg, remoteLocation);
    msg.clearArguments();
  }
 

}
