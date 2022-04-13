class Gui {
  
  // for final positions of the mouse animation
  // (centre of the "Cancel" text)
  int endX = width/2 +65; 
  int endY = height/2 +18;
  // to time mouse taker over
  int timer;
  // to finish and return to BIOS screen
  int wait;
  // for the position of dialog boxes from the user's OS
  int cornerX; int cornerY;
  int centreX; int centreY;
  // for the noise 
  PShape[] sqs;
  PShape sq;
  float zTime = 0.0;

 Gui() {
   // set array size and fill with PShapes
   sqs = new PShape[width*height/20];
   // put a square in each array location
   for (int i = 0; i < sqs.length; i++) {
    sqs[i] = createShape(RECT, 0, 0, 20, 20);
    sqs[i].setStroke(false);
   }
 }
  
 void display() {
  // set brightness values (using Perlin noise) for the squares in the array
  // and draw the shapes from the array
  int p = 0;
  int xpos = 0;
  int ypos = 0;
  float xoff = 0.0;
  for (int x = 0; x < width/20; x++) {
    float yoff = 0.0;
    for (int y = 0; y < height/20; y++) {
      float bright = map(noise(xoff, yoff, zTime), 0, 1, 0, 255);
      sqs[p].setFill(color(bright));
      shape(sqs[p], xpos, ypos);
      p++;
      yoff += 0.01;
      ypos += 20;
     }
    xoff += 0.01;
    ypos = 0;
    xpos += 20;
   }
  zTime += 0.01;
  // dialogue box
  // to only appear after prohibition() and doublecheck()
  if (timer > 15) {
  rectMode(CENTER);
  noStroke();
  fill(50);
  rect(width/2, height/2, 350, 170, 7);
  // text message question
  textFont(font2);
  textAlign(CENTER, CENTER);
  textSize(18);
  fill(255);
  text("Ultimate Machine", width/2, height/2 -45);
  // user option boxes
  rectMode(CORNER);
  fill(100);
  rect(width/2 -100, height/2, 70, 30, 7);
  rect(width/2 +30, height/2, 70, 30, 7);
  fill(255);
  textSize(16);
  text("Run", width/2 -65, height/2 +12);
  text("Cancel", width/2 +65, height/2 +12);
  }
 }
 
 void animate() {
   // start timer
   timer ++;
   if (timer == 10) {
     prohibition();
   }
   // during the time user is in control
   if (timer > 11 && timer < 1200) {
     // repel from top edge 'Run' button, if user puts mouse into this area
     if ((mouseX > width/2 -99) && (mouseX < width/2 -26) && (mouseY > height/2 +4) && (mouseY < height/2 +38))  {
         // hide mouse and replace with pointer image
         //noCursor();
         imageMode(CENTER);
         image(mouse, tempX, tempY);
       // otherwise use pointer image for user's mouse position 
      } else {
         //cursor(mouse);
         imageMode(CENTER);
         image(mouse, mouseX, mouseY);
         imageMode(CORNER);
     // and keep track of mouse position  
         tempX = mouseX; tempY = mouseY;
      }
     // return to BIOS if user clicks on 'Cancel' button
     if ((mousePressed) && (mouseX > width/2 +30) && (mouseX < width/2 +100) && (mouseY > height/2) && (mouseY < height/2 +30)) {
         // redraw button as highlighted ('pressed')
         rectMode(CORNER);
         fill(200);
         rect(width/2 +30, height/2, 70, 30, 7);
         fill(0);
         textAlign(CENTER,CENTER);
         textFont(font2);
         textSize(16);
         text("Cancel", width/2 +65, height/2 +12);
         // redraw pointer for final part of animation
         //cursor(mouse);
         image(mouse, mouseX, mouseY);
         // return to the BIOS screen  
         guiscreen = false;
         biosscreen = true;
         // reset the GUI timer
         timer = 0;
         // reset wait time
         wait = 0;
         // reset parameters for the BIOS screen
         imageMode(CORNER);
         h = hour(); m = minute(); s = second();
         newTime = millis();  
     }
   }
   
   // animate the 'mouse' to "Cancel" button after user's time is up
   if (timer >= 1200) {
   // hide mouse and replace with pointer image
   //noCursor();
   //imageMode(CORNER);
   imageMode(CENTER);
   image(mouse, tempX, tempY);
          if (tempX > endX) {
        tempX = tempX - 1;
       }
         if (tempX < endX) {
        tempX = tempX + 1;
       }
         if (tempY > endY) {
        tempY = tempY - 1;
       }
         if (tempY < endY) {
        tempY = tempY + 1;
       }
       // set wait time from when pointer is at a pixel next to end position
       if ( ((tempX == endX -1) && (tempY == endY -1)) || ((tempX == endX -1) && (tempY == endY)) || ((tempX == endX -1) && (tempY == endY +1)) || ((tempX == endX) && (tempY == endY -1)) || ((tempX == endX) && (tempY == endY +1)) || ((tempX == endX +1) && (tempY == endY -1)) || ((tempX == endX +1) && (tempY == endY)) || ((tempX == endX +1) && (tempY == endY -1)) ) {
         wait = millis() + 500;
       }
          // when pointer arrives at final position
       if ((tempX == endX) && (tempY == endY)) {
         // redraw button as highlighted ('pressed')
         rectMode(CORNER);
         fill(200);
         rect(width/2 +30, height/2, 70, 30, 7);
         fill(0);
         textAlign(CENTER,CENTER);
         textFont(font2);
         textSize(16);
         text("Cancel", width/2 +65, height/2 +12);
         // redraw pointer for final part of animation
         image(mouse, tempX, tempY);  
        // wait before finishing to show button as 'pressed'
          if (millis() > wait) {
             // return to the BIOS screen  
             guiscreen = false;
             biosscreen = true;
             // reset the GUI timer
             timer = 0;
             // reset parameters for the BIOS screen
             h = hour(); m = minute(); s = second();
             newTime = millis();
             }   
         } 
   }
   
 }
 
 void prohibition() {
  // for the screen coordinates of the 'fullscreen' area
  java.awt.Frame frame = ( (processing.awt.PSurfaceAWT.SmoothCanvas) ((processing.awt.PSurfaceAWT)surface).getNative()).getFrame();
  java.awt.Point point = frame.getLocationOnScreen();
  cornerX = point.x;
  cornerY = point.y;
  centreX = cornerX + width/2;
  centreY = cornerY + height/2;
  // dailog box from user's OS
  JOptionPane warning;
  warning = new JOptionPane ( 
    new String("You are prohibited from accessing this legacy system."),
    JOptionPane.WARNING_MESSAGE
    ); 
  warning.setOptions(new Object[] {"Ignore", "Cancel"});
  warning.setInitialValue("Cancel");
  JDialog prohibition = warning.createDialog("Ultimate Machine");
  //prohibition.setSize(400, 100);
  int w = prohibition.getWidth();
  int h = prohibition.getHeight();
  prohibition.setLocation(centreX -w/2, centreY -h/2);
  prohibition.setVisible(true);
  // get the input value from the user
  Object value = warning.getValue();
  if (value == "Ignore") {
    // show next dialog box
    doubleCheck();
  } else {
    // if 'Cancel' button pressed, window closed, or ESc
    // return to BIOS screen
    guiscreen = false;
    biosscreen = true;
    // reset GUI timer
    timer = 0;
    // reset parameters for the BIOS screen
    h = hour(); m = minute(); s = second();
    newTime = millis();
    }
 }
 
void doubleCheck() {
 JOptionPane check;
 check = new JOptionPane ( 
    new String("Consider running the Ultimate Machine?"),
    JOptionPane.PLAIN_MESSAGE
    ); 
  check.setOptions(new Object[] {"Yes", "No"});
  check.setInitialValue("No");
  JDialog doublecheck = check.createDialog("Ultimate Machine");
  //doublecheck.setSize(centreX -400, centreY -100);
  int w = doublecheck.getWidth();
  int h = doublecheck.getHeight();
  doublecheck.setLocation(centreX -w/2, centreY -h/2);
  doublecheck.setVisible(true);
  // get the input value from the user
  Object value = check.getValue();
  if (value == "Yes") {
    // closes window, back to GUI
  } else {
    // return to BIOS screen
        guiscreen = false;
    biosscreen = true;
    // reset GUI timer
    timer = 0;
    // reset parameters for the BIOS screen
    h = hour(); m = minute(); s = second();
    newTime = millis();
  }
 }
 
}
