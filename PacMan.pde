class PacMan extends MovingPiece {
  PVector nextVel;
  public PacMan() {
    super(new PVector(12.5, 22.0), new PVector(.1, 0));
    nextVel = new PVector(.1, 0);
  }

  public void tick() {
    if (isValidMove(nextVel)) {
      //Allows immediate turning around while only allowing turning right or left at corners
      if (PVector.add(nextVel, getVel()).dist(new PVector(0, 0))==0) {
        setVel(nextVel);
      } else if (isOnCenter()) {
        setVel(nextVel);
      }
    }
    if (isValidMove(getVel())) {
      move();
    }
    eat();
  }

  public void queueTurn(PVector nextVel) {
    this.nextVel = nextVel;
  }

  public void draw() {
    fill(255, 255, 0);
    circle(getPos().x*gridSize+gridSize/2, getPos().y*gridSize+gridSize/2+50, gridSize/1.2);
  }

  //Checks for being centered on a block
  private void eat() {
    if (isOnCenter()) {
      if (board[Math.round(getPos().y)][Math.round(getPos().x)]==2) {
         for(int i = 0; i< ghosts.size(); i++){
           ghosts.get(i).setPowerUp(1000/boardNumber);
         }
        score+=20;
      }
      if (board[Math.round(getPos().y)][Math.round(getPos().x)]==1) {
        score+=10;
      }
      board[(int)getPos().y][(int)getPos().x] = 3;
    }
  }
}
