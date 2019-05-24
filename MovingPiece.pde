abstract class MovingPiece { //<>//
  private float r, c;
  private int velR, velC;
  private int nextVelR, nextVelC;

  public MovingPiece(float r, float c, int velR, int velC) {
    this.r = r;
    this.c = c;
    this.velR = velR;
    this.velC = velC;
    nextVelR = velR;
    nextVelC = velC;
  }

  public float getR() {
    return r;
  }

  public float getC() {
    return c;
  }

  public void queueTurn(int velR, int velC) {
    nextVelR = velR;
    nextVelC = velC;
  }

  public void tick() {
    move();
  }

  private void move() {
    //Changed direction only if centered on the grid
    if ((int)r==r&&(int)c==c) {
      float testR = Math.round((r+nextVelR/10.0)*10.0)/10.0;
      float testC = Math.round((c+nextVelC/10.0)*10.0)/10.0;
      int posR = Math.round(testR);
      int posC = Math.round(testC);
      if ((!isWall(posR+1, posC) || posR+1-testR >= 1) && (!isWall(posR-1, posC) || posR-1-testR <= -1) &&(!isWall(posR, posC+1) || posC+1-testC >= 1) &&(!isWall(posR, posC-1) || posC-1-testC <= -1)) {
        velR= nextVelR;
        velC=nextVelC;
      }
    }

    //Check to see whether a move would put pacman into a wall
    float testR = Math.round((r+velR/10.0)*10.0)/10.0;
    float testC = Math.round((c+velC/10.0)*10.0)/10.0;
    int posR = Math.round(testR);
    int posC = Math.round(testC);
    if ((!isWall(posR+1, posC) || posR+1-testR >= 1) && (!isWall(posR-1, posC) || posR-1-testR <= -1) &&(!isWall(posR, posC+1) || posC+1-testC >= 1) &&(!isWall(posR, posC-1) || posC-1-testC <= -1)) {
      r=testR;
      c=testC;
    }
    println("TestR: "+testR);
    println("TestC: "+testC);
    println("PosR: "+posR);
    println("PosC: "+posC);
  }

  private boolean isWall(int testR, int testC) {
    if (!(testR<0||testC<0||testR>28||testC>25)) {
      return board[testR][testC]==0;
    }
    return true;
  }

  public abstract void draw();
}
