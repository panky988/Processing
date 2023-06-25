float housePosX, housePosY, housePosZ;
float houseScale;
float houseRotX, houseRotY, houseRotZ;

void setup() {
  size(800, 600, P3D);
  init();
}

void init() {
  housePosX = -300;
  housePosY = -300;
  housePosZ = 0;
  houseScale = 1.0;
  houseRotX = 0;
  houseRotY = 0;
  houseRotZ = 0;
  
  int displayWidth = 600;
  int displayHeight = 400;
  int windowX = (width - displayWidth) / 2;
  int windowY = (height - displayHeight) / 2;
  surface.setLocation(windowX, windowY);
}

void draw() {
  background(255);
  translate(width / 2, height / 2);

  translate(housePosX, housePosY, housePosZ);
  
  rotateX(radians(houseRotX));
  rotateY(radians(houseRotY));
  rotateZ(radians(houseRotZ));
  
  scale(houseScale);
  
  drawHouse();
  
  drawGUI();
}

void drawHouse() {
  // Teto
  line3D(150, 100, 0, 80, 300, 50);
  line3D(150, 100, 0, 200, 250, -50);
  line3D(150, 100, 0, 400, 100, 0);
  line3D(400, 100, 0, 330, 300, 50);
  line3D(400, 100, 0, 450, 250, -50);
  line3D(200, 250, -50, 450, 250, -50);
  line3D(80, 300, 50, 330, 300, 50);

  // Falak
  line3D(80, 300, 50, 80, 450, 50);
  line3D(330, 300, 50, 330, 450, 50);
  line3D(200, 250, -50, 200, 400, -50);
  line3D(450, 250, -50, 450, 400, -50);

  // Alap
  line3D(80, 450, 50, 330, 450, 50);
  line3D(80, 450, 50, 200, 400, -50);
  line3D(450, 400, -50, 200, 400, -50);
  line3D(450, 400, -50, 330, 450, 50);
}

void line3D(float x1, float y1, float z1, float x2, float y2, float z2) {
  beginShape(LINES);
  vertex(x1, y1, z1);
  vertex(x2, y2, z2);
  endShape();
}

void drawGUI() {
  fill(0);
  textSize(16);
  textAlign(LEFT, TOP);
  text("Mozgatás: Q/W/E/R\nForgatás: O/P/Ő/Ú\nNagyítás/Kicsinyítés: U/I", 10, 10);
}

void keyPressed() {
  if (key == 'q') {
    housePosX -= 10;
  } else if (key == 'w') {
    housePosY -= 10;
  } else if (key == 'e') {
    housePosX += 10;
  } else if (key == 'r') {
    housePosY += 10;
  } else if (key == 't') {
    housePosZ -= 10;
  } else if (key == 'z') {
    housePosZ += 10;
  } else if (key == 'u') {
    houseScale -= 0.1;
  } else if (key == 'i') {
    houseScale += 0.1;
  } else if (key == 'o') {
    houseRotX -= 10;
  } else if (key == 'p') {
    houseRotX += 10;
  } else if (key == 'ő') {
    houseRotY += 10;
  } else if (key == 'ú') {
    houseRotY -= 10;
  }
}
