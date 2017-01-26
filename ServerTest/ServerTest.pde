import processing.net.*;
import g4p_controls.*;
import java.awt.Font;

PImage bg;
PImage button;

PFont font;

Server s;
Client c;

GTextField txf1;
GImageButton btnStart;

String input;
int data[];
int videoEnc = 0;
int slide = 0;
int dimming = 0;
int i = 0;
int k = 0;
int firstloop = 1;
int controlStart = 0;
boolean clear = false;
int character = 0;
int characterSel = 0;

void setup() 
{
  bg = loadImage("BGSlide.jpg");
  button = loadImage("button.png");
  badge1 = loadImage("badge1.png");
  badge2 = loadImage("badge2.png");
  badge3 = loadImage("badge3.png");
  badge4 = loadImage("badge4.png");
  badge5 = loadImage("badge5.png");
  badge6 = loadImage("badge6.png");
  badgeBlank = loadImage("badgeBlank.png");

  fullScreen();
  stroke(255);

  s = new Server(this, 12345, "192.168.1.3"); // Start a simple server on a port

  txf1 = new GTextField(this, 1188, 151, 200, 40);
  txf1.setFont(new Font("Tungsten-Semibold", Font.PLAIN, 36));
  txf1.tag = "txf1";
  txf1.setPromptText("");

  String[] files;
  files = new String[] { 
    "button.png", "button.png", "button.png"
  };
  btnStart = new GImageButton(this, 1632, 100, files);
}

void draw() {
  background(bg);

  if (slide == 1) {
    if (clear == false) {
      s.write("clear" + " " + "control" + "\n");
      clear = true;
    }
    strobeCircle(1);
    showSlide1();
  }

  if (slide == 2) {
    strobeCircle(1);
    showSlide2();
    if (j > 110) {
      strobeCircle(0);
      slide = 3;
    }
  }

  if (slide == 3) {
    if (characterSel == 0) {
      character = character + 2;
      if (character < 7) {
        s.write(character + " " + "charsel" + "\n");
      } else {
        character = character - 5;
        s.write(character + " " + "charsel" + "\n");
      }
      characterSel = 1;
    }
    strobeCircle(1);
    showSlide3();
    if (j > 110) {
      strobeCircle(0);
      slide = 4;
    }
  }

  if (slide == 4) {
    strobeCircle(1);
    showSlide4();
    if (j > 110) {
      strobeCircle(0);
      slide = 5;
    }
  }

  if (slide == 5) {
    if (clear == true) {
      s.write("clear" + " " + "control" + "\n");
      clear = false;
    }
    if (controlStart == 0) {
      s.write("start" + " " + "control" + "\n");
      println("Sent start recording command");
      controlStart = 1;
    }
    strobeCircle(1);
    showSlide5();
    if (j > 110) {
      strobeCircle(0);
      slide = 6;
    }
  }

  if (slide == 6) {
    dimScreen();
    showSlide6();
    j=j+2;
    if (j > 110) {
      strobeCircle(0);
      slide = 5;
      k++;
      if (k > 5) {
        slide = 7;
      }
    }
  }
  if (slide == 7) {
    if (controlStart == 1) {
      s.write("stop" + " " + "control" + "\n");
      println("Sent stop recording command");
      controlStart = 0;
    }
    if (clear == false) {
      s.write("clear" + " " + "control" + "\n");
      clear = true;
    }
    strobeCircle(1);
    showSlide7();
    if (j > 300) {
      s.write("scan" + " " + "scan" + "\n");
      println("Sent Scan Command");
      strobeCircle(0);
      slide = 0;
      k = 0;
      characterSel = 0;
      txf1.setText("");
      if (clear == true) {
        s.write("clear" + " " + "control" + "\n");
        clear = false;
      }
    }
  }
}


public void handleButtonEvents(GImageButton button, GEvent event) {
  if (event == GEvent.CLICKED) {
    String badgeID = txf1.getText();
    s.write(badgeID + " " + "badge" + "\n");
    print("Sent: ");
    print(badgeID);
    println(" as badgeID");
    slide = 1;
  }
}