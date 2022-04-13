class Bios {
  
  String prompt = "YOU MUST PRESS A KEY";
    
  Bios() { 
  }
     
 void display() {
     
  background(0);
  noCursor();
  textFont(font1);
  
  textAlign(LEFT);
  
  // time the different BIOS messages     
  if (millis() > newTime + 500) {
    text("Ultimate Machine BIOS", 20, 20);
  }
  if (millis() > newTime + 1000) {
    text("Copyright (C) Acme Corporation", 20, 40);
  }
  if (millis() > newTime + 1500) {
  text("Build date  "+nf(day(),2)+"/"+nf(month(),2)+"/"+year(), 20, 60);
  }
  if (millis() > newTime + 2000) {
  text("Build time  "+nf(h,2)+":"+nf(m,2)+":"+nf(s,2), 20, 80);
  }
  if (millis() > newTime + 2500) {
  text("Initializing obsessional neurosis...", 20, 120);
  }
  if (millis() > newTime + 3500) {
  text("Initializing obsessional neurosis... Done.", 20, 120);
  }
  if (millis() > newTime + 4000) {
  text("Prohibition installed.", 20, 140);
  }
  if (millis() > newTime + 4500) {
  text("Primordial origins = pseudorandom noise", 20, 180);
  }
  if (millis() > newTime + 5000) {
  text("System ID = The Rat Man in Silico", 20, 200);
  }
  if (millis() > newTime + 5500) {
   text("Mouse initialized.", 20, 240);  
  }
  if (millis() > newTime + 6000) {
  text("Auto-detecting lack in the Other...", 20, 280);
  }
  if (millis() > newTime + 7000) {
  text("Auto-detecting lack in the Other... Failed!", 20, 280);
  }
  if (millis() > newTime + 7500) {
  text("Auxiliary wetware:", 20, 320);  
  }
  if (millis() > newTime + 8000) {
  text(prompt, 20, 340);
  stamp++;
  }
  
  // flashing underscore for prompt (4 times per second)
  if (stamp%15 == 0) {
    flash = true;
  }
  if (stamp%30 == 0) {
    flash = false; 
  }
  // draw the thick underscore
  if (flash) {  
   fill(255);
   rectMode(CORNER); 
   rect(21+textWidth(prompt), 340, 14, 4);
     }
  // black rectangle to cover the underscore
  if (!flash) {
   fill(0);
   noStroke();
   rect(21+textWidth(prompt), 340, 14, 4);
  }

  // when user presses a key after prompt has appeared
  // keyPressed function will stop BIOS and go to progress/loading screen

  fill(255);
 }
 
}
