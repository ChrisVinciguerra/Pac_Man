import java.util.Random;
import java.util.Arrays;
import java.util.Collections;

class Ghost extends MovingPiece {

  private color col;
  private int time;
  private int step;
  private int start;
  private int powerUp;

  public Ghost(PVector pos, color col, int time) {
    super(pos, new PVector(0, 0));
    this.col=col;
    this.time=time*1000;
    start = millis();
    step = 0;
    powerUp=0;
  }

  public color getCol() {
    return col;
  }

  public int getTime() {
    return time/1000;
  }

  public int getPowerUp() {
    return powerUp;
  }
  public void setPowerUp(int powerUp) {
    this.powerUp = powerUp;
  }


  //This method runs through "steps" of the ghost startup sequence to make sure they get out of the protected box before moving elsewhere
  public void tick() {
    switch(step) {
    case 0:
      //Waits until a certain time has passed to allow them to come out 1 by 1
      if (millis()-start>=time) {
        step++;
        setVel(new PVector(0, -.1));
      }
      break;
      //Moves up until it is out of protected territory
    case 1:
      if (isValidMove(getVel())) {
        move();
      } else {
        step++;
      }
      break;
    case 2:
      //Uses the algorithm to pick a move before moving
      ai();
      move();
    }
  }


  public void ai() {
    //Must come up with some sort of algorithm to decide where to go
    if ((int)getPos().x==getPos().x && (int)getPos().y==getPos().y) {
      PVector[] vectors = {new PVector(-getVel().y, -getVel().x), new PVector(getVel().y, getVel().x), new PVector(getVel().x, getVel().y) };
      ArrayList<PVector> vec = new ArrayList(Arrays.asList(vectors));
      Collections.shuffle(vec);
      //Higher numbers increase the intelligence of the ai
      if (Math.random()<.9) {
        for (int i = 0; i<vec.size(); i++) {
          if (isValidMove(vec.get(i)) && Math.abs(getPos().dist(pacman.getPos())) > Math.abs(PVector.add(getPos(), vec.get(i)).dist(pacman.getPos()))) {
            setVel(vec.get(i));
            return;
          }
        }
        for (int i = 0; i<vec.size(); i++) {
          if (isValidMove(vec.get(i))) {
            setVel(vec.get(i));
            return;
          }
        }
      } else {
        for (int i = 0; i<vec.size(); i++) {
          if (isValidMove(vec.get(i))) {
            setVel(vec.get(i));
            return;
          }
        }
      }
    }
  }


  public boolean isWall(int testY, int testX) {
    if (!(testY<0||testX<0||testY>28||testX>25)) {
      //Allow the ghost to move out of the protected zone
      if (step<2) {
        return board[testY][testX]==0;
      } else {
        //Ghost zone blocked
        return board[testY][testX]==0 || board[testY][testX]==4;
      }
    }
    //Special teleport case
    if ((testX == -1 || testX==26) && testY==13) {
      return false;
    }
    return true;
  }

  public void draw() {
    if (powerUp>0) {
      fill(color(0, 0, 160));
      stroke(color(0, 0, 160));
    } else {
      fill(col);
      stroke(col);
    }
    circle(getPos().x*gridSize+gridSize/2, getPos().y*gridSize+gridSize/2+50, gridSize/1.2);
  }
}
