abstract class MovingPiece {
  private PVector pos;
  private PVector vel;

  public MovingPiece(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
  }

  public PVector getPos() {
    return pos;
  }

  public PVector getVel() {
    return vel;
  }

  public void setVel(PVector vel) {
    this.vel=vel;
  }
  
  public boolean isValidMove(PVector testVel) {
    //Check to see whether a move would put pacman into a wall
    float testX = Math.round((pos.x+testVel.x)*100.0)/100.0;
    float testY = Math.round((pos.y+testVel.y)*100.0)/100.0;
    int posX = Math.round(testX);
    int posY = Math.round(testY);
    if ((!isWall(posY+1, posX) || posY+1-testY >= 1) && (!isWall(posY-1, posX) || posY-1-testY <= -1) && (!isWall(posY, posX+1) || posX+1-testX >= 1) &&(!isWall(posY, posX-1) || posX-1-testX <= -1)) {
      return true;
    }
    return false;
  }
  boolean isWall(int testY, int testX) {
    if (!(testY<0||testX<0||testY>28||testX>25)) {
      return board[testY][testX]==0 || board[testY][testX]==4;
    }
    if ((testX == -1 || testX==26) && testY==13) {
      return false;
    }
    return true;
  }
  boolean isOnCenter(){
    return (int)pos.y==pos.y && (int)pos.x==pos.x;
  }
  public void move() {
    //Round off changes to avoid floating point errors
    pos.x= (int)(Math.round((pos.x+vel.x)*100.0))/100.0;
    pos.y= (int)(Math.round((pos.y+vel.y)*100.0))/100.0;

    //Teleport case
    if (pos.x <= -1 && vel.x<0) {
      pos.x = 25.9;
    } else if (pos.x>=26&&vel.x>0) {
      pos.x = -.9;
    }
  }

  

  public abstract void draw();
}
