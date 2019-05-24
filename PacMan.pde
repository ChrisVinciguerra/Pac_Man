class PacMan extends MovingPiece {
  public PacMan() {
    super(22, 12.5, 0, .1);
  }

  public void draw() {
    color(255, 255, 0);
    circle(getC()*gridSize+gridSize/2, getR()*gridSize+gridSize/2, gridSize/1.2);
  }
}
