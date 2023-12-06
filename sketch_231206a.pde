float playerSize = 30;
float monsterSize = 30;
float treasureSize = 30;
float playerX, playerY; // Játékos pozíciója
float monsterX, monsterY; // Szörny pozíciója
float treasureX, treasureY; // Kincsesláda pozíciója
float gameAreaX, gameAreaY, gameAreaWidth, gameAreaHeight;
int playerRoomRow, playerRoomCol, monsterRoomRow, monsterRoomCol, treasureRoomRow, treasureRoomCol;
boolean gameWon = false;
boolean gameLost = false;
boolean playerMove = true; // Ez szabályozza, hogy a játékos vagy a szörny mozogjon-e

void setup() {
  size(600, 600);
  restartGame();
}

void restartGame() {
  // Inicializálás
  gameAreaWidth = 550;
  gameAreaHeight = 550;
  gameAreaX = (width - gameAreaWidth) / 2;
  gameAreaY = (height - gameAreaHeight) / 2;
  gameWon = false;
  gameLost = false;

  // Véletlenszerű sarok kiválasztása a játékosnak
  int randomCorner = int(random(4));
  switch (randomCorner) {
    case 0:
      playerRoomRow = 0;
      playerRoomCol = 0;
      break;
    case 1:
      playerRoomRow = 0;
      playerRoomCol = 3;
      break;
    case 2:
      playerRoomRow = 3;
      playerRoomCol = 0;
      break;
    case 3:
      playerRoomRow = 3;
      playerRoomCol = 3;
      break;
  }

  // Játékos a szoba közepén
  playerX = gameAreaX + (playerRoomCol + 0.5) * (gameAreaWidth / 4);
  playerY = gameAreaY + (playerRoomRow + 0.5) * (gameAreaHeight / 4);

  // Véletlenszerű sarok kiválasztása a szörnynek (ne kerüljön a játékos mellé)
  do {
    monsterRoomRow = int(random(4));
    monsterRoomCol = int(random(4));
  } while (monsterRoomRow == playerRoomRow && monsterRoomCol == playerRoomCol);

  // Véletlenszerű sarok kiválasztása a kincsesládának (mindig a játékossal szembeni sarokba)
  treasureRoomRow = 3 - playerRoomRow;
  treasureRoomCol = 3 - playerRoomCol;

  // Szörny a szoba közepén
  monsterX = gameAreaX + (monsterRoomCol + 0.5) * (gameAreaWidth / 4);
  monsterY = gameAreaY + (monsterRoomRow + 0.5) * (gameAreaHeight / 4);

  // Kincsesláda a szoba közepén
  treasureX = gameAreaX + (treasureRoomCol + 0.5) * (gameAreaWidth / 4);
  treasureY = gameAreaY + (treasureRoomRow + 0.5) * (gameAreaHeight / 4);
}

void draw() {
  background(255); // Fehér háttér az ablaknak

  // Szürke játékterület középen az ablakban
  fill(200);
  rect(gameAreaX, gameAreaY, gameAreaWidth, gameAreaHeight);

  // 4x4-es területek osztása fekete vonalakkal
  stroke(0); // Fekete vonalak
  float cellSize = gameAreaWidth / 4;
  for (int i = 1; i < 4; i++) {
    // Függőleges vonalak (ajtók kialakítása)
    line(gameAreaX + i * cellSize, gameAreaY, gameAreaX + i * cellSize, gameAreaY + gameAreaHeight);
    // Vízszintes vonalak (ajtók kialakítása)
    line(gameAreaX, gameAreaY + i * cellSize, gameAreaX + gameAreaWidth, gameAreaY + i * cellSize);
  }

  // Játékos rajzolása aqua kék színnel
  fill(0, 255, 255); // Aqua kék szín
  ellipse(playerX, playerY, playerSize, playerSize);

  // Szörny rajzolása piros színnel
  fill(255, 0, 0); // Piros szín
  ellipse(monsterX, monsterY, monsterSize, monsterSize);

  // Kincsesláda rajzolása sárga színnel
  fill(255, 255, 0); // Sárga szín
  ellipse(treasureX, treasureY, treasureSize, treasureSize);

  // Győzelem szöveg megjelenítése, ha a játékos elért a kincsesládához
  if (gameWon) {
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("GYŐZTÉL!", width / 2, height / 2);
  }

  // Vesztés szöveg megjelenítése, ha a szörny elkapta a játékost
  if (gameLost) {
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("VESZTETTÉL!", width / 2, height / 2);
  }
}

void keyPressed() {
  if (!gameLost) {
    // Ellenőrizzük, hogy a játékos az ajtón belülre kattintott-e
    if (playerX > (width - 550) / 2 && playerX < (width + 550) / 2 &&
        playerY > (height - 550) / 2 && playerY < (height + 550) / 2 && !gameWon) {
      // Ha igen, akkor lekezeljük a billentyű lenyomást és mozgatjuk a játékost
      if ((key == 'W' || keyCode == UP) && playerRoomRow > 0) {
        playerY -= gameAreaHeight / 4;
        playerRoomRow--;
      } else if ((key == 'S' || keyCode == DOWN) && playerRoomRow < 3) {
        playerY += gameAreaHeight / 4;
        playerRoomRow++;
      } else if ((key == 'A' || keyCode == LEFT) && playerRoomCol > 0) {
        playerX -= gameAreaWidth / 4;
        playerRoomCol--;
      } else if ((key == 'D' || keyCode == RIGHT) && playerRoomCol < 3) {
        playerX += gameAreaWidth / 4;
        playerRoomCol++;
      }

      // Ellenőrizzük, hogy a játékos elért-e a kincsesládához
      if (playerRoomRow == treasureRoomRow && playerRoomCol == treasureRoomCol) {
        gameWon = true;
      }

      // Ellenőrizzük, hogy a szörny elkapta-e a játékost
      if (playerRoomRow == monsterRoomRow && playerRoomCol == monsterRoomCol) {
        gameLost = true;
      }

      // Szörny követi a játékost minden lépés után
      if (!gameWon) {
        float playerDeltaX = playerX - monsterX;
        float playerDeltaY = playerY - monsterY;

        // Válaszd ki a követendő irányt a játékostól a szörny felé
        if (abs(playerDeltaX) > abs(playerDeltaY)) {
          // Mozgás vízszintesen
          if (playerDeltaX < 0 && monsterRoomCol > 0) {
            monsterX -= gameAreaWidth / 4;
            monsterRoomCol--;
          } else if (playerDeltaX > 0 && monsterRoomCol < 3) {
            monsterX += gameAreaWidth / 4;
            monsterRoomCol++;
          }
        } else {
          // Mozgás függőlegesen
          if (playerDeltaY < 0 && monsterRoomRow > 0) {
            monsterY -= gameAreaHeight / 4;
            monsterRoomRow--;
          } else if (playerDeltaY > 0 && monsterRoomRow < 3) {
            monsterY += gameAreaHeight / 4;
            monsterRoomRow++;
          }

          // Ellenőrizzük, hogy a szörny elkapta-e a játékost
          if (playerRoomRow == monsterRoomRow && playerRoomCol == monsterRoomCol) {
            gameLost = true;
          }
        }
      }
    }
  }
}

void mousePressed() {
  // Ellenőrizzük, hogy a játékos az ajtón belülre kattintott-e
  if (playerX > (width - 550) / 2 && playerX < (width + 550) / 2 &&
      playerY > (height - 550) / 2 && playerY < (height + 550) / 2 && (gameWon || gameLost)) {
    // Ha igen, akkor újrakezdjük a játékot
    restartGame();
  }
}
