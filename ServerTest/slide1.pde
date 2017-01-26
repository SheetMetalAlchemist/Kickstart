PImage badge1;
PImage badge2;
PImage badge3;
PImage badge4;
PImage badge5;
PImage badge6;
PImage badgeBlank;

void showSlide1() {
  imageMode(CENTER);
  image(badge1, width/2, height/2);
}

void showSlide2() {
  imageMode(CENTER);
  image(badge2, width/2, height/2);
}

void showSlide3() {
  imageMode(CENTER);
  image(badge3, width/2, height/2);
}

void showSlide4() {
  imageMode(CENTER);
  image(badge4, width/2, height/2);
}

void showSlide5() {
  imageMode(CENTER);
  image(badge5, width/2, height/2);
}

void showSlide6() {
  imageMode(CENTER);
  image(badgeBlank, width/2, height/2);
}

void showSlide7() {
  imageMode(CENTER);
  image(badge6, width/2, height/2);
}

void mousePressed() {
  if (slide == 1) {
    strobeCircle(0);
    slide = 2;
  }
}