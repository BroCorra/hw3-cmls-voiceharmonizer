import controlP5.*;

class MainScene{
  
  RadioButton chordChoice;
  private Toggle maj, min, aug, dim;
  private ControlP5 cP5;
  controlP5.Label l;
  
  MainScene(PApplet parent){
    
    cP5 = new ControlP5(parent);
    
    //MAJOR button setup
    maj = cP5.addToggle("MAJ")
      .setSize(130, 90)
      .setFont(font)
      .setState(true)
      .onRelease(new CallbackListener() { // add the Callback Listener to the button 
          public void controlEvent(CallbackEvent theEvent) {
            setSemitones(4, 7);
          }
      });;
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
      });;
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
      });;
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
    cP5.addLabel("CHORD")
      .setFont(font)
      .setPosition(775-45, (210-(maj.getHeight()/2)));
   
    //Adding all buttons to the same Radio Group (so that activating one button will deactivate the others)
    chordChoice = cP5.addRadioButton("chord")
      .setPosition(775-320, 210)
      .setSize(130, 90)
      .setItemsPerRow(4)
      .setSpacingColumn(40)
      .addItem(maj, 1)
      .addItem(min, 2)
      .addItem(aug, 3)
      .addItem(dim, 4);
  }
  
  //Set the intervals from the fundamental
  private void setSemitones(int first, int second){
    semitones[0] = first;
    semitones[1] = second;
    print(semitones[0]);
    print(semitones[1]);
    //SEND OSC MESSAGE
  }

}
