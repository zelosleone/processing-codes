PShape snake;
PShape food;
PImage backgroundImg;
int gridSize = 20;
int gridWidth;
int gridHeight;
int foodX;
int foodY;
int score;
int[] snakeX;
int[] snakeY;
int snakeLength;
int snakeDirection;
boolean gameOver;
boolean gamePaused;
boolean gameStarted;

void setup() {
  gameStarted = false;
  gamePaused = false;
  backgroundImg = loadImage("background.jpg");
  size(800, 800);
  gridWidth = width/gridSize;
  gridHeight = height/gridSize;
  snakeX = new int[gridWidth*gridHeight];
  snakeY = new int[gridWidth*gridHeight];
  snakeX[0] = gridWidth/2;
  snakeY[0] = gridHeight/2;
  snakeLength = 1;
  snakeDirection = 2;
  foodX = (int)random(gridWidth);
  foodY = (int)random(gridHeight);
  snake = createShape();
  snake.beginShape();
  snake = loadShape("snake.svg");
  snake.fill(color(255,0,0));
  snake.vertex(0,0);
  snake.vertex(gridSize,0);
  snake.vertex(gridSize,gridSize);
  snake.vertex(0,gridSize);
  snake.endShape();
  food = createShape();
  food.beginShape();
  food = loadShape("food.svg");
  food.fill(color(0,255,0));
  food.vertex(0,0);
  food.vertex(gridSize,0);
  food.vertex(gridSize,gridSize);
  food.vertex(0,gridSize);
  food.endShape();
    gameOver = false;
  frameRate(5);
}

void draw() {
  filter(POSTERIZE, 2);
  image(backgroundImg, 0, 0);
  
    if(!gameStarted){
        background(255);
        textSize(32);
        fill(0);
        text("Press to start the game", width/2, height/2);
        return;
    }
    if(gamePaused){
        background(255);
        textSize(32);
        fill(0);
        text("Game Paused", width/2, height/2);
        text("Press any key to continue", width/2, height/2+40);
        return;
    }
    if(gameOver){
        background(255,0,0);
        fill(255);
        textSize(32);
        textAlign(CENTER, CENTER);
        text("Game Over", width/2, height/2);
        text("Score: " + score, width/2, height/2 + 40);
        return;
    }
    background(255);
    drawFood();
    moveSnake();
    checkCollision();
    drawSnake();
    textSize(32);
    fill(0);
    text("Score: " + score, 10, 30);
}


void keyPressed() {
  if (!gameStarted) {
    gameStarted = true;
  }
  else if (key == 'p' || key == 'P') {
    gamePaused = !gamePaused;
  }
  else if (gamePaused) {
    return;
  }
  else if (keyCode == UP) {
    snakeDirection = 1;
  } else if (keyCode == RIGHT) {
    snakeDirection = 2;
  } else if (keyCode == DOWN) {
    snakeDirection = 3;
  } else if (keyCode == LEFT) {
    snakeDirection = 4;
  }
}

void drawFood() {
  shape(food, foodX*gridSize, foodY*gridSize);
}

void drawSnake() {
  for (int i = 0; i < snakeLength; i++) {
    shape(snake, snakeX[i]*gridSize, snakeY[i]*gridSize);
  }
}

void checkFoodCollision() {
  if (snakeX[0] == foodX && snakeY[0] == foodY) {
    foodX = (int)random(gridWidth);
    foodY = (int)random(gridHeight);
    snakeLength++;
    score++;
    frameRate(frameRate+1);
  }
}

void moveSnake() {
  for (int i = snakeLength-1; i > 0; i--) {
    snakeX[i] = snakeX[i-1];
    snakeY[i] = snakeY[i-1];
  }
  if (snakeDirection == 1) {
    snakeY[0]--;
  } else if (snakeDirection == 2) {
    snakeX[0]++;
  } else if (snakeDirection == 3) {
    snakeY[0]++;
  } else if (snakeDirection == 4) {
    snakeX[0]--;
  }
  checkFoodCollision();
}

void checkCollision() {
    if (snakeX[0] < 0 || snakeX[0] >= gridWidth || snakeY[0] < 0 || snakeY[0] >= gridHeight) {
          gameOver = true;
       }
  }
