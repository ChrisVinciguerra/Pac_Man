public int[][] board;
public ArrayList<Ghost> ghosts;
public int powerUp;
public PacMan pacman;
public int boardNumber;
private int gridSize = 30;
public int score;



void setup() {
  size(780, 870);
  board = new int[][] {
    //Represents a Pac-Man board to check for wall collisions. 0 = wall, 1=food, 2=powerup, 3=open space, 4=ghost box
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, //0
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}, //1
    {2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2}, //2
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}, //3
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, //4
    {1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1}, //5
    {1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1}, //6
    {1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1}, //7
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}, //8
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}, //9
    {0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0}, //10
    {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 4, 4, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0}, //11
    {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 4, 4, 4, 4, 4, 4, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0}, //12
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 4, 4, 4, 4, 4, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1}, //13
    {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 4, 4, 4, 4, 4, 4, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0}, //14
    {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0}, //15
    {0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0}, //16
    {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0}, //17
    {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0}, //18
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, //19
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}, //20
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}, //21
    {2, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 2}, //22
    {0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0}, //23
    {0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0}, //24
    {1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1}, //25
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, //26
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, //27
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, //28
  };
  //Create the Pac-Man and create ghosts
  pacman = new PacMan();
  ghosts = new ArrayList();
  ghosts.add(new Ghost(new PVector(12, 13), color(255, 0, 0), 4));
  ghosts.add(new Ghost(new PVector(13, 13), color(200, 0, 100), 10));
  ghosts.add(new Ghost(new PVector(12, 14), color(200, 150, 0), 10));
  ghosts.add(new Ghost(new PVector(13, 14), color(100, 20, 20), 10));
  boardNumber = 1;

  score = 0;
  //Set the time powered up to 0
  powerUp = 0;
}

void draw() {
  //Run through a tick of all game objects to make them move
  tick();

  //Draw to screen
  background(255, 255, 255);
  fill(255, 255, 255);
  //Draw walls and food
  for (int r = 0; r <board.length; r++) {
    for (int c = 0; c<board[0].length; c++) {
      fill(255, 255, 255);
      //Draw walls
      if (board[r][c] == 0) {        
        fill(0, 0, 200);
        rect(gridSize*c, gridSize*r, gridSize, gridSize);
        //Draw food
      } else if (board[r][c] == 1) {
        circle(gridSize*c+gridSize/2, gridSize*r+ gridSize/2, gridSize/5);
        //Draw power-ups
      } else if (board[r][c]==2) {
        circle(gridSize*c+gridSize/2, gridSize*r+ gridSize/2, gridSize/2);
      }
    }
  }

  //Draw pacman and ghosts
  pacman.draw();
  for (Ghost i : ghosts) {
    i.draw();
  }
}

//Send a new direction to Pac-Man whenever an arrow key is pressed to "store" a turn for whenever he can turn
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      pacman.queueTurn(new PVector(0, -1));
    } else if (keyCode == DOWN) {
      pacman.queueTurn(new PVector(0, 1));
    } else if (keyCode == LEFT) {
      pacman.queueTurn(new PVector(-1, 0));
    } else if (keyCode == RIGHT) {
      pacman.queueTurn(new PVector(1, 0));
    }
  }
}

//Call tick methods of Pac-Man and ghosts and check the status of the game
void tick() {
  pacman.tick();
  for (Ghost i : ghosts) {
    i.tick();
  }
  checkGame();
  println(powerUp);
  powerUp = powerUp > 0? powerUp-1: 0;
}

//Check if the game is won or lost
void checkGame() {
  boolean restart = true;
  for (int r = 0; r<board.length; r++) {
    for (int c = 0; c<board[0].length; c++) {
      //Check to see if any food is left on the board
      if (board[r][c]==1||board[r][c]==2) {
        restart=false;
      }
    }
  }
  //Check for collisions with ghosts
  for (int i = 0; i<ghosts.size(); i++) {
    if (pacman.getPos().dist(ghosts.get(i).getPos())<.5) {
      if (powerUp>0) {
        ghosts.set(i, new Ghost(new PVector(12, 13), color(255, 0, 0), 5));
      } else {
        setup();
      }
    }
  }
}
