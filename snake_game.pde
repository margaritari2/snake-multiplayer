// by Eleanor Kuchar
// ignore the placeholder thing; i will delete it once i get multi-snake collisions to work

int w=1300;
int h=700;

int state = 0; 
// 0 = game 
// 1 = win1 
// 2 = win2

int maxScore = 10;

int wallX, wallY;
int backgroundColor = 225;
int topColor = 0;
boolean day = false;

float speed;
int score1;
int score2;

int move1X = 0;
int move1Y = 0;
int move2X = 0;
int move2Y = 0;
int snake1X = -5; //head location
int snake1Y = -5;
int snake2X = -5;
int snake2Y = -5;
int foodX = -5; //food location
int foodY = -5;
int X = 0;
int Y = 0;
boolean check = true;
int snake1Size = 1;
int snake2Size = 1;
int windowSizeX = 1300;
int windowSizeY = 700;
boolean win1 = false;
boolean win2 = false;
boolean placeholder = false;

int color1;
int color2;

int[] snakes1X=new int[10000];
int[] snakes1Y=new int[10000];
int[] snakes2X=new int[10000];
int[] snakes2Y=new int[10000];

void gameReset () {
  move1X = 0;
  move1Y = 0;
  move2X = 0;
  move2Y = 0;
  X = 0;
  Y = 0;
  setup();
}

void setup() {
  score1 = 0;
  score2 = 0;
  speed = 15;
  snake1X = width/3;
  snake1Y = 350;
  snake2X = 2*width/3;
  snake2Y = 350;
  win1 = false;
  win2 = false;
  check = true;
  snake1Size = 1;
  snake2Size = 1;
  size(1300, 700); //window size
  color1=color(random(10, 225), random(10, 255), random(10, 255));
  color2=color(random(10, 225), random(10, 255), random(10, 255));
}



void draw() {

  background(backgroundColor);
  if (state == 0) {
    startGame(); //|
    //|
    //v 

    fill(color1);
    textSize(32);
    text(score1, width / 3, 100); //score
    textSize(15);
    text("Score:", width / 3 - 9, 60);

    fill(color2);
    textSize(32);
    text(score2, 2* width / 3, 100); //score
    textSize(15);
    text("Score:", 2* width / 3 - 9, 60);
  }
  if (state == 1) win1(); 
  if (state == 2) win2();
}

///////////////////////////////////// day / night //////////////////////////////////////

void mouseClicked() {
  if (day == true) {
    day = false;
  } else if (day == false) {
    day = true;
  }

  if (day == true) {
    backgroundColor = 225;
    topColor = 0;
  } else if (day == false) {
    backgroundColor = 0;
    topColor = 225;
  }
}

///////////////////////////////////////////////////////////////////////////////////////

void startGame() {
  drawSnake1();
  drawSnake2();
  if (win1==false && win2==false) {
    drawFood();
    snake1Move();
    ateFood1();
    checkcollision1();
    snake2Move();
    ateFood2();
    checkcollision2();
    hitWall();
  }
}

/////////////////////////////////////// game end ///////////////////////////////////////

void checkcollision1() {
  for (int i = 1; i < snake1Size; i++) {
    if (snake1X == snakes1X[i] && snake1Y== snakes1Y[i]) {state = 2;}
    if (snake2X>=snakes1X[i]&&snake2X<=snakes1X[i]+15&&snake2Y>=snakes1Y[i]
    &&snake2Y<=snakes1Y[i]||snake2X+20>=snakes1X[i]&&snake2X+20<=snakes1Y[i]+15&&
    snake2Y+20>=snakes1Y[i]&&snake2Y+20<=snakes1Y[i]+15||snake2X+10>=snakes1X[i]&&
    snake2X+10<=snakes1X[i]+15&&snake2Y+10>=snakes1Y[i]&&snake2Y+10<=snakes1Y[i]+15)
    placeholder=true;//{state = 1;}
  }
}
void checkcollision2() {
  for (int i = 1; i < snake2Size; i++) {
    if (snake2X == snakes2X[i] && snake2Y== snakes2Y[i]) {state = 1;}
    if (snake1X>=snakes2X[i]&&snake1X<=snakes2X[i]+15&&snake1Y>=snakes2Y[i]
    &&snake1Y<=snakes2Y[i]||snake1X+20>=snakes2X[i]&&snake1X+20<=snakes2Y[i]+15&&
    snake1Y+20>=snakes2Y[i]&&snake1Y+20<=snakes2Y[i]+15||snake1X+10>=snakes2X[i]&&
    snake1X+10<=snakes2X[i]+15&&snake1Y+10>=snakes2Y[i]&&snake1Y+10<=snakes2Y[i]+15)
   placeholder=true;//{state = 2;}
  }
}


void hitWall(){
  if (snake1X>windowSizeX||snake1X<5||snake1Y>windowSizeY||snake1Y<5) {
    state = 2;
  }
  else if (snake2X > windowSizeX || snake2X < 5||snake2Y > windowSizeY||snake2Y < 5) {
    state = 1;
  }
}



void win1() {
  fill(color1);
  textSize(100);
  text("YOU WIN!", width / 3, 200);
  move1X = 0;
  move2X = 0;
  move1Y = 0;
  move2Y = 0;
}

void win2() {
  fill(color2);
  textSize(100);
  text("YOU WIN!", width / 3, 200);
  move1X = 0;
  move2X = 0;
  move1Y = 0;
  move2Y = 0;
}


