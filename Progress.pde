class Progress {
  
  String progressbox = "Progress";
  String halt = "Halt or loop? Dead or alive?";
  String vapour = "Vapourware. Procrastination.";
  Boolean changeText = false;
  int progressbar = 0;
  
  Progress() {
  }
  
  void display() {
  //cursor(mouse);
  background(0);
  image(mouse, mouseX, mouseY);
  // dialogue box
  noFill();
  stroke(255);
  strokeWeight(1);
  // drawing a box leaving out the 'progress' word
  beginShape();
  vertex(width/2 - textWidth(progressbox)/2 -10, height/2 -110);
  vertex(width/2 -225, height/2 -110);
  vertex(width/2 -225, height/2 +110);
  vertex(width/2 +225, height/2 +110);
  vertex(width/2 +225, height/2 -110);
  vertex(width/2 + textWidth(progressbox)/2 +10, height/2 -110);
  endShape();
  // text to align with rectangle's top line
  textFont(font1);
  textAlign(CENTER,CENTER);
  text(progressbox, width/2, height/2 -110);
  // text message inside the box
  if (!changeText) {
    text(halt, width/2, height/2 -20);
    } else {
    text(vapour, width/2, height/2 -20);
    }
  // box for progress bar
  rectMode(CENTER);
  rect(width/2, height/2 +55, 410, 20);
  }
  
  void animate() {
  // progress bar
  progressbar++; 
  rectMode(CORNER);
  fill(255);
  rect(width/2 -205, height/2 +45, progressbar, 20);
  // go to GUI when progress is complete  
  if (progressbar == 410) {
    loading = false;
    guiscreen = true;
    progressbar = 0;
    // switch the text message in the box
    if (!changeText) {
      changeText = true;
      } else {
        changeText = false;
      }
    }
  }
  
}
