 import javax.swing.JOptionPane;
 import javax.swing.JDialog;
PImage mouse; PImage iconUM;
PFont font1; PFont font2;
Progress p1; Gui g1; Bios b1;
boolean run = false;
boolean loading = false;
boolean guiscreen = false;
boolean biosscreen = true;
int newTime; 
int h; int m; int s;
int tempX; int tempY;
boolean flash = false;
int stamp = 1;

void setup() {
 fullScreen();
 background(0);
 pixelDensity(1);
 iconUM = loadImage("iconUM.png");
 surface.setIcon(iconUM);
 mouse = loadImage("cursor16.png");
 //cursor(mouse);
 noCursor();
 font1 = createFont("AcPlus_IBM_VGA_8x16.ttf", 20);
 font2 = createFont("IBMPlexSans-Medium.ttf", 20);
 p1 = new Progress(); g1 = new Gui(); b1 = new Bios();
 h = hour(); m = minute(); s = second();
 newTime = millis();
}

void draw() {
  
  if (run) {
   exit(); 
  }
  
  if (biosscreen) {
    b1.display();
  }

  if (loading) {
   p1.display(); 
   p1.animate();
  }
  
  if (!guiscreen) {
    tempX = mouseX; tempY = mouseY;
  }
  
  if (guiscreen) {
    g1.display();
    g1.animate();
  }
  
}

void keyPressed(){
  if (biosscreen && millis() > newTime + 8100) {
    biosscreen = false;
    loading = true;
    flash = false;
    stamp = 1;
  }
}
