float j = 0;

void strobeCircle(int ctrl) {
  if (ctrl == 1) {
    fill(0, 120);
    noStroke();
    rectMode(CENTER);
    rect(width/2, height/2, width, height);
    noFill();
    strokeWeight(6);

    pushMatrix();
    ellipseMode(CENTER);
    stroke(255, 80);
    translate(width/2, height/2);
    j = j+2;
    scale(j);
    ellipse(0, 0, 30, 30);      
    popMatrix();
  } else {
    j = 0;
  }
}

void dimScreen() {
  fill(0, 120);
  noStroke();
  rectMode(CENTER);
  rect(width/2, height/2, width, height);
}