////////////////////////////////////// food ////////////////////////////////////////

void ateFood1() {
  if (snake1X>=foodX&&snake1X<=foodX+15&&snake1Y>=foodY&&snake1Y<=foodY+15
    ||snake1X+20>=foodX&&snake1X+20<=foodX+15&&snake1Y+20>=foodY
    &&snake1Y+20<=foodY+15||snake1X+10>=foodX&&snake1X+10<=foodX+15
    &&snake1Y+10>=foodY&&snake1Y+10<=foodY+15) {
    check = true;
    snake1Size+=7;
    speed*=1.13;
    score1++;
    if (score1 >= 10) {
      speed = 15 * pow(1.13, 10);
    }
  }
  if (score1 >= maxScore) {
    state = 1;
  }
}

void ateFood2() {
  if (snake2X>=foodX&&snake2X<=foodX+15&&snake2Y>=foodY&&snake2Y<=foodY+15
    ||snake2X+20>=foodX&&snake2X+20<=foodX+15&&snake2Y+20>=foodY
    &&snake2Y+20<=foodY+15||snake2X+10>=foodX&&snake2X+10<=foodX+15
    &&snake2Y+10>=foodY&&snake2Y+10<=foodY+15) {
    check = true;
    snake2Size+=7;
    speed*=1.13;
    score2++;
    if (score2 >= 10) {
      speed = 15 * pow(1.13, 10);
    }
  }
  if (score2 >= maxScore) {
    state = 2;
  }
}

void drawFood() {
  fill(topColor);
  while (check) {
    foodX = (int)random(50, 1250);
    foodY = (int)random(50, 650);
    for (int i = 0; i < snake1Size; i++) {
      if (foodX == snakes1X[i] && foodY == snakes1Y[i]) {
        check = true;
        i = snake1Size;
      }
    }
    for (int i = 0; i < snake2Size; i++) {
      if (foodX == snakes2X[i] && foodY == snakes2Y[i]) {
        check = true;
        i = snake2Size;
      } else {
        check = false;
      }
    }
  }
  rect(foodX, foodY, 15, 15);
}

////////////////////////////////////// snake 1 //////////////////////////////////////

void drawSnake1() {
  frameRate(speed);
  fill(color1);
  for (int i = 0; i < snake1Size; i++) {
    X = snakes1X[i];
    Y = snakes1Y[i];
    noStroke();
    rect(X, Y, 20, 20);
    if (win1 == true || win2 == true) {
      snakes1X[i] = 0; 
      snakes1Y[i] = 0;
    }
  }

  for ( int i=snake1Size; i>=0; i-- ) {
    snakes1X[i + 1]=snakes1X[i];
    snakes1Y[i + 1]=snakes1Y[i];
  }
}

void snake1Move() {
  snake1X += move1X;
  snake1Y += move1Y;
  snakes1X[0] = snake1X;
  snakes1Y[0] = snake1Y;
}

///////////////////////////////////////// snake 2 ////////////////////////////////////

void drawSnake2() {
  frameRate(speed);
  fill(color2);
  for (int i = 0; i < snake2Size; i++) {
    X = snakes2X[i];
    Y = snakes2Y[i];
    noStroke();
    rect(X, Y, 20, 20);
    if (win1 == true || win2 == true) {
      snakes2X[i] = 0; 
      snakes2Y[i] = 0;
    }
  }

  for ( int i=snake2Size; i>=0; i-- ) {
    snakes2X[i + 1]=snakes2X[i];
    snakes2Y[i + 1]=snakes2Y[i];
  }
}

void snake2Move() {
  snake2X += move2X;
  snake2Y += move2Y;
  snakes2X[0] = snake2X;
  snakes2Y[0] = snake2Y;
}

///////////////////////////////////////// snake movement //////////////////////////////

void keyPressed() {
  if (keyCode == SHIFT){
    state = 0;
    gameReset();
  }
  
  if (keyCode == UP) {  
    if (snakes1Y[1] != snakes1Y[0]-10) {
      move1Y = -10; 
      move1X = 0;
    }
  }
  if (keyCode == DOWN) {  
    if (snakes1Y[1] != snakes1Y[0]+10) {
      move1Y = 10; 
      move1X = 0;
    }
  }
  if (keyCode == LEFT) { 
    if (snakes1X[1] != snakes1X[0]-10) {
      move1X = -10; 
      move1Y = 0;
    }
  }
  if (keyCode == RIGHT) { 
    if (snakes1X[1] != snakes1X[0]+10) {
      move1X = 10; 
      move1Y = 0;
    }
  }


  if (key == 'w') {  
    if (snakes2Y[1] != snakes2Y[0]-10) {
      move2Y = -10; 
      move2X = 0;
    }
  }
  if (key == 's') {  
    if (snakes2Y[1] != snakes2Y[0]+10) {
      move2Y = 10; 
      move2X = 0;
    }
  }
  if (key == 'a') { 
    if (snakes2X[1] != snakes2X[0]-10) {
      move2X = -10; 
      move2Y = 0;
    }
  }
  if (key == 'd') { 
    if (snakes2X[1] != snakes2X[0]+10) {
      move2X = 10; 
      move2Y = 0;
    }
  }
}


////////////////////////////////////////////////////////////////////////////////////////

