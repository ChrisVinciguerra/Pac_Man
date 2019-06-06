private int gridSize = 30;

public int[][] board;
public ArrayList<Ghost> ghosts;
public PacMan pacman;

public int score = 0;



void setup() {
  size(1460, 920);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, 640, 360);
  video.start();
  trackColor = color(255, 0, 0);


  restart();
}

void restart() {
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
    {3, 3, 3, 3, 3, 1, 1, 1, 1, 0, 4, 4, 4, 4, 4, 4, 0, 1, 1, 1, 1, 3, 3, 3, 3, 3}, //13
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
  ghosts.add(new Ghost(new PVector(13, 13), color(200, 0, 100), 6));
  ghosts.add(new Ghost(new PVector(12, 14), color(200, 150, 0), 8));
  ghosts.add(new Ghost(new PVector(13, 14), color(100, 20, 20), 10));
}
void draw() {
  //Run through a tick of all game objects to make them move
  tick();

  //Draw to screen
  background(0, 0, 0);
  fill(255, 255, 255);
  //Draw walls and food
  for (int r = 0; r <board.length; r++) {
    for (int c = 0; c<board[0].length; c++) {
      fill(255, 255, 255);
      stroke(255, 255, 255);
      //Draw walls
      if (board[r][c] == 0) {        
        fill(0, 0, 200);
        stroke(0, 0, 200);
        rect(gridSize*c, gridSize*r+50, gridSize, gridSize);
        //Draw food
      } else if (board[r][c] == 1) {
        circle(gridSize*c+gridSize/2, gridSize*r+ gridSize/2+50, gridSize/5);
        //Draw power-ups
      } else if (board[r][c]==2) {
        circle(gridSize*c+gridSize/2, gridSize*r+ gridSize/2+50, gridSize/2);
      }
    }
  }

  //Draw pacman and ghosts
  pacman.draw();
  for (Ghost i : ghosts) {
    i.draw();
  }
  textSize(40);
  fill(255, 255, 255);
  text("Score: "+score, 20, 40);


  video.loadPixels();
  image(video, 780, 0);

  blobs.clear();


  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {

        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      }
    }
  }

  for (Blob b : blobs) {
    if (b.size() > 500) {
      b.show();
    }
  }
    checkTrack();
}

void checkTrack() {
  Blob largest = null;
  if (blobs.size()>0) {
    largest = blobs.get(0);
  } else {
    return;
  }

  for (Blob i : blobs) {
    if (i.size()>largest.size()) {
      largest = i;
    }
  }
  PVector middle = largest.getMiddle();
  rect(middle.x,middle.y, 20,20);
  println("X: "+middle.x);
  println("Y: "+middle.y);
  if (middle.x<200) {
    pacman.queueTurn(new PVector(-.1, 0));
    println("left");
  } else if (middle.x>580) {
    pacman.queueTurn(new PVector(.1, 0));
    println("right");
  } else if (middle.y<200) {
    pacman.queueTurn(new PVector(0, -.1));
    println("up");
  } else if (middle.y>720) {
    pacman.queueTurn(new PVector(0, .1));
    println("down");
  }
}

//Send a new direction to Pac-Man whenever an arrow key is pressed to "store" a turn for whenever he can turn
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      pacman.queueTurn(new PVector(0, -.1));
    } else if (keyCode == DOWN) {
      pacman.queueTurn(new PVector(0, .1));
    } else if (keyCode == LEFT) {
      pacman.queueTurn(new PVector(-.1, 0));
    } else if (keyCode == RIGHT) {
      pacman.queueTurn(new PVector(.1, 0));
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
  if (restart) {
    restart();
  }
  //Check for collisions with ghosts
  for (int i = 0; i<ghosts.size(); i++) {
    if (pacman.getPos().dist(ghosts.get(i).getPos())<.8) {
      if (ghosts.get(i).getPowerUp()>0) {
        ghosts.set(i, new Ghost(ghosts.get(i).getStartPos(), ghosts.get(i).getCol(), ghosts.get(i).getTime()));
        score+=100;
      } else {
        score = 0;
        restart();
      }
    }
  }
}